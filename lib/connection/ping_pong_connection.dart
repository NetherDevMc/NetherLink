import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import '../util/Logger.dart';

class SocketHandler {
  final Logger logger;
  SocketHandler({required this.logger});

  static const int proxyPort = 19132;
  static const String serverName = 'NetherLink';
  static const int protocolVersion = 1;
  static const String gameVersion = '1';
  static const int onlinePlayers = 1;
  static const int maxPlayers = 10;
  static final BigInt serverId = BigInt.parse('18403264178514827767');
  static const String levelName = 'NetherLink';
  static const String gameMode = 'Survival';
  static const int gameModeId = 1;
  static const Duration clientTimeout = Duration(seconds: 30);
  static const Duration checkInterval = Duration(seconds: 5);

  static final List<int> magicBytes = [
    0x00,
    0xff,
    0xff,
    0x00,
    0xfe,
    0xfe,
    0xfe,
    0xfe,
    0xfd,
    0xfd,
    0xfd,
    0xfd,
    0x12,
    0x34,
    0x56,
    0x78,
  ];

  bool _broadcasting = false;
  InternetAddress? _remoteIp;
  int _remotePort = 19132;

  final Map<String, RawDatagramSocket> _clientSockets = {};
  final Map<String, InternetAddress> _clientAddresses = {};
  final Map<String, int> _clientPorts = {};

  final Map<String, DateTime> _clientLastActivity = {};
  Timer? _timeoutCheckTimer;

  Function()? onAllClientsDisconnected;

  void setBroadcasting(bool broadcasting) {
    _broadcasting = broadcasting;

    if (broadcasting) {
      _startTimeoutChecker();
    } else {
      _stopTimeoutChecker();
    }
  }

  void setRemoteIp(InternetAddress ip) {
    _remoteIp = ip;
  }

  void setRemotePort(int port) {
    _remotePort = port;
  }

  void _startTimeoutChecker() {
    _timeoutCheckTimer?.cancel();
    _timeoutCheckTimer = Timer.periodic(checkInterval, (_) {
      _checkClientTimeouts();
    });
    logger.debug('Client timeout checker started');
  }

  void _stopTimeoutChecker() {
    _timeoutCheckTimer?.cancel();
    _timeoutCheckTimer = null;
  }

  void _checkClientTimeouts() {
    if (_clientLastActivity.isEmpty) return;

    final now = DateTime.now();
    final disconnectedClients = <String>[];

    for (var entry in _clientLastActivity.entries) {
      final clientKey = entry.key;
      final lastActivity = entry.value;
      final inactiveDuration = now.difference(lastActivity);

      if (inactiveDuration > clientTimeout) {
        logger.info(
          'Client $clientKey timed out (inactive for ${inactiveDuration.inSeconds}s)',
        );
        disconnectedClients.add(clientKey);
      }
    }

    for (var clientKey in disconnectedClients) {
      _removeClient(clientKey);
    }

    if (_clientSockets.isEmpty && disconnectedClients.isNotEmpty) {
      logger.info('All clients disconnected');
      onAllClientsDisconnected?.call();
    }
  }

  void _removeClient(String clientKey) {
    _clientSockets[clientKey]?.close();
    _clientSockets.remove(clientKey);
    _clientAddresses.remove(clientKey);
    _clientPorts.remove(clientKey);
    _clientLastActivity.remove(clientKey);
    logger.debug('Removed client: $clientKey');
  }

  void _updateClientActivity(String clientKey) {
    _clientLastActivity[clientKey] = DateTime.now();
  }

  Uint8List _createOfflinePong(Uint8List pingPayload) {
    final serverGuid = ByteData(8);
    serverGuid.setUint64(0, serverId.toInt(), Endian.big);

    final motdFields = [
      'MCPE',
      serverName,
      protocolVersion.toString(),
      gameVersion,
      onlinePlayers.toString(),
      maxPlayers.toString(),
      serverId.toString(),
      levelName,
      gameMode,
      gameModeId.toString(),
      proxyPort.toString(),
      proxyPort.toString(),
    ];

    final motdString = '${motdFields.join(';')};';
    final motdBytes = utf8.encode(motdString);
    final motdLengthBytes = ByteData(2)
      ..setUint16(0, motdBytes.length, Endian.big);

    final builder = BytesBuilder();
    builder.add([0x1c]);
    builder.add(pingPayload);
    builder.add(serverGuid.buffer.asUint8List());
    builder.add(magicBytes);
    builder.add(motdLengthBytes.buffer.asUint8List());
    builder.add(motdBytes);

    return builder.toBytes();
  }

  void handleSocketEvent(RawDatagramSocket socket, RawSocketEvent event) {
    if (event != RawSocketEvent.read) return;

    final dg = socket.receive();
    if (dg == null) return;

    final clientKey = '${dg.address.address}:${dg.port}';
    final data = dg.data;
    if (data.isEmpty) return;

    _updateClientActivity(clientKey);

    if (data[0] == 0x01 && data.length >= 9) {
      final pingPayload = data.sublist(1, 9);
      final pongPacket = _createOfflinePong(Uint8List.fromList(pingPayload));
      socket.send(pongPacket, dg.address, dg.port);
      logger.debug('Responded to ping from $clientKey');
      return;
    }

    if (!_clientSockets.containsKey(clientKey)) {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((serverSocket) {
        _clientSockets[clientKey] = serverSocket;
        _clientAddresses[clientKey] = dg.address;
        _clientPorts[clientKey] = dg.port;
        _updateClientActivity(clientKey);

        logger.info('New client connected: $clientKey');

        serverSocket.listen((serverEvent) {
          if (serverEvent == RawSocketEvent.read) {
            final resp = serverSocket.receive();
            if (resp == null) return;

            socket.send(resp.data, dg.address, dg.port);
            _updateClientActivity(clientKey);

            logger.debug(
              '[SERVER → CLIENT] $_remoteIp:$_remotePort → $clientKey | ${resp.data.length} bytes',
            );
          }
        });

        if (_broadcasting && _remoteIp != null) {
          serverSocket.send(data, _remoteIp!, _remotePort);
          logger.debug(
            '[CLIENT → SERVER] $clientKey → $_remoteIp:$_remotePort | ${data.length} bytes',
          );
        }
      });
    } else {
      final clientSocket = _clientSockets[clientKey];
      if (clientSocket != null && _broadcasting && _remoteIp != null) {
        clientSocket.send(data, _remoteIp!, _remotePort);
        logger.debug(
          '[CLIENT → SERVER] $clientKey → $_remoteIp:$_remotePort | ${data.length} bytes',
        );
      }
    }

    if (_broadcasting && _remoteIp != null) {
      if (dg.address.address == _remoteIp!.address && dg.port == _remotePort) {
        for (var entry in _clientAddresses.entries) {
          final key = entry.key;
          final clientAddr = entry.value;
          final clientPort = _clientPorts[key]!;
          if (socket.address.type == clientAddr.type) {
            socket.send(data, clientAddr, clientPort);
            logger.debug(
              '[SERVER → CLIENT] $_remoteIp:$_remotePort → $key | ${data.length} bytes',
            );
          } else {
            logger.debug('Skipping send to $key due to IP version mismatch');
          }
        }
      }
    }
  }

  void closeAllClientSockets() {
    _stopTimeoutChecker();

    for (var socket in _clientSockets.values) {
      socket.close();
    }
    _clientSockets.clear();
    _clientAddresses.clear();
    _clientPorts.clear();
    _clientLastActivity.clear();
    logger.debug('All client sockets closed and cleared.');
  }

  bool get isBroadcasting => _broadcasting;

  int get activeClientCount => _clientSockets.length;
}

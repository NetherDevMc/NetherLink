import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../util/Logger.dart';
import 'ping_pong_connection.dart';
import 'relay_config_sender.dart';
import 'package:flutter/widgets.dart';

class BroadcastManager {
  late Logger logger;

  final SocketHandler socketHandler;

  RawDatagramSocket? _socketIPv4;
  RawDatagramSocket? _socketIPv6;

  StreamSubscription<RawSocketEvent>? _subscriptionIPv4;
  StreamSubscription<RawSocketEvent>? _subscriptionIPv6;

  Timer? _lanAdvertiseTimer;

  Function()? onAutoDisconnect;
  Function(String message)? onRelayError;

  BroadcastManager({required this.socketHandler, required this.logger}) {
    socketHandler.onAllClientsDisconnected = _handleAllClientsDisconnected;
  }

  bool get isBroadcasting => socketHandler.isBroadcasting;

  void _handleAllClientsDisconnected() {
    logger.info('No active clients, auto-stopping broadcast...');
    stopBroadcast();
    onAutoDisconnect?.call();
  }

  Future<List<String>> _getLocalIPAddresses() async {
    List<String> ipAddresses = [];
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 &&
              !addr.isLoopback &&
              !addr.isLinkLocal) {
            ipAddresses.add('${addr.address} (${interface.name})');
          }
        }
      }
    } catch (e) {
      logger.error('Error getting local IP addresses: $e');
    }
    return ipAddresses;
  }

  Future<List<InternetAddress>> _getBroadcastAddresses() async {
    final List<InternetAddress> broadcastAddresses = [];
    
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && 
              !addr.isLoopback && 
              !addr.isLinkLocal) {
            final ipParts = addr.address.split('.').map(int.parse).toList();
            
            final subnetBroadcast = '${ipParts[0]}.${ipParts[1]}.${ipParts[2]}.255';
            broadcastAddresses.add(InternetAddress(subnetBroadcast));
            
            logger.debug('Added broadcast address: $subnetBroadcast for ${addr.address}');
          }
        }
      }
    } catch (e) {
      logger.error('Error calculating broadcast addresses: $e');
    }
    
    return broadcastAddresses;
  }

  void _logLocalIPAddresses() async {
    final addresses = await _getLocalIPAddresses();
    if (addresses.isNotEmpty) {
      logger.info('═══════════════════════════════════════════');
      logger.info('📱 DEVICE IP ADDRESSES (for manual connection):');
      for (var addr in addresses) {
        logger.info(' IP: $addr');
      }
      logger.info(' Port: ${SocketHandler.proxyPort}');
      logger.info('═══════════════════════════════════════════');
    } else {
      logger.info('⚠️ Could not determine local IP addresses');
    }
  }

  void _startLanAdvertiser() {
    _lanAdvertiseTimer?.cancel();
    
    _lanAdvertiseTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (!socketHandler.isBroadcasting) {
          timer.cancel();
          return;
        }

        try {
          final pingPayload = Uint8List(8);
          ByteData.view(pingPayload.buffer).setInt64(
            0,
            DateTime.now().millisecondsSinceEpoch,
            Endian.big,
          );

          final pongPacket = socketHandler.createOfflinePong(pingPayload);

          int sentCount = 0;

          if (_socketIPv4 != null) {
            try {
              _socketIPv4!.send(
                pongPacket,
                InternetAddress('255.255.255.255'),
                SocketHandler.proxyPort,
              );
              sentCount++;
              logger.debug('📡 IPv4 global broadcast sent (255.255.255.255)');
            } catch (e) {
              logger.debug('Failed to send global broadcast: $e');
            }
          }

          if (_socketIPv4 != null) {
            final subnetBroadcasts = await _getBroadcastAddresses();
            for (var broadcastAddr in subnetBroadcasts) {
              try {
                _socketIPv4!.send(
                  pongPacket,
                  broadcastAddr,
                  SocketHandler.proxyPort,
                );
                sentCount++;
                logger.debug('📡 IPv4 subnet broadcast sent (${broadcastAddr.address})');
              } catch (e) {
                logger.debug('Failed to send subnet broadcast to ${broadcastAddr.address}: $e');
              }
            }
          }

          if (_socketIPv6 != null) {
            try {
              _socketIPv6!.send(
                pongPacket,
                InternetAddress('ff02::1'),
                SocketHandler.proxyPort,
              );
              sentCount++;
              logger.debug('📡 IPv6 link-local multicast sent (ff02::1)');
            } catch (e) {
              logger.debug('Failed to send IPv6 link-local multicast: $e');
            }

            try {
              _socketIPv6!.send(
                pongPacket,
                InternetAddress('ff05::1'),
                SocketHandler.proxyPort,
              );
              sentCount++;
              logger.debug('📡 IPv6 site-local multicast sent (ff05::1)');
            } catch (e) {
              logger.debug('Failed to send IPv6 site-local multicast: $e');
            }
          }

          if (sentCount > 0) {
            logger.debug('📡 Total broadcasts sent: $sentCount');
          } else {
            logger.warning('⚠️ No broadcasts could be sent');
          }

        } catch (e) {
          logger.error('Error in LAN advertiser: $e');
        }
      },
    );

    logger.info('📡 LAN advertiser started (IPv4 + IPv6, multi-target, every 1s)');
  }

  void _stopLanAdvertiser() {
    _lanAdvertiseTimer?.cancel();
    _lanAdvertiseTimer = null;
    logger.debug('📡 LAN advertiser stopped');
  }

  Future<bool> startBroadcast(
    String remoteHost,
    int remotePort,
    String username,
  ) async {
    const String RELAY_IP = '161.97.182.113';
    const int RELAY_CLIENT_PORT = 19132;
    const int RELAY_CONFIG_PORT = 19133;

    try {
      logger.info('Sending config to NetherLink server...');

      final success = await RelayConfigSender.sendConfigSimple(
        relayIp: RELAY_IP,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
        bedrockUsername: username,
      );

      if (!success) {
        logger.error('Failed to connect to NetherLink relay server');
        logger.error('The relay server might be offline or unreachable');
        onRelayError?.call(
          'Unable to connect to NetherLink relay server. Please check your internet connection or try again later.',
        );
        return false;
      }

      await Future.delayed(Duration(milliseconds: 200));

      final relayAddress = InternetAddress(RELAY_IP);

      logger.info('Connecting to NetherLink servers');
      logger.info(
        'NetherLink will forward to $remoteHost:$remotePort for user: $username',
      );

      socketHandler.setRemoteIp(relayAddress);
      socketHandler.setRemotePort(RELAY_CLIENT_PORT);

      _socketIPv4 = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        SocketHandler.proxyPort,
      );
      _socketIPv6 = await RawDatagramSocket.bind(
        InternetAddress.anyIPv6,
        SocketHandler.proxyPort,
      );

      _socketIPv4!.broadcastEnabled = true;
      _socketIPv6!.broadcastEnabled = true;

      if (_socketIPv6 != null) {
        try {
          _socketIPv6!.setRawOption(RawSocketOption(
            41,
            18,
            Uint8List.fromList([255]),
          ));
          logger.debug('IPv6 multicast hops set to 255');
        } catch (e) {
          logger.debug('Could not set IPv6 multicast hops: $e');
        }

        try {
          _socketIPv6!.setRawOption(RawSocketOption(
            41,
            19,
            Uint8List.fromList([1]),
          ));
          logger.debug('IPv6 multicast loopback enabled');
        } catch (e) {
          logger.debug('Could not set IPv6 multicast loopback: $e');
        }
      }

      socketHandler.setBroadcasting(true);

      _subscriptionIPv4 = _socketIPv4!.listen(
        (event) => socketHandler.handleSocketEvent(_socketIPv4!, event),
      );
      _subscriptionIPv6 = _socketIPv6!.listen(
        (event) => socketHandler.handleSocketEvent(_socketIPv6!, event),
      );

      logger.info('NetherLink started broadcasting');

      _startLanAdvertiser();

      _logLocalIPAddresses();

      return true;
    } catch (e) {
      logger.error('Error starting broadcast: $e');
      stopBroadcast();
      onRelayError?.call('Failed to start broadcast: $e');
      return false;
    }
  }

  Future<void> stopBroadcast() async {
    _stopLanAdvertiser();

    await _subscriptionIPv4?.cancel();
    await _subscriptionIPv6?.cancel();

    _subscriptionIPv4 = null;
    _subscriptionIPv6 = null;

    _socketIPv4?.close();
    _socketIPv6?.close();

    _socketIPv4 = null;
    _socketIPv6 = null;

    socketHandler.closeAllClientSockets();
    socketHandler.setBroadcasting(false);

    logger.info('NetherLink stopped.');

    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      try {
        await WakelockPlus.disable();
      } catch (e) {
        logger.error('WakelockPlus disable error: $e');
      }
    } else {
      logger.debug('Wakelock not disabled: no foreground activity.');
    }
  }
}
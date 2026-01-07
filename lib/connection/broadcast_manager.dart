import 'dart:async';
import 'dart:io';
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

  Function()? onAutoDisconnect;

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

  Future<void> startBroadcast(
    String remoteHost,
    int remotePort,
    String username,
  ) async {
    const String RELAY_IP = '161.97.182.113';
    const int RELAY_CLIENT_PORT = 19132;
    const int RELAY_CONFIG_PORT = 19133;

    try {
      logger.info('Sending config to NetherLink server...');
      await RelayConfigSender.sendConfigSimple(
        relayIp: RELAY_IP,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
        bedrockUsername: username,
      );

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

      socketHandler.setBroadcasting(true);

      _subscriptionIPv4 = _socketIPv4!.listen(
        (event) => socketHandler.handleSocketEvent(_socketIPv4!, event),
      );
      _subscriptionIPv6 = _socketIPv6!.listen(
        (event) => socketHandler.handleSocketEvent(_socketIPv6!, event),
      );

      logger.info('NetherLink started broadcasting');

      _logLocalIPAddresses();
    } catch (e) {
      logger.error('Error starting broadcast: $e');
      stopBroadcast();
    }
  }

  Future<void> stopBroadcast() async {
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

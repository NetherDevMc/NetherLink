import 'dart:async';
import 'dart:io';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../util/Logger.dart';
import '../constants/app_constants.dart';
import 'socket_handler.dart';
import 'relay_config_sender.dart';
import 'package:flutter/widgets.dart';

class BroadcastManager {
  late Logger logger;

  final SocketHandler socketHandler;

  RawDatagramSocket? _socketIPv4;
  StreamSubscription<RawSocketEvent>? _subscriptionIPv4;

  bool _isBroadcasting = false;

  Function()? onAutoDisconnect;
  Function(String message)? onRelayError;

  BroadcastManager({required this.socketHandler, required this.logger}) {
    socketHandler.onAllClientsDisconnected = _handleAllClientsDisconnected;
  }

  bool get isBroadcasting => _isBroadcasting;

  void _handleAllClientsDisconnected() {
    logger.info('No active clients, auto-stopping broadcast...');
    stopBroadcast();
    onAutoDisconnect?.call();
  }

  Future<List<String>> _getLocalIPAddresses() async {
    List<String> ipAddresses = [];
    try {
      for (var interface in await NetworkInterface.list(
        includeLinkLocal: false,
        type: InternetAddressType.IPv4,
      )) {
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

  Future<bool> sendRelayConfigOnly(
    String remoteHost,
    int remotePort, {
    String? relayIp,
  }) async {
    final usedRelayIp = relayIp ?? AppConstants.relayServers[0]['ip']!;
    const int RELAY_CONFIG_PORT = 19133;

    try {
      logger.info(
        'Sending config (DNS mode) to NetherLink server at $usedRelayIp...',
      );

      final success = await RelayConfigSender.sendConfigSimple(
        relayIp: usedRelayIp,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
      );

      if (!success) {
        logger.error('Failed to connect to NetherLink relay server');
        onRelayError?.call(
          'Unable to connect to NetherLink relay server. Try to use a different NetherLink Server.',
        );
        return false;
      }

      logger.info('✅ Config sent successfully (DNS mode).');
      return true;
    } catch (e) {
      logger.error('Error sending config (DNS mode): $e');
      onRelayError?.call('Failed to send config: $e');
      return false;
    }
  }

  Future<bool> startBroadcast(
    String remoteHost,
    int remotePort, {
    String? relayIp,
  }) async {
    final usedRelayIp = relayIp ?? AppConstants.relayServers[0]['ip']!;
    const int RELAY_CLIENT_PORT = 19132;
    const int RELAY_CONFIG_PORT = 19133;

    try {
      logger.info('Sending config to NetherLink server at $usedRelayIp...');

      final success = await RelayConfigSender.sendConfigSimple(
        relayIp: usedRelayIp,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
      );

      if (!success) {
        logger.error('Failed to connect to NetherLink relay server');
        onRelayError?.call(
          'Unable to connect to NetherLink relay server. Try to use a different NetherLink Server.',
        );
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 200));

      final relayAddress = InternetAddress(usedRelayIp);

      logger.info('Connecting to NetherLink servers');
      logger.info('NetherLink will forward to $remoteHost:$remotePort');

      socketHandler.setRemoteIp(relayAddress);
      socketHandler.setRemotePort(RELAY_CLIENT_PORT);

      await stopBroadcast();

      _socketIPv4 = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        SocketHandler.proxyPort,
      );
      _socketIPv4!.broadcastEnabled = true;
      logger.info(
        'UDP broadcast socket started on 0.0.0.0 (${SocketHandler.proxyPort})',
      );

      socketHandler.setBroadcasting(true);

      _subscriptionIPv4 = _socketIPv4!.listen(
        (event) => socketHandler.handleSocketEvent(_socketIPv4!, event),
        onError: (e, st) => logger.error('Socket error: $e'),
        cancelOnError: false,
      );

      _isBroadcasting = true;
      logger.info('NetherLink started broadcasting');
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
    await _subscriptionIPv4?.cancel();
    _subscriptionIPv4 = null;

    _socketIPv4?.close();
    _socketIPv4 = null;

    socketHandler.closeAllClientSockets();
    socketHandler.setBroadcasting(false);

    _isBroadcasting = false;
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

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

  String _relayNameForIp(String ip) {
    final relay = AppConstants.relayServers.firstWhere(
      (e) => e['ip'] == ip,
      orElse: () => {'name': ip},
    );
    return relay['name'] ?? ip;
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
    final List<String> relayIps = relayIp != null && relayIp.isNotEmpty
        ? [
            relayIp,
            ...AppConstants.relayServers
                .map((e) => e['ip'] as String)
                .where((ip) => ip != relayIp),
          ]
        : AppConstants.relayServers.map((e) => e['ip'] as String).toList();
    const int RELAY_CONFIG_PORT = 19133;

    for (int i = 0; i < relayIps.length; i++) {
      final usedRelayIp = relayIps[i];
      final usedRelayName = _relayNameForIp(usedRelayIp);
      logger.info(
        'Sending config (DNS mode) to NetherLink server "$usedRelayName" ($usedRelayIp)...',
      );

      final success = await RelayConfigSender.sendConfigSimple(
        relayIp: usedRelayIp,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
      );

      if (success) {
        logger.info(
          '✅ Config sent successfully (DNS mode) to "$usedRelayName".',
        );
        if (i > 0) {
          logger.warning(
            '⚠️ First relay(s) failed; using fallback relay: "$usedRelayName"',
          );
          onRelayError?.call(
            "Warning: original relay did not respond. Fallback relay in use: $usedRelayName",
          );
        }
        return true;
      } else {
        logger.warning(
          'Relay config to "$usedRelayName" ($usedRelayIp) failed.',
        );
      }
    }

    logger.error('FAILED to connect to any NetherLink relay server');
    onRelayError?.call(
      'Unable to connect to ANY NetherLink relay server. Try again later or check your internet.',
    );
    return false;
  }

  Future<bool> startBroadcast(
    String remoteHost,
    int remotePort, {
    String? relayIp,
    bool isJava = false,
  }) async {
    final List<String> relayIps = relayIp != null && relayIp.isNotEmpty
        ? [
            relayIp,
            ...AppConstants.relayServers
                .map((e) => e['ip'] as String)
                .where((ip) => ip != relayIp),
          ]
        : AppConstants.relayServers.map((e) => e['ip'] as String).toList();

    final int relayClientPort = isJava ? 19134 : 19132;
    const int RELAY_CONFIG_PORT = 19133;

    for (int i = 0; i < relayIps.length; i++) {
      final usedRelayIp = relayIps[i];
      final usedRelayName = _relayNameForIp(usedRelayIp);
      logger.info(
        'Sending config to NetherLink server "$usedRelayName" ($usedRelayIp)...',
      );

      final success = await RelayConfigSender.sendConfigSimple(
        relayIp: usedRelayIp,
        relayConfigPort: RELAY_CONFIG_PORT,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
      );

      if (success) {
        await Future.delayed(const Duration(milliseconds: 200));
        final relayAddress = InternetAddress(usedRelayIp);

        logger.info('Connecting to NetherLink servers');
        logger.info('NetherLink will forward to $remoteHost:$remotePort');
        if (isJava) logger.info('Java mode: using relay port $relayClientPort');

        socketHandler.setRemoteIp(relayAddress);
        socketHandler.setRemotePort(relayClientPort);

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

        if (i > 0) {
          logger.warning(
            '⚠️ First relay(s) failed; using fallback relay: "$usedRelayName"',
          );
          onRelayError?.call(
            "Warning: original relay did not respond. Fallback relay in use: $usedRelayName",
          );
        }

        return true;
      } else {
        logger.warning(
          'Relay config to "$usedRelayName" ($usedRelayIp) failed.',
        );
      }
    }

    logger.error('FAILED to connect to any NetherLink relay server');
    onRelayError?.call(
      'Unable to connect to ANY NetherLink relay server. Try again later or check your internet.',
    );
    return false;
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

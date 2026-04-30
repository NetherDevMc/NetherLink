import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../util/Logger.dart';
import '../constants/app_constants.dart';
import 'socket_handler.dart';
import 'relay_config_sender.dart';
import 'package:flutter/widgets.dart';
import 'broadcast_mode.dart';
import '../util/relay_helper.dart';

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
      logger.info('══════════════════════════════════════════');
      logger.info('📱 DEVICE IP ADDRESSES (for manual connection):');
      for (var addr in addresses) {
        logger.info(' IP: $addr');
      }
      logger.info(' Port: ${SocketHandler.proxyPort}');
      logger.info('══════════════════════════════════════════');
    } else {
      logger.info('⚠️ Could not determine local IP addresses');
    }
  }

  String _formatRelayErrorMessage(int statusCode, String responseBody) {
    if (statusCode == 403) {
      try {
        final parsed = json.decode(responseBody);
        if (parsed is Map &&
            parsed['message'] != null &&
            (parsed['message'] as String).trim().isNotEmpty) {
          final reason = (parsed['message'] as String).trim();
          return 'Your IP/account has been blocked by NetherLink.\nReason: $reason\nIf you believe this is a mistake, join our discord.';
        }
      } catch (_) {}
      return 'Your IP/account has been blocked by NetherLink. If you believe this is a mistake, join our discord.';
    }

    final bodySnippet = (responseBody.isNotEmpty && responseBody.length <= 200)
        ? ' — ${responseBody.replaceAll('\n', ' ')}'
        : '';
    return 'Could not configure relay (status $statusCode)$bodySnippet. Try another relay or join our discord.';
  }

  Future<bool> sendRelayConfigOnly(
    String remoteHost,
    int remotePort, {
    String? relayIp,
    required BroadcastMode mode,
  }) async {
    if (relayIp == null || relayIp.isEmpty) {
      logger.error('sendRelayConfigOnly called without relayIp — aborting.');
      onRelayError?.call('No relay selected.');
      return false;
    }

    final usedRelayIp = relayIp;
    final usedRelayName = _relayNameForIp(usedRelayIp);
    final usedApiBase = RelayHelper.apiBaseFor(usedRelayIp);

    logger.info(
      'Sending config (DNS mode) to NetherLink server "$usedRelayName" ($usedRelayIp) via API $usedApiBase...',
    );

    try {
      final result = await RelayConfigSender.sendConfigSimple(
        base: usedApiBase,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
        mode: mode,
      );

      if (result.success) {
        logger.info(
          '✅ Config sent successfully (DNS mode) to "$usedRelayName".',
        );
        return true;
      } else {
        final userMessage = _formatRelayErrorMessage(
          result.statusCode,
          result.body,
        );
        logger.error(
          'Relay rejected request (status ${result.statusCode}): ${result.body}',
        );
        onRelayError?.call(userMessage);
        return false;
      }
    } on TimeoutException catch (te) {
      logger.warning('Timeout when sending config to $usedApiBase: $te');
      onRelayError?.call('Timeout contacting relay.');
      return false;
    } catch (e, st) {
      logger.error('Error sending config to $usedApiBase: $e\n$st');
      onRelayError?.call('Error contacting relay.');
      return false;
    }
  }

  Future<bool> startBroadcast(
    String remoteHost,
    int remotePort, {
    String? relayIp,
    bool isJava = false,
    required BroadcastMode mode,
  }) async {
    if (relayIp == null || relayIp.isEmpty) {
      logger.error('startBroadcast called without relayIp — aborting.');
      onRelayError?.call('No relay selected.');
      return false;
    }

    final usedRelayIp = relayIp;
    final usedRelayName = _relayNameForIp(usedRelayIp);
    final usedApiBase = RelayHelper.apiBaseFor(usedRelayIp);

    logger.info(
      'Sending config to NetherLink server "$usedRelayName" (socket target: $usedRelayIp) via API $usedApiBase...',
    );

    try {
      final result = await RelayConfigSender.sendConfigSimple(
        base: usedApiBase,
        remoteServerIp: remoteHost,
        remoteServerPort: remotePort,
        mode: mode,
      );

      if (!result.success) {
        final userMessage = _formatRelayErrorMessage(
          result.statusCode,
          result.body,
        );
        logger.error(
          'Relay rejected request (status ${result.statusCode}): ${result.body}',
        );
        onRelayError?.call(userMessage);
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 200));

      final relayAddress = InternetAddress(usedRelayIp);
      logger.info(
        'Connecting to NetherLink servers (UDP target: ${relayAddress.address})',
      );
      logger.info('NetherLink will forward to $remoteHost:$remotePort');
      final int relayClientPort = isJava ? 19132 : 19140;
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

      return true;
    } on TimeoutException catch (te) {
      logger.warning('Timeout when sending config to $usedApiBase: $te');
      onRelayError?.call('Timeout contacting relay.');
      return false;
    } catch (e, st) {
      logger.error('Error sending config to $usedApiBase: $e\n$st');
      onRelayError?.call('Error contacting relay.');
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

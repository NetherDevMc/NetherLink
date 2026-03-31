import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../l10n/app_localizations.dart';
import '../network/socket_handler.dart';
import '../network/broadcast_manager.dart';
import '../util/Logger.dart';
import '../util/user_servers.dart';
import '../util/user_servers_storage.dart';
import '../util/relay_preference_storage.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/connection/connection_panel.dart';
import '../widgets/dialogs/manage_servers_dialog.dart';
import '../widgets/components/global_notice_banner.dart';
import '../services/notification_service.dart';

import '../widgets/navigation/bottom_nav_bar.dart';
import '../widgets/navigation/howto_menu.dart';
import '../widgets/navigation/help_menu.dart';
import '../services/navigation_controller.dart';
import '../services/locale_provider.dart';

import '../widgets/dialogs/info_dialog.dart';
import '../widgets/dialogs/howto_dialogs.dart';
import '../widgets/dialogs/help_dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final SocketHandler socketHandler;
  late final BroadcastManager _broadcastManager;
  late final Logger logger;

  late AnimationController _bgController;
  late Animation<double> _bgAnimation;

  final ValueNotifier<bool> _debugEnabledNotifier = ValueNotifier<bool>(false);

  bool _nintendoDnsMode = false;

  Map<String, String>? _currentNotice;
  Timer? _noticeTimer;

  final TextEditingController _ipController = TextEditingController(
    text: AppConstants.defaultServerAddress,
  );
  final TextEditingController _portController = TextEditingController(
    text: SocketHandler.proxyPort.toString(),
  );

  final ScrollController _scroll_controller = ScrollController();
  final ScrollController _mainScrollController = ScrollController();

  final ValueNotifier<List<String>> _logsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _broadcastingNotifier = ValueNotifier(false);
  final ValueNotifier<List<UserServer>> _userServersNotifier = ValueNotifier(
    [],
  );

  String? _selectedRelayIp = AppConstants.relayServers[0]['ip'];

  late final NavigationController navigationController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _bgAnimation = CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeInOut,
    );

    _initializeComponents();
    _loadUserServers();
    _loadRelayServerPreference();
    _fetchNotification();

    navigationController = NavigationController(
      websiteUrl: AppConstants.websiteUrl,
      discordUrl: AppConstants.discordUrl,
      appLocaleNotifier: appLocale,
      logsNotifier: _logsNotifier,
      logsScrollController: _scroll_controller,
      debugEnabledNotifier: _debugEnabledNotifier,
      toggleDebugCallback: () async {
        _toggleDebugMode();
      },
      copyLogsCallback: () async {
        await _copyLogsToClipboard();
      },
      clearLogsCallback: () {
        _clearLogs();
      },
      showDnsInfoModalCallback: (ctx, {required bool isFriendsMode}) async {
        await _showDnsInfoModal(isFriendsMode: isFriendsMode);
      },
      showXboxHelpCallback: _showXboxHelp,
      showHowToMenuCallback: (ctx) {
        HowToMenu.show(
          ctx,
          onXbox: _showXboxHelp,
          onNintendo: () => _showDnsInfoModal(isFriendsMode: false),
          onFriends: () => _showDnsInfoModal(isFriendsMode: true),
        );
      },
      showHelpMenuCallback: (ctx) {
        HelpMenu.show(
          ctx,
          onNetherLink: () => HelpDialogs.showNetherlinkNotAppearing(ctx),
          onMultiplayerFailed: () =>
              HelpDialogs.showMultiplayerConnectionFailed(ctx),
          onNintendoDns: () => HelpDialogs.showNintendoDns(ctx),
          onFriendsMode: () => HelpDialogs.showFriendsMode(ctx),
        );
      },
    );
  }

  @override
  void dispose() {
    _noticeTimer?.cancel();
    _bgController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _logsNotifier.dispose();
    _broadcastingNotifier.dispose();
    _debugEnabledNotifier.dispose();
    navigationController.consoleOpen.dispose();
    _user_servers_dispose();
    _stopBroadcast();
    super.dispose();
  }

  void _user_servers_dispose() {}

  Future<void> _fetchNotification() async {
    final notice = await NotificationService.fetchNotice();
    if (mounted && notice != null) {
      setState(() => _currentNotice = notice);

      _noticeTimer?.cancel();
      _noticeTimer = Timer(const Duration(seconds: 20), () {
        if (mounted) {
          setState(() => _currentNotice = null);
        }
      });
    }
  }

  Future<void> _loadRelayServerPreference() async {
    final savedIp = await RelayPreferenceStorage.loadSelectedRelayIp();
    if (savedIp != null &&
        AppConstants.relayServers.any((e) => e['ip'] == savedIp)) {
      setState(() => _selectedRelayIp = savedIp);
    }
  }

  void _initializeComponents() {
    logger = Logger(
      debugEnabled: _debugEnabledNotifier.value,
      logCallback: _log,
    );
    socketHandler = SocketHandler(logger: logger);
    _broadcast_manager_init();
  }

  void _broadcast_manager_init() {
    _broadcastManager = BroadcastManager(
      socketHandler: sockethandler_get(),
      logger: logger,
    );
    _broadcastManager.onAutoDisconnect = _handleAutoDisconnect;
    _broadcastManager.onRelayError = _handleRelayError;
  }

  SocketHandler sockethandler_get() => socketHandler;

  void _handleAutoDisconnect() {
    if (!mounted) return;
    setState(() => _broadcastingNotifier.value = false);
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                loc.clientDisconnected,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.info,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: loc.ok,
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    logger.info('Auto-disconnect: All clients inactive');
  }

  void _handleRelayError(String message) {
    if (!mounted) return;
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: AppTheme.error,
        duration: const Duration(seconds: 6),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: loc.ok,
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _loadUserServers() async {
    try {
      final servers = await UserServersStorage.loadServers();
      if (servers.isNotEmpty) {
        logger.debug('Loaded ${servers.length} saved server(s)');
      }
      _userServersNotifier.value = servers;
    } catch (e) {
      logger.error('Failed to load user servers: $e');
    }
  }

  void _log(String message) {
    final currentLogs = List<String>.from(_logsNotifier.value);
    currentLogs.add(message);
    if (currentLogs.length > AppConstants.maxLogEntries) {
      currentLogs.removeRange(
        0,
        currentLogs.length - AppConstants.maxLogEntries,
      );
    }
    _logsNotifier.value = currentLogs;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll_controller.hasClients && mounted) {
        _scroll_controller_scrollToEnd();
      }
    });
  }

  void _scroll_controller_scrollToEnd() {
    _scroll_controller.animateTo(
      _scroll_controller.position.maxScrollExtent,
      duration: AppConstants.animationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _copyLogsToClipboard() async {
    final loc = AppLocalizations.of(context)!;
    final logs = _logsNotifier.value;
    if (logs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.noLogsToCopy),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    await Clipboard.setData(ClipboardData(text: logs.join('\n')));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(loc.copiedLogs(logs.length)),
          ],
        ),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleDebugMode() {
    final loc = AppLocalizations.of(context)!;
    final newVal = !_debugEnabledNotifier.value;
    _debugEnabledNotifier.value = newVal;
    setState(() {});
    logger.debugEnabled = newVal;
    logger.info('Debug mode ${newVal ? "enabled" : "disabled"}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              newVal ? Icons.bug_report : Icons.bug_report_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(newVal ? loc.debugEnabled : loc.debugDisabled),
          ],
        ),
        backgroundColor: newVal ? AppTheme.success : AppTheme.textMuted,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearLogs() {
    _logsNotifier.value = [];
    logger.info('Console cleared');
  }

  Map<String, String?> _getRelayMeta(String? ip) {
    for (final srv in AppConstants.relayServers) {
      if (srv['ip'] == ip) return {'name': srv['name'], 'ip': srv['ip']};
    }
    return {'name': 'Relay', 'ip': ip};
  }

  Future<void> _startBroadcast(PanelMode mode) async {
    final loc = AppLocalizations.of(context)!;
    final remoteHost = _ipController.text.trim();
    final remotePortParsed = int.tryParse(_port_controller_get().text);

    if (remoteHost.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.pleaseEnterServer),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    if (remotePortParsed == null ||
        remotePortParsed < 1 ||
        remotePortParsed > 65535) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.invalidPort), backgroundColor: Colors.red),
      );
      return;
    }

    if (mode == PanelMode.nintendo || mode == PanelMode.friends) {
      final ok = await _broadcastManager.sendRelayConfigOnly(
        remoteHost,
        remotePortParsed,
        relayIp: _selectedRelayIp,
      );
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.dnsConfigSent),
            backgroundColor: AppTheme.primaryAccent,
            duration: const Duration(seconds: 2),
          ),
        );
        await _showDnsInfoModal(isFriendsMode: mode == PanelMode.friends);
      }
      return;
    }

    logger.info('Starting NetherLink');
    try {
      await WakelockPlus.enable();
    } catch (e) {
      logger.error('Failed to enable wakelock: $e');
    }

    final success = await _broadcastManager.startBroadcast(
      remoteHost,
      remotePortParsed,
      relayIp: _selectedRelayIp,
    );
    _broadcastingNotifier.value = _broadcast_manager_isBroadcasting();

    if (_broadcastManager.isBroadcasting && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)!.broadcastingStarted),
            ],
          ),
          backgroundColor: AppTheme.primaryAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  bool _broadcast_manager_isBroadcasting() => _broadcastManager.isBroadcasting;

  Future<void> _stopBroadcast() async {
    await _broadcast_manager_stop();
  }

  Future<void> _broadcast_manager_stop() async {
    await _broadcastManager.stopBroadcast();
    _broadcastingNotifier.value = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.broadcastStopped),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onUserServerSelected(UserServer server) {
    setState(() {
      _ip_controller_set_text(server.address);
      _port_controller_set_text(server.port.toString());
    });
    logger.info('Selected saved server: ${server.name}');
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.selectedServer(server.name)),
        duration: const Duration(seconds: 1),
        backgroundColor: AppTheme.primaryAccentDark,
      ),
    );
  }

  void _ip_controller_set_text(String text) => _ipController.text = text;
  void _port_controller_set_text(String text) => _portController.text = text;

  Future<void> _showManageServersDialog() async {
    await showDialog(
      context: context,
      builder: (context) => const ManageServersDialog(),
    );
    _loadUserServers();
  }

  void _showXboxHelp() {
    HowToDialogs.showXboxInstructions(context);
  }

  Future<void> _showDnsInfoModal({required bool isFriendsMode}) async {
    final loc = AppLocalizations.of(context)!;
    final meta = _getRelayMeta(_selectedRelayIp);
    final relayName = meta['name'] ?? '-';
    final relayIp = meta['ip'] ?? '-';

    String friend = '';
    if (relayName == "EU Server") {
      friend = 'NetherLinkEU';
    } else if (relayName == "US Server") {
      friend = 'NetherLinkUS';
    }

    final title = isFriendsMode
        ? loc.playWithFriendsTitle
        : loc.playOnSwitchTitle;
    final content = isFriendsMode
        ? loc.playInstructionsFriends(friend)
        : loc.playInstructionsSwitch(relayName, relayIp);

    await InfoDialog.show(
      context,
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            loc.iUnderstand,
            style: TextStyle(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(0, 92, 24, 24),
      body: AnimatedBuilder(
        animation: _bgAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF0A0A1A),
                    const Color(0xFF0D0D20),
                    _bgAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0D0A1F),
                    const Color(0xFF12091A),
                    _bgAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF080D1A),
                    const Color(0xFF0A1020),
                    _bgAnimation.value,
                  )!,
                ],
              ),
            ),
            child: Stack(
              children: [
                _ambientBlob(
                  top: -100,
                  left: -80,
                  size: 350,
                  color: AppTheme.primaryAccent,
                  opacity: 0.06 + (_bgAnimation.value * 0.03),
                ),
                _ambientBlob(
                  bottom: 50,
                  right: -60,
                  size: 280,
                  color: Colors.purpleAccent,
                  opacity: 0.04 + (_bgAnimation.value * 0.02),
                ),
                _ambientBlob(
                  top: 200,
                  right: 40,
                  size: 200,
                  color: Colors.blueAccent,
                  opacity: 0.03 + (_bgAnimation.value * 0.015),
                ),
                child!,
              ],
            ),
          );
        },
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 8),
              if (_currentNotice != null)
                GlobalNoticeBanner(
                  message: _currentNotice!['message']!,
                  type: _currentNotice!['type'] ?? 'info',
                  onDismiss: () {
                    _noticeTimer?.cancel();
                    setState(() => _currentNotice = null);
                  },
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return _buildMobileLayout();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomGlassSimpleNavBar(
        navigationController: navigationController,
        dark: true,
      ),
    );
  }

  Widget _ambientBlob({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
    required double opacity,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(opacity),
                blurRadius: size,
                spreadRadius: size * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionPanel(List<UserServer> userServers) {
    return ConnectionPanel(
      ipController: _ip_controller_get(),
      portController: _port_controller_get(),
      broadcastingNotifier: _broadcastingNotifier,
      onStartBroadcast: (mode) => _startBroadcast(mode),
      onStopBroadcast: _stopBroadcast,
      savedServers: userServers,
      onServerSelected: _onUserServerSelected,
      onManageServers: _showManageServersDialog,
      selectedRelayIp: _selectedRelayIp,
      onRelayChanged: (ip) {
        setState(() => _selectedRelayIp = ip);
        RelayPreferenceStorage.saveSelectedRelayIp(ip);
      },
      nintendoDnsMode: _nintendoDnsMode,
      onNintendoDnsModeChanged: (value) =>
          setState(() => _nintendoDnsMode = value),
    );
  }

  TextEditingController _port_controller_get() => _portController;
  TextEditingController _ip_controller_get() => _ipController;

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _mainScrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<List<UserServer>>(
            valueListenable: _user_servers_notifier_get(),
            builder: (context, userServers, _) =>
                _buildConnectionPanel(userServers),
          ),
        ],
      ),
    );
  }

  ValueNotifier<List<UserServer>> _user_servers_notifier_get() =>
      _userServersNotifier;
}

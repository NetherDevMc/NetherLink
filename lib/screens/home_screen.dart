import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/socket_handler.dart';
import '../network/broadcast_manager.dart';
import '../util/Logger.dart';
import '../util/user_servers.dart';
import '../util/user_servers_storage.dart';
import '../util/relay_preference_storage.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/connection/connection_panel.dart';
import '../widgets/console/console_widget.dart';
import '../widgets/dialogs/manage_servers_dialog.dart';
import '../widgets/dialogs/support_dialog.dart';
import '../services/github_update_service.dart';
import '../widgets/dialogs/update_dialog.dart';

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

  bool _debugEnabled = false;
  bool _consoleDialogOpen = false;
  bool _nintendoDnsMode = false;

  final TextEditingController _ipController = TextEditingController(
    text: AppConstants.defaultServerAddress,
  );
  final TextEditingController _portController = TextEditingController(
    text: SocketHandler.proxyPort.toString(),
  );

  final ScrollController _scrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _desktopScrollController = ScrollController();

  final ValueNotifier<List<String>> _logsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _broadcastingNotifier = ValueNotifier(false);
  final ValueNotifier<List<UserServer>> _userServersNotifier = ValueNotifier(
    [],
  );

  String? _selectedRelayIp = AppConstants.relayServers[0]['ip'];

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

    if (Platform.isWindows) {
      _checkForUpdates();
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _scrollController.dispose();
    _mainScrollController.dispose();
    _desktopScrollController.dispose();
    _logsNotifier.dispose();
    _broadcastingNotifier.dispose();
    _userServersNotifier.dispose();
    _stopBroadcast();
    super.dispose();
  }

  Future<void> _loadRelayServerPreference() async {
    final savedIp = await RelayPreferenceStorage.loadSelectedRelayIp();
    if (savedIp != null &&
        AppConstants.relayServers.any((e) => e['ip'] == savedIp)) {
      setState(() => _selectedRelayIp = savedIp);
    }
  }

  void _initializeComponents() {
    logger = Logger(debugEnabled: _debugEnabled, logCallback: _log);
    socketHandler = SocketHandler(logger: logger);
    _broadcastManager = BroadcastManager(
      socketHandler: socketHandler,
      logger: logger,
    );
    _broadcastManager.onAutoDisconnect = _handleAutoDisconnect;
    _broadcastManager.onRelayError = _handleRelayError;
  }

  Future<void> _checkForUpdates() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    try {
      logger.info('🔍 Checking for updates...');
      final updateService = GitHubUpdateService();
      final updateInfo = await updateService.checkForUpdates();
      if (updateInfo != null && mounted) {
        logger.info('📥 Update available: ${updateInfo.version}');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => UpdateDialog(updateInfo: updateInfo),
        );
      } else {
        logger.info('✅ App is up to date');
      }
    } catch (e) {
      logger.error('❌ Update check failed: $e');
    }
  }

  void _handleAutoDisconnect() {
    if (!mounted) return;
    setState(() => _broadcastingNotifier.value = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Client disconnected — Broadcast stopped',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.info,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
    logger.info('Auto-disconnect: All clients inactive');
  }

  void _handleRelayError(String message) {
    if (!mounted) return;
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
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _loadUserServers() async {
    try {
      final servers = await UserServersStorage.loadServers();
      if (servers.isNotEmpty)
        logger.debug('Loaded ${servers.length} saved server(s)');
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
      if (_scrollController.hasClients && mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppConstants.animationDuration,
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  Future<void> _copyLogsToClipboard() async {
    final logs = _logsNotifier.value;
    if (logs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No logs to copy'),
          duration: Duration(seconds: 2),
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
            Text('Copied ${logs.length} log entries to clipboard'),
          ],
        ),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleDebugMode() {
    setState(() {
      _debugEnabled = !_debugEnabled;
      logger.debugEnabled = _debugEnabled;
    });
    logger.info('Debug mode ${_debugEnabled ? "enabled" : "disabled"}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _debugEnabled ? Icons.bug_report : Icons.bug_report_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text('Debug logs ${_debugEnabled ? "enabled" : "disabled"}'),
          ],
        ),
        backgroundColor: _debugEnabled ? AppTheme.success : AppTheme.textMuted,
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

  Future<void> _showNintendoDnsModal() async {
    final meta = _getRelayMeta(_selectedRelayIp);
    await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          title: const Text(
            'Nintendo Switch — DNS mode',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected relay:',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${meta['name']} — ${meta['ip']}',
                style: TextStyle(
                  color: AppTheme.primaryAccent,
                  fontFamily: 'monospace',
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Your server settings have been submitted to Netherlink.\n\nTo connect:\n1. Set your Nintendo DNS to: ${meta['ip']}\n2. Open Minecraft Bedrock and select a featured server (like Cubecraft, Hive, etc.)\n3. You will automatically be connected to your own (remote) server!',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Got it',
                style: TextStyle(color: AppTheme.primaryAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startBroadcast() async {
    final remoteHost = _ipController.text.trim();
    final remotePortParsed = int.tryParse(_portController.text);

    if (remoteHost.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please enter a server address'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    if (remotePortParsed == null ||
        remotePortParsed < 1 ||
        remotePortParsed > 65535) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Invalid port number (1-65535)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_nintendoDnsMode) {
      logger.info('Nintendo DNS mode: sending config only...');
      final ok = await _broadcastManager.sendRelayConfigOnly(
        remoteHost,
        remotePortParsed,
        relayIp: _selectedRelayIp,
      );
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('✅ DNS config sent to relay'),
            backgroundColor: AppTheme.primaryAccent,
            duration: const Duration(seconds: 2),
          ),
        );
        await _showNintendoDnsModal();
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
    _broadcastingNotifier.value = _broadcastManager.isBroadcasting;

    if (_broadcastManager.isBroadcasting && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Broadcasting started'),
            ],
          ),
          backgroundColor: AppTheme.primaryAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _stopBroadcast() async {
    await _broadcastManager.stopBroadcast();
    _broadcastingNotifier.value = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Broadcast stopped'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onUserServerSelected(UserServer server) {
    setState(() {
      _ipController.text = server.address;
      _portController.text = server.port.toString();
    });
    logger.info('Selected saved server: ${server.name}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📋 Selected: ${server.name}'),
        duration: const Duration(seconds: 1),
        backgroundColor: AppTheme.primaryAccentDark,
      ),
    );
  }

  Future<void> _showManageServersDialog() async {
    await showDialog(
      context: context,
      builder: (context) => const ManageServersDialog(),
    );
    _loadUserServers();
  }

  Future<void> _showConsoleDialog() async {
    setState(() => _consoleDialogOpen = true);
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConsoleDialog(
        logsNotifier: _logsNotifier,
        scrollController: _scrollController,
        debugEnabled: _debugEnabled,
        onToggleDebug: _toggleDebugMode,
        onClearLogs: _clearLogs,
        onCopyLogs: _copyLogsToClipboard,
      ),
    );
    if (mounted) setState(() => _consoleDialogOpen = false);
  }

  void _showHelpDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          title: const Text(
            'How to use NetherLink',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Text(
              AppConstants.helpText,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: AppTheme.primaryAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: Column(
          children: [
            _buildAppBar(),
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
          ],
        ),
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

  Widget _buildAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.white.withOpacity(0.05),
          child: SafeArea(
            bottom: false,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildGlassPill(),
                  const Spacer(),
                  _glassAppBarButton(
                    icon: Icons.terminal_rounded,
                    tooltip: 'Console',
                    onTap: _consoleDialogOpen ? null : _showConsoleDialog,
                  ),
                  const SizedBox(width: 8),
                  _buildGlassMenuButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassPill() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSupportButton(),
              Container(
                width: 1,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: Colors.white.withOpacity(0.08),
              ),
              _buildDiscordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton() => _AnimatedSupportButton(
    onTap: () =>
        showDialog(context: context, builder: (_) => const SupportDialog()),
  );

  Widget _buildDiscordButton() {
    return Tooltip(
      message: 'Discord',
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => launchUrl(Uri.parse(AppConstants.discordUrl)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.discord, color: Color(0xFF7289DA), size: 18),
              const SizedBox(width: 6),
              Text(
                'Join Us',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassAppBarButton({
    required IconData icon,
    required String tooltip,
    VoidCallback? onTap,
  }) {
    final enabled = onTap != null;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(enabled ? 0.07 : 0.03),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withOpacity(enabled ? 0.1 : 0.04),
                ),
              ),
              child: Icon(
                icon,
                size: 17,
                color: enabled
                    ? AppTheme.primaryAccent.withOpacity(0.8)
                    : Colors.white.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassMenuButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
          offset: const Offset(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          color: Colors.black.withOpacity(0.7),
          elevation: 0,
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 18,
            ),
          ),
          itemBuilder: (context) => [
            _glassMenuItem(Icons.open_in_browser_rounded, 'Website', () {
              Navigator.pop(context);
              launchUrl(Uri.parse(AppConstants.websiteUrl));
            }),
            _glassMenuItem(Icons.help_outline_rounded, 'How to use', () {
              Navigator.pop(context);
              _showHelpDialog(Theme.of(context));
            }),
          ],
        ),
      ),
    );
  }

  PopupMenuItem _glassMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return PopupMenuItem(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.primaryAccent, size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionPanel(List<UserServer> userServers) {
    return ConnectionPanel(
      ipController: _ipController,
      portController: _portController,
      broadcastingNotifier: _broadcastingNotifier,
      onStartBroadcast: _startBroadcast,
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

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _mainScrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<List<UserServer>>(
            valueListenable: _userServersNotifier,
            builder: (context, userServers, _) =>
                _buildConnectionPanel(userServers),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return _buildMobileLayout();
  }
}

class _AnimatedSupportButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AnimatedSupportButton({required this.onTap});

  @override
  State<_AnimatedSupportButton> createState() => _AnimatedSupportButtonState();
}

class _AnimatedSupportButtonState extends State<_AnimatedSupportButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;
  late Animation<Color?> _color;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);

    _pulse = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.22,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.22,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40),
    ]).animate(_controller);

    _color = ColorTween(
      begin: Colors.pink.shade300,
      end: Colors.pink.shade500,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _hovering
                ? Colors.pink.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => Transform.scale(
                  scale: _pulse.value,
                  child: Icon(Icons.favorite, color: _color.value, size: 16),
                ),
              ),
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: _hovering ? FontWeight.w600 : FontWeight.w400,
                  color: _hovering
                      ? Colors.pink.shade300
                      : Colors.white.withOpacity(0.5),
                ),
                child: const Text('Support'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

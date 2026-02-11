import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../connection/ping_pong_connection.dart';
import '../connection/broadcast_manager.dart';
import '../util/Logger.dart';
import '../util/user_servers.dart';
import '../util/user_servers_storage.dart';
import '../util/bedrock_profile.dart';
import '../util/profile_storage.dart';
import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../widgets/common/status_indicator.dart';
import '../widgets/connection/connection_panel.dart';
import '../widgets/dialogs/manage_servers_dialog.dart';
import '../widgets/dialogs/support_dialog.dart';
import '../services/github_update_service.dart';
import '../widgets/dialogs/update_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final SocketHandler socketHandler;
  late final BroadcastManager _broadcastManager;
  late final Logger logger;

  BedrockProfile? _selectedProfile;
  bool _debugEnabled = false;

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
  final ValueNotifier<List<UserServer>> _userServersNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _initializeComponents();
    _loadUserServers();
    _loadDefaultProfile();

    if (Platform.isWindows || Platform.isMacOS) {
      _checkForUpdates();
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

  Future<void> _loadDefaultProfile() async {
    try {
      final profile = await ProfileStorage.getDefaultProfile();

      if (mounted) {
        setState(() {
          _selectedProfile = profile;
        });

        if (profile != null) {
          logger.info('Loaded default profile: ${profile.label}');
        } else {
          logger.info('No default profile found - please create one');
        }
      }
    } catch (e) {
      logger.error('Failed to load default profile: $e');
      if (mounted) {
        setState(() {
          _selectedProfile = null;
        });
      }
    }
  }

  void _handleAutoDisconnect() {
    if (!mounted) return;

    setState(() {
      _broadcastingNotifier.value = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Client disconnected - Broadcast stopped',
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
      if (_scrollController.hasClients && mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppConstants.animationDuration,
          curve: Curves.fastOutSlowIn,
        );
      }
    });
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

  Future<void> _startBroadcast() async {
    if (_selectedProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please select a Bedrock profile first'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    logger.info('Starting NetherLink');

    final remoteHost = _ipController.text.trim();
    final remotePortParsed = int.tryParse(_portController.text);
    final username = _selectedProfile!.username;

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
      logger.error('Invalid remote port');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Invalid port number (1-65535)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await WakelockPlus.enable();
    } catch (e) {
      logger.error('Failed to enable wakelock: $e');
    }

    final success = await _broadcastManager.startBroadcast(
      remoteHost,
      remotePortParsed,
      username,
    );

    _broadcastingNotifier.value = _broadcastManager.isBroadcasting;

    if (_broadcastManager.isBroadcasting && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text('Broadcasting as ${_selectedProfile!.label}'),
              ),
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

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: _buildAppBar(theme),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile =
                constraints.maxWidth < AppConstants.mobileBreakpoint;
            return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      toolbarHeight: 64,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppTheme.borderGray.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildSupportButton(),
                const Spacer(),
                ValueListenableBuilder<bool>(
                  valueListenable: _broadcastingNotifier,
                  builder: (context, broadcasting, _) {
                    return StatusIndicator(broadcasting: broadcasting);
                  },
                ),
                const SizedBox(width: 12),
                _buildMenuButton(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton() {
    return _AnimatedSupportButton(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const SupportDialog(),
        );
      },
    );
  }

  Widget _buildMenuButton(ThemeData theme) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppTheme.borderGray.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.more_vert_rounded,
            color: AppTheme.textPrimary,
            size: 20,
          ),
        ),
      ),
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface,
      elevation: 8,
      itemBuilder: (context) => [
        _buildMenuItem(Icons.open_in_browser, 'Website', () {
          Navigator.pop(context);
          launchUrl(Uri.parse(AppConstants.websiteUrl));
        }),
        _buildMenuItem(Icons.discord, 'Join Discord', () {
          Navigator.pop(context);
          launchUrl(Uri.parse(AppConstants.discordUrl));
        }),
        _buildMenuItem(Icons.info_outline, 'How to use', () {
          Navigator.pop(context);
          _showHelpDialog(theme);
        }),
      ],
    );
  }

  PopupMenuItem _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return PopupMenuItem(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.primaryAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
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
            builder: (context, userServers, _) {
              return ConnectionPanel(
                ipController: _ipController,
                portController: _portController,
                broadcastingNotifier: _broadcastingNotifier,
                onStartBroadcast: _startBroadcast,
                onStopBroadcast: _stopBroadcast,
                savedServers: userServers,
                onServerSelected: _onUserServerSelected,
                onManageServers: _showManageServersDialog,
                selectedProfile: _selectedProfile,
                onProfileChanged: (profile) {
                  setState(() {
                    _selectedProfile = profile;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 16),
          _buildConsoleSection(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _desktopScrollController,
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                ValueListenableBuilder<List<UserServer>>(
                  valueListenable: _userServersNotifier,
                  builder: (context, userServers, _) {
                    return ConnectionPanel(
                      ipController: _ipController,
                      portController: _portController,
                      broadcastingNotifier: _broadcastingNotifier,
                      onStartBroadcast: _startBroadcast,
                      onStopBroadcast: _stopBroadcast,
                      savedServers: userServers,
                      onServerSelected: _onUserServerSelected,
                      onManageServers: _showManageServersDialog,
                      selectedProfile: _selectedProfile,
                      onProfileChanged: (profile) {
                        setState(() {
                          _selectedProfile = profile;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildConsoleSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConsoleSection() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.borderGray),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: AppTheme.primaryAccent.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.terminal,
                        color: AppTheme.primaryAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Console Output',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            'Real-time logs',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.primaryAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _debugEnabled
                            ? Icons.bug_report
                            : Icons.bug_report_outlined,
                        size: 18,
                      ),
                      color: _debugEnabled
                          ? AppTheme.success
                          : AppTheme.textMuted,
                      onPressed: _toggleDebugMode,
                      tooltip: _debugEnabled
                          ? 'Disable debug logs'
                          : 'Enable debug logs',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      color: AppTheme.primaryAccent,
                      onPressed: () {
                        _logsNotifier.value = [];
                        logger.info('Console cleared');
                      },
                      tooltip: 'Clear logs',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: _logsNotifier,
                  builder: (context, logs, _) {
                    if (logs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48,
                              color: AppTheme.primaryAccent.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No logs yet',
                              style: TextStyle(
                                color: AppTheme.primaryAccent.withOpacity(0.5),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start broadcasting to see output',
                              style: TextStyle(
                                color: AppTheme.textMuted.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            logs[index],
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: _getLogColor(logs[index]),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLogColor(String log) {
    if (log.contains('[ERROR]')) {
      return AppTheme.error;
    } else if (log.contains('[WARN]')) {
      return AppTheme.warning;
    } else if (log.contains('[INFO]')) {
      return AppTheme.info;
    } else if (log.contains('[DEBUG]')) {
      return AppTheme.success;
    }
    return AppTheme.textSecondary;
  }

  void _showHelpDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        title: const Text('How to use NetherLink'),
        content: const SingleChildScrollView(
          child: Text(AppConstants.helpText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primaryAccent,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
  late Animation<double> _heartbeatAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _heartbeatAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 40,
      ),
    ]).animate(_controller);

    _colorAnimation = ColorTween(
      begin: Colors.pink.shade300,
      end: Colors.pink.shade400,
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
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovering
                ? Colors.pink.shade50.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartbeatAnimation.value,
                    child: Icon(
                      Icons.favorite,
                      color: _colorAnimation.value,
                      size: 18,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: _isHovering
                      ? Colors.pink.shade300
                      : AppTheme.textSecondary.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: _isHovering ? FontWeight.w600 : FontWeight.w400,
                  letterSpacing: 0.3,
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
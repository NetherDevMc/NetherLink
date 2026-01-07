import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/server_loader.dart';
import '../connection/ping_pong_connection.dart';
import '../connection/broadcast_manager.dart';
import '../util/Logger.dart';
import '../util/server_entry.dart';
import '../util/user_servers.dart';
import '../util/user_servers_storage.dart';
import '../util/bedrock_profile.dart';
import '../util/profile_storage.dart';
import '../constants/app_constants.dart';
import '../widgets/common/status_indicator.dart';
import '../widgets/connection/connection_panel.dart';
import '../widgets/console/floating_console.dart';
import '../widgets/server/featured_servers.dart';
import '../widgets/server/server_card.dart';
import '../widgets/dialogs/manage_servers_dialog.dart';

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
  late final Timer _shuffleTimer;
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  int _currentServerPage = 0;
  BedrockProfile? _selectedProfile;

  final TextEditingController _ipController = TextEditingController(
    text: AppConstants.defaultServerAddress,
  );
  final TextEditingController _portController = TextEditingController(
    text: SocketHandler.proxyPort.toString(),
  );

  final ScrollController _scrollController = ScrollController();
  final ScrollController _serverScrollController = ScrollController();
  final ScrollController _mainScrollController = ScrollController();

  final ValueNotifier<List<String>> _logsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ServerEntry>> _serversNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _broadcastingNotifier = ValueNotifier(false);
  final ValueNotifier<List<UserServer>> _userServersNotifier = ValueNotifier(
    [],
  );
  final ValueNotifier<bool> _serversExpandedNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _consoleVisibleNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _initializeComponents();
    _loadServers();
    _loadUserServers();
    _loadDefaultProfile();
    _startServerRotation();
  }

  void _initializeComponents() {
    _animationController = AnimationController(
      duration: AppConstants.serverRotationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    logger = Logger(debugEnabled: false, logCallback: _log);
    socketHandler = SocketHandler(logger: logger);
    _broadcastManager = BroadcastManager(
      socketHandler: socketHandler,
      logger: logger,
    );

    _broadcastManager.onAutoDisconnect = _handleAutoDisconnect;
  }

  Future<void> _loadDefaultProfile() async {
    final profile = await ProfileStorage.getDefaultProfile();
    setState(() {
      _selectedProfile = profile;
    });
  }

  void _handleAutoDisconnect() {
    if (!mounted) return;

    setState(() {
      _broadcastingNotifier.value = false;
      _consoleVisibleNotifier.value = false;
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
        backgroundColor: const Color(0xFF3B82F6),
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

  void _startServerRotation() {
    _shuffleTimer = Timer.periodic(AppConstants.serverRotationDuration, (_) {
      if (_serversNotifier.value.isNotEmpty) {
        setState(() {
          _currentServerPage =
              (_currentServerPage + 1) % _serversNotifier.value.length;
        });
        _animationController.forward(from: 0.0);
      }
    });
  }

  Future<void> _loadServers() async {
    final loader = ServerLoader(jsonUrl: AppConstants.serversApiUrl);
    try {
      final servers = await loader.loadServers();
      _serversNotifier.value = servers;
    } catch (e) {
      logger.error(e.toString());
    }
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

    await _broadcastManager.startBroadcast(
      remoteHost,
      remotePortParsed,
      username,
    );

    _broadcastingNotifier.value = _broadcastManager.isBroadcasting;

    if (_broadcastManager.isBroadcasting) {
      _consoleVisibleNotifier.value = true;

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
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _stopBroadcast() async {
    await _broadcastManager.stopBroadcast();
    _broadcastingNotifier.value = false;
    _consoleVisibleNotifier.value = false;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Broadcast stopped'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onServerTap(ServerEntry server) {
    setState(() {
      _ipController.text = server.address;
      _portController.text = server.port.toString();
    });

    logger.debug('Selected featured server: ${server.name}');
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
        backgroundColor: const Color(0xFF6366F1),
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
    _shuffleTimer.cancel();
    _animationController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _scrollController.dispose();
    _serverScrollController.dispose();
    _mainScrollController.dispose();
    _logsNotifier.dispose();
    _serversNotifier.dispose();
    _broadcastingNotifier.dispose();
    _userServersNotifier.dispose();
    _serversExpandedNotifier.dispose();
    _consoleVisibleNotifier.dispose();
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
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.track_changes, color: Color(0xFF10B981), size: 28),
          SizedBox(width: 12),
          Text(
            'NetherLink',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: _broadcastingNotifier,
          builder: (context, broadcasting, _) {
            return StatusIndicator(broadcasting: broadcasting);
          },
        ),
        const SizedBox(width: 8),
        _buildMenuButton(theme),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
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
              _buildCompactServerSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _consoleVisibleNotifier,
          builder: (context, visible, _) {
            return FloatingConsole(
              logsNotifier: _logsNotifier,
              scrollController: _scrollController,
              logger: logger,
              isVisible: visible,
              onClose: () => _consoleVisibleNotifier.value = false,
            );
          },
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        Column(
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
            Expanded(child: _buildFeaturedServers()),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _consoleVisibleNotifier,
          builder: (context, visible, _) {
            return FloatingConsole(
              logsNotifier: _logsNotifier,
              scrollController: _scrollController,
              logger: logger,
              isVisible: visible,
              onClose: () => _consoleVisibleNotifier.value = false,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCompactServerSection() {
    return ValueListenableBuilder<bool>(
      valueListenable: _serversExpandedNotifier,
      builder: (context, expanded, _) {
        return ValueListenableBuilder<List<ServerEntry>>(
          valueListenable: _serversNotifier,
          builder: (context, servers, _) {
            final theme = Theme.of(context);

            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _serversExpandedNotifier.value = !expanded,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.dns,
                              color: Color(0xFF10B981),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Advertised Servers',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 208, 209, 209),
                                  ),
                                ),
                                if (servers.isNotEmpty && !expanded)
                                  Text(
                                    '${servers.length} servers available',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (servers.length > 1 && !expanded)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF374151),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    '5s rotation',
                                    style: TextStyle(
                                      color: Color(0xFFD1D5DB),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Color(0xFF10B981),
                                  size: 18,
                                ),
                                onPressed: _loadServers,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                expanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: const Color(0xFF10B981),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!expanded && servers.isNotEmpty) ...[
                    const Divider(height: 1, color: Color(0xFF374151)),
                    _buildCompactServerPreview(servers[_currentServerPage]),
                  ],
                  if (expanded) ...[
                    if (servers.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildProgressBar(),
                      ),
                    const Divider(height: 1, color: Color(0xFF374151)),
                    SizedBox(
                      height: 300,
                      child: servers.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF10B981),
                              ),
                            )
                          : ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemCount: servers.length,
                              itemBuilder: (context, index) {
                                final server = servers[index];
                                return ServerCard(
                                  server: server,
                                  isTop: index == _currentServerPage,
                                  onTap: () {
                                    _onServerTap(server);
                                    _serversExpandedNotifier.value = false;
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCompactServerPreview(ServerEntry server) {
    return InkWell(
      onTap: () {
        _onServerTap(server);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('📋 Selected: ${server.address}: ${server.port}'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Color(0xFF065F46), Color(0xFF0D9488)],
                ),
              ),
              child: const Icon(Icons.dns, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'TOP',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${server.address}:${server.port}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 208, 209, 209),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap to connect or expand for more',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF10B981),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(2),
      ),
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, _) {
          return FractionallySizedBox(
            widthFactor: _rotationAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedServers() {
    return ValueListenableBuilder<List<ServerEntry>>(
      valueListenable: _serversNotifier,
      builder: (context, servers, _) {
        return FeaturedServers(
          servers: servers,
          currentServerPage: _currentServerPage,
          rotationAnimation: _rotationAnimation,
          scrollController: _serverScrollController,
          onRefresh: _loadServers,
          onServerTap: _onServerTap,
        );
      },
    );
  }

  Widget _buildMenuButton(ThemeData theme) {
    return PopupMenuButton(
      icon: const Icon(Icons.menu),
      color: theme.colorScheme.surface,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.open_in_browser),
            title: const Text('Website'),
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(AppConstants.websiteUrl));
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.discord),
            title: const Text('Join Discord'),
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(AppConstants.discordUrl));
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('How to use'),
            onTap: () {
              Navigator.pop(context);
              _showHelpDialog(theme);
            },
          ),
        ),
      ],
    );
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
              foregroundColor: const Color(0xFF10B981),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

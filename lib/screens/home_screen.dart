import 'dart:async';
import 'dart:io';
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
import '../widgets/dialogs/manage_servers_dialog.dart';
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
  late final Timer _shuffleTimer;
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;
  late final PageController _pageController;

  int _currentServerPage = 0;
  BedrockProfile? _selectedProfile;

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
  final ValueNotifier<List<ServerEntry>> _serversNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _broadcastingNotifier = ValueNotifier(false);
  final ValueNotifier<List<UserServer>> _userServersNotifier = ValueNotifier(
    [],
  );
  final ValueNotifier<bool> _consoleVisibleNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _initializeComponents();
    _loadServers();
    _loadUserServers();
    _loadDefaultProfile();
    _startServerRotation();

    if (Platform.isWindows || Platform.isMacOS) {
      _checkForUpdates();
    }
  }

  Future<void> _checkForUpdates() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    try {
      logger.info('🔍 Checking for updates.. .');

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
      logger.error('❌ Update check failed:  $e');
    }
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
      if (_serversNotifier.value.isNotEmpty && mounted) {
        final nextPage =
            (_currentServerPage + 1) % _serversNotifier.value.length;

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }

        setState(() {
          _currentServerPage = nextPage;
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
          backgroundColor: const Color(0xFF00D9FF),
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
    _pageController.dispose();
    _ipController.dispose();
    _portController.dispose();
    _scrollController.dispose();
    _mainScrollController.dispose();
    _desktopScrollController.dispose();
    _logsNotifier.dispose();
    _serversNotifier.dispose();
    _broadcastingNotifier.dispose();
    _userServersNotifier.dispose();
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
          Icon(Icons.track_changes, color: Color(0xFF00D9FF), size: 28),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
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
                    _buildCompactServerSection(),
                    const SizedBox(height: 80),
                  ],
                ),
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
      },
    );
  }

  Widget _buildCompactServerSection() {
    return ValueListenableBuilder<List<ServerEntry>>(
      valueListenable: _serversNotifier,
      builder: (context, servers, _) {
        if (servers.isEmpty) {
          return _buildLoadingCard();
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: _buildHorizontalCarousel(servers),
          ),
        );
      },
    );
  }

  Widget _buildLoadingCard() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF152228)),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF00D9FF)),
                SizedBox(height: 16),
                Text(
                  'Loading advertised servers...',
                  style: TextStyle(color: Color(0xFF00D9FF), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalCarousel(List<ServerEntry> servers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCarouselHeader(servers.length),
        const SizedBox(height: 12),
        _buildProgressBar(),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentServerPage = index;
              });
            },
            itemCount: servers.length,
            itemBuilder: (context, index) {
              return _buildCarouselCard(servers[index], index);
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildCarouselIndicators(servers.length),
      ],
    );
  }

  Widget _buildCarouselHeader(int serverCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.campaign,
              color: Color(0xFF00D9FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Featured Servers',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 208, 209, 209),
                  ),
                ),
                Text(
                  'Swipe to explore • Auto-rotating',
                  style: TextStyle(fontSize: 11, color: Color(0xFF00D9FF)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF152228),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF00D9FF).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.dns, size: 12, color: Color(0xFF00D9FF)),
                const SizedBox(width: 6),
                Text(
                  '$serverCount',
                  style: const TextStyle(
                    color: Color(0xFF00D9FF),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF00D9FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF00D9FF).withOpacity(0.3),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh, size: 18),
              color: const Color(0xFF00D9FF),
              onPressed: _loadServers,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF152228),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFF00D9FF).withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, _) {
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _rotationAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D9FF), Color(0xFF00A3CC)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D9FF).withOpacity(0.4),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCarouselCard(ServerEntry server, int index) {
    final isCurrent = index == _currentServerPage;
    final hasBackground =
        server.background != null &&
        (server.background!.startsWith('http://') ||
            server.background!.startsWith('https://'));

    return AnimatedScale(
      scale: isCurrent ? 1.0 : 0.95,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0A1419),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrent
                ? const Color(0xFF00D9FF).withOpacity(0.3)
                : const Color(0xFF152228),
            width: isCurrent ? 1.5 : 1,
          ),
          boxShadow: isCurrent
              ? [
                  BoxShadow(
                    color: const Color(0xFF00D9FF).withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (hasBackground)
                      Image.network(
                        server.background!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _buildDefaultBanner(isCurrent),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildDefaultBanner(isCurrent);
                        },
                      )
                    else
                      _buildDefaultBanner(isCurrent),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 12,
                      left: 12,
                      right: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF00D9FF).withOpacity(0.4),
                              ),
                            ),
                            child: Text(
                              '${index + 1}/${_serversNotifier.value.length}',
                              style: TextStyle(
                                color: const Color(0xFF00D9FF).withOpacity(0.9),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00D9FF),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF00D9FF,
                                    ).withOpacity(0.5),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'LIVE',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    if (!hasBackground)
                      Center(
                        child: Icon(
                          Icons.dns_outlined,
                          size: 48,
                          color: const Color(
                            0xFF00D9FF,
                          ).withOpacity(isCurrent ? 0.5 : 0.3),
                        ),
                      ),
                  ],
                ),
              ),

              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _onServerTap(server);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Color(0xFF00D9FF),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Selected: ${server.address}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF0A1419),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    splashColor: const Color(0xFF00D9FF).withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  server.address,
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      208,
                                      209,
                                      209,
                                    ).withOpacity(isCurrent ? 1.0 : 0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Port: ${server.port}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      208,
                                      209,
                                      209,
                                    ).withOpacity(0.5),
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF152228),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCurrent
                                    ? const Color(0xFF00D9FF).withOpacity(0.3)
                                    : const Color(0xFF1A2832),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: const Color(
                                0xFF00D9FF,
                              ).withOpacity(isCurrent ? 0.8 : 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultBanner(bool isCurrent) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isCurrent
              ? [
                  const Color(0xFF00D9FF).withOpacity(0.15),
                  const Color(0xFF0F1C26),
                ]
              : [const Color(0xFF152228), const Color(0xFF0A1419)],
        ),
      ),
      child: CustomPaint(
        painter: _GridPatternPainter(
          color: const Color(0xFF00D9FF).withOpacity(isCurrent ? 0.08 : 0.03),
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isCurrent = index == _currentServerPage;
        return GestureDetector(
          onTap: () {
            if (_pageController.hasClients) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: isCurrent ? 24 : 6,
            decoration: BoxDecoration(
              color: isCurrent
                  ? const Color(0xFF00D9FF)
                  : const Color(0xFF152228),
              borderRadius: BorderRadius.circular(3),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00D9FF).withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMenuButton(ThemeData theme) {
    return PopupMenuButton(
      icon: const Icon(Icons.menu),
      color: theme.colorScheme.surface,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(
              Icons.open_in_browser,
              color: Color(0xFF00D9FF),
            ),
            title: const Text('Website'),
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(AppConstants.websiteUrl));
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.discord, color: Color(0xFF00D9FF)),
            title: const Text('Join Discord'),
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse(AppConstants.discordUrl));
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF00D9FF)),
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
              foregroundColor: const Color(0xFF00D9FF),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color color;

  _GridPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const spacing = 20.0;

    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

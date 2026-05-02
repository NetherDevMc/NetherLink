import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/region_detector.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _bgController;
  late AnimationController _shimmerController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _bgAnimation;
  late Animation<double> _shimmerAnimation;

  RelayPingResult? _detectedRelay;
  String _appVersion = '';
  bool _isCheckingUpdate = false;
  bool _pendingUpdate = false;

  static const String _androidStoreUrl =
      'https://play.google.com/store/apps/details?id=net.netherdev.netherLink';
  static const String _iosStoreUrl =
      'https://apps.apple.com/be/app/netherlink/id6747323142';
  static const String _windowsStoreUrl =
      'https://apps.microsoft.com/detail/9NSFPT6D8PTR';
  static const String _fallbackUrl = 'https://api.jouwapp.com';

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _bgController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _bgAnimation = CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeInOut,
    );
    _shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();

    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() => _appVersion = info.version);
    }

    await Future.wait([
      _detectRelayAndCheckUpdate().then((hasUpdate) {
        _pendingUpdate = hasUpdate;
      }),
      Future.delayed(const Duration(milliseconds: 2800)),
    ]);

    if (!mounted) return;

    if (_pendingUpdate) {
      final shouldContinue = await _showUpdateDialog();
      if (!mounted) return;
      if (!shouldContinue) return;
    }

    _navigateToHome();
  }

  Future<bool> _detectRelayAndCheckUpdate() async {
    if (mounted) setState(() => _isCheckingUpdate = true);

    try {
      _detectedRelay = await RegionDetector.detectBestRelay();

      String? remoteVersion = _detectedRelay?.version;

      if (remoteVersion == null && _detectedRelay != null) {
        remoteVersion = await _fetchVersionFallback(_detectedRelay!.base);
      }

      if (remoteVersion != null && _appVersion.isNotEmpty) {
        return _isNewerVersion(_appVersion, remoteVersion);
      }
    } finally {
      if (mounted) setState(() => _isCheckingUpdate = false);
    }
    return false;
  }

  Future<String?> _fetchVersionFallback(String base) async {
    try {
      final response = await http
          .get(Uri.parse('$base/api/version'))
          .timeout(const Duration(seconds: 6));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['version'] as String?;
      }
    } catch (_) {}
    return null;
  }

  bool _isNewerVersion(String current, String remote) {
    final currentParts = current.split('.').map(int.tryParse).toList();
    final remoteParts = remote.split('.').map(int.tryParse).toList();

    final length = currentParts.length > remoteParts.length
        ? currentParts.length
        : remoteParts.length;

    for (int i = 0; i < length; i++) {
      final c = i < currentParts.length ? (currentParts[i] ?? 0) : 0;
      final r = i < remoteParts.length ? (remoteParts[i] ?? 0) : 0;
      if (r > c) return true;
      if (r < c) return false;
    }
    return false;
  }

  String get _storeUrl {
    if (kIsWeb) return _fallbackUrl;
    if (Platform.isAndroid) return _androidStoreUrl;
    if (Platform.isIOS) return _iosStoreUrl;
    if (Platform.isWindows) return _windowsStoreUrl;
    return _fallbackUrl;
  }

  Future<void> _openStore() async {
    final uri = Uri.parse(_storeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<bool> _showUpdateDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0xFF1B132C),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.10)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryAccent.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.primaryAccent.withOpacity(0.35),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.system_update_rounded,
                        color: AppTheme.primaryAccent,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Update Available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A new version of the app is available.\nUpdate now for the latest features and fixes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.12),
                              ),
                            ),
                          ),
                          child: Text(
                            'Later',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.45),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                            _openStore();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Update Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return result ?? true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) =>
            HomeScreen(initialRelay: _detectedRelay),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    _bgController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                    const Color(0xFF080810),
                    const Color(0xFF0C0818),
                    _bgAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0A0818),
                    const Color(0xFF06060F),
                    _bgAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF060A14),
                    const Color(0xFF0A0C1C),
                    _bgAnimation.value,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _bgAnimation,
              builder: (context, _) {
                return Stack(
                  children: [
                    _ambientBlob(
                      top: -120,
                      left: -80,
                      size: 400,
                      color: AppTheme.primaryAccent,
                      opacity: 0.07 + (_bgAnimation.value * 0.04),
                    ),
                    _ambientBlob(
                      bottom: -80,
                      right: -60,
                      size: 320,
                      color: Colors.purpleAccent,
                      opacity: 0.05 + (_bgAnimation.value * 0.03),
                    ),
                    _ambientBlob(
                      top: 200,
                      right: -40,
                      size: 220,
                      color: Colors.blueAccent,
                      opacity: 0.04 + (_bgAnimation.value * 0.02),
                    ),
                  ],
                );
              },
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _GlassGridPainter(
                  color: Colors.white.withOpacity(0.025),
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogo(),
                      const SizedBox(height: 44),
                      _buildTitle(loc),
                      const SizedBox(height: 16),
                      _buildBadge(loc),
                      const SizedBox(height: 64),
                      _buildLoader(loc),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 160 * _pulseAnimation.value,
              height: 160 * _pulseAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryAccent.withOpacity(
                    0.15 * _pulseAnimation.value,
                  ),
                  width: 1,
                ),
              ),
            ),
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                  width: 1,
                ),
              ),
            ),
            ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.12),
                        Colors.white.withOpacity(0.04),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryAccent.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _shimmerAnimation,
              builder: (context, _) {
                return ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment(_shimmerAnimation.value - 1, -0.5),
                      end: Alignment(_shimmerAnimation.value, 0.5),
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.white,
                        Colors.white.withOpacity(0.6),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Icon(
                    Icons.track_changes_rounded,
                    size: 52,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitle(AppLocalizations loc) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.85)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            loc.appName.toUpperCase(),
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 8,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          loc.bedrockBridge,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.35),
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(AppLocalizations loc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Text(
            loc.createdBy,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.4),
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(AppLocalizations loc) {
    return Column(
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.primaryAccent.withOpacity(0.7),
            ),
            backgroundColor: Colors.white.withOpacity(0.05),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, _) {
            return Opacity(
              opacity: 0.3 + (_pulseAnimation.value * 0.4),
              child: Text(
                _isCheckingUpdate
                    ? 'CHECKING FOR UPDATES...'
                    : loc.initializing,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        AnimatedOpacity(
          opacity: _appVersion.isEmpty ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 400),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Text(
              'v$_appVersion',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.30),
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
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
}

class _GlassGridPainter extends CustomPainter {
  final Color color;
  _GlassGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const spacing = 52.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    paint.color = color.withOpacity(0.4);
    for (double i = -size.height; i < size.width; i += spacing * 2.5) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_GlassGridPainter old) => old.color != color;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

class SupportDialog extends StatefulWidget {
  const SupportDialog({super.key});

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartPulse;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat(reverse: true);

    _heartPulse = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.25,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.25,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 40),
    ]).animate(_heartController);
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 460),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      children: [
                        _buildFreeBadge(),
                        const SizedBox(height: 16),
                        _buildDescription(),
                        const SizedBox(height: 20),
                        _buildSupportButton(
                          icon: Icons.coffee_rounded,
                          label: 'Buy me a Coffee',
                          subtitle: 'One-time support',
                          color: const Color(0xFFFFDD00),
                          url: 'https://buymeacoffee.com/jenscollaert',
                          gradientColors: [
                            const Color(0xFFFFDD00),
                            const Color(0xFFFFB700),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildSupportButton(
                          icon: Icons.star_rounded,
                          label: 'GitHub Sponsors',
                          subtitle: 'Monthly sponsorship',
                          color: const Color(0xFFEA4AAA),
                          url: 'https://github.com/sponsors/NetherDevMc',
                          gradientColors: [
                            const Color(0xFFEA4AAA),
                            const Color(0xFFDB2777),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildFooterNote(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.07)),
        ),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _heartPulse,
            builder: (_, __) => Transform.scale(
              scale: _heartPulse.value,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade400, Colors.red.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.4),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Support NetherLink',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Help keep it free & ad-free',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.success.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.celebration_rounded,
              color: AppTheme.success,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '100% Free Forever',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.success,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'No ads, no subscriptions — ever',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'NetherLink is a passion project built with love for the Minecraft community. If you find it useful, consider supporting its development!',
      style: TextStyle(
        fontSize: 13,
        color: Colors.white.withOpacity(0.45),
        height: 1.6,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSupportButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required String url,
    required List<Color> gradientColors,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.pink.shade300,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  const Text('Thank you for your support! 💙'),
                ],
              ),
              backgroundColor: Colors.white.withOpacity(0.1),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.7),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 14,
            color: Colors.white.withOpacity(0.25),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Every contribution helps maintain and improve NetherLink',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class BottomGlassSimpleNavBar extends StatelessWidget {
  final VoidCallback? onDiscordTap;
  final VoidCallback? onConsoleTap;
  final VoidCallback? onHowToTap;
  final VoidCallback? onHelpTap;
  final bool dark;

  const BottomGlassSimpleNavBar({
    Key? key,
    this.onDiscordTap,
    this.onConsoleTap,
    this.onHowToTap,
    this.onHelpTap,
    this.dark = true,
  }) : super(key: key);

  BoxDecoration _bgDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: dark
            ? [Colors.white.withOpacity(0.03), Colors.white.withOpacity(0.02)]
            : [Colors.white.withOpacity(0.85), Colors.white.withOpacity(0.8)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(dark ? 0.06 : 0.12),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(dark ? 0.25 : 0.06),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  Color _iconColor() => dark ? Colors.white.withOpacity(0.95) : Colors.black87;
  Color _labelColor() => dark ? Colors.white70 : Colors.black54;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: _bgDecoration(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavButton(
                    icon: Icons.discord,
                    label: loc.discord,
                    onTap: onDiscordTap,
                    iconColor: _iconColor(),
                    labelColor: _labelColor(),
                  ),
                  _NavButton(
                    icon: Icons.terminal_rounded,
                    label: loc.console,
                    onTap: onConsoleTap,
                    iconColor: _iconColor(),
                    labelColor: _labelColor(),
                  ),
                  _NavButton(
                    icon: Icons.help_outline,
                    label: loc.howToUseMenu,
                    onTap: onHowToTap,
                    iconColor: _iconColor(),
                    labelColor: _labelColor(),
                  ),
                  _NavButton(
                    icon: Icons.info_outline,
                    label: loc.support,
                    onTap: onHelpTap,
                    iconColor: _iconColor(),
                    labelColor: _labelColor(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color labelColor;

  const _NavButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    required this.iconColor,
    required this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          highlightColor: Colors.white.withOpacity(0.06),
          splashColor: Colors.white.withOpacity(0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: iconColor),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(color: labelColor, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

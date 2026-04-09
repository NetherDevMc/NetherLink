import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../dialogs/howto_dialogs.dart';

class HowToMenu {
  static Future<void> show(
    BuildContext context, {
    VoidCallback? onXbox,
    VoidCallback? onNintendo,
    VoidCallback? onFriends,
    VoidCallback? onJava,
  }) {
    final loc = AppLocalizations.of(context)!;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (ctx) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color(0xFF140D20).withOpacity(0.95),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  _menuTile(
                    context,
                    faIcon: FontAwesomeIcons.xbox,
                    color: const Color(0xFF107C10),
                    title: loc.howToXboxTitle,
                    subtitle: loc.howToXboxSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onXbox != null) {
                        onXbox();
                      } else {
                        HowToDialogs.showXboxInstructions(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    faIcon: FontAwesomeIcons.gamepad,
                    color: const Color(0xFFE4000F),
                    title: loc.howToNintendoTitle,
                    subtitle: loc.howToNintendoSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onNintendo != null) {
                        onNintendo();
                      } else {
                        HowToDialogs.showNintendoInstructions(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    faIcon: FontAwesomeIcons.userGroup,
                    color: const Color(0xFF7C3AED),
                    title: loc.howToFriendsTitle,
                    subtitle: loc.howToFriendsSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onFriends != null) {
                        onFriends();
                      } else {
                        HowToDialogs.showFriendsInstructions(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    faIcon: FontAwesomeIcons.java,
                    color: const Color(0xFFE76F00),
                    title: loc.javaInfoTitle,
                    subtitle: loc.howToJavaSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onJava != null) {
                        onJava();
                      } else {
                        HowToDialogs.showJavaInstructions(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _menuTile(
    BuildContext context, {
    required FaIconData faIcon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1B132C),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.35)),
                ),
                child: Center(child: FaIcon(faIcon, color: color, size: 16)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.3),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

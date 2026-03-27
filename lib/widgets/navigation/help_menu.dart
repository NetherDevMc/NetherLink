import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../dialogs/help_dialogs.dart';

class HelpMenu {
  static Future<void> show(
    BuildContext context, {
    VoidCallback? onNetherLink,
    VoidCallback? onMultiplayerFailed,
    VoidCallback? onNintendoDns,
    VoidCallback? onFriendsMode,
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
              color: const Color.fromARGB(255, 20, 13, 32).withOpacity(0.95),
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
                    icon: Icons.wifi_off_rounded,
                    title: loc.helpNetherlinkTitle,
                    subtitle: loc.helpNetherlinkSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onNetherLink != null) {
                        onNetherLink();
                      } else {
                        HelpDialogs.showNetherlinkNotAppearing(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    icon: Icons.cloud_off_rounded,
                    title: loc.helpMultiplayerFailedTitle,
                    subtitle: loc.helpMultiplayerFailedSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onMultiplayerFailed != null) {
                        onMultiplayerFailed();
                      } else {
                        HelpDialogs.showMultiplayerConnectionFailed(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    icon: Icons.dns_rounded,
                    title: loc.helpNintendoDnsTitle,
                    subtitle: loc.helpNintendoDnsSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onNintendoDns != null) {
                        onNintendoDns();
                      } else {
                        HelpDialogs.showNintendoDns(context);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _menuTile(
                    context,
                    icon: Icons.group_off_rounded,
                    title: loc.helpFriendsModeTitle,
                    subtitle: loc.helpFriendsModeSubtitle,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      if (onFriendsMode != null) {
                        onFriendsMode();
                      } else {
                        HelpDialogs.showFriendsMode(context);
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
    required IconData icon,
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 27, 19, 44),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.12),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    243,
                    243,
                    243,
                  ).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: 18,
                ),
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
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color.fromARGB(
                          255,
                          184,
                          184,
                          184,
                        ).withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppTheme.primaryAccent),
            ],
          ),
        ),
      ),
    );
  }
}

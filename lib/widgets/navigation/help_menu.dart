import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      isScrollControlled: true,
      builder: (ctx) {
        final media = MediaQuery.of(ctx);
        final maxHeight = media.size.height * 0.80;
        final bottomInset = media.viewInsets.bottom;

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color(0xFF140D20).withOpacity(0.95),
              padding: EdgeInsets.fromLTRB(16, 12, 16, 20 + bottomInset),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: SingleChildScrollView(
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
                        faIcon: FontAwesomeIcons.wifi,
                        color: const Color(0xFF3B82F6),
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
                        faIcon: FontAwesomeIcons.cloudArrowDown,
                        color: const Color(0xFFF59E0B),
                        title: loc.helpMultiplayerFailedTitle,
                        subtitle: loc.helpMultiplayerFailedSubtitle,
                        onTap: () {
                          Navigator.of(ctx).pop();
                          if (onMultiplayerFailed != null) {
                            onMultiplayerFailed();
                          } else {
                            HelpDialogs.showMultiplayerConnectionFailed(
                              context,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _menuTile(
                        context,
                        faIcon: FontAwesomeIcons.gamepad,
                        color: const Color(0xFFE4000F),
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
                        faIcon: FontAwesomeIcons.userGroup,
                        color: const Color(0xFF7C3AED),
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
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
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

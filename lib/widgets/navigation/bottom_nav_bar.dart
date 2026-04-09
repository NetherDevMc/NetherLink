import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../services/navigation_controller.dart';
import '../../constants/app_constants.dart';
import 'dart:ui';

class BottomGlassSimpleNavBar extends StatefulWidget {
  final NavigationController navigationController;
  final VoidCallback? onHowToTapOverride;
  final VoidCallback? onHelpTapOverride;
  final bool dark;
  final String? selectedRelayIp;
  final void Function(String?)? onRelayChanged;

  const BottomGlassSimpleNavBar({
    Key? key,
    required this.navigationController,
    this.onHowToTapOverride,
    this.onHelpTapOverride,
    this.dark = true,
    this.selectedRelayIp,
    this.onRelayChanged,
  }) : super(key: key);

  @override
  State<BottomGlassSimpleNavBar> createState() =>
      _BottomGlassSimpleNavBarState();
}

class _BottomGlassSimpleNavBarState extends State<BottomGlassSimpleNavBar> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final iconColor = widget.dark
        ? Colors.white.withOpacity(0.80)
        : Colors.black87;
    final labelColor = widget.dark
        ? Colors.white.withOpacity(0.45)
        : Colors.black38;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.07), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavButton(
                icon: FontAwesomeIcons.discord,
                label: loc.discord,
                onTap: () => widget.navigationController.openDiscord(context),
                iconColor: iconColor,
                labelColor: labelColor,
              ),
              _NavButton(
                icon: FontAwesomeIcons.circleQuestion,
                label: loc.howToUseMenu,
                onTap: () {
                  if (widget.onHowToTapOverride != null) {
                    widget.onHowToTapOverride!();
                  } else {
                    widget.navigationController.showHowToMenu(context);
                  }
                },
                iconColor: iconColor,
                labelColor: labelColor,
              ),
              _NavButton(
                icon: FontAwesomeIcons.lifeRing,
                label: loc.support,
                onTap: () {
                  if (widget.onHelpTapOverride != null) {
                    widget.onHelpTapOverride!();
                  } else {
                    widget.navigationController.showHelpMenu(context);
                  }
                },
                iconColor: iconColor,
                labelColor: labelColor,
              ),
              _NavButton(
                icon: FontAwesomeIcons.ellipsis,
                label: loc.more,
                onTap: () => _showMoreModal(context),
                iconColor: iconColor,
                labelColor: labelColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreModal(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color(0xFF140D20).withOpacity(0.95),
              padding: EdgeInsets.fromLTRB(16, 12, 16, 20 + bottomInset),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  _RegionSelector(
                    selectedIp: widget.selectedRelayIp,
                    onChanged: (ip) {
                      widget.onRelayChanged?.call(ip);
                      Navigator.of(ctx).pop();
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.07),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  _moreTile(
                    ctx,
                    icon: FontAwesomeIcons.terminal,
                    color: const Color(0xFF3B82F6),
                    label: loc.console,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      widget.navigationController.showConsole(context);
                    },
                  ),
                  const SizedBox(height: 6),
                  _moreTile(
                    ctx,
                    icon: FontAwesomeIcons.earthEurope,
                    color: const Color(0xFF10B981),
                    label: loc.website,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      widget.navigationController.openWebsite(context);
                    },
                  ),
                  const SizedBox(height: 6),
                  _moreTile(
                    ctx,
                    icon: FontAwesomeIcons.language,
                    color: const Color(0xFFF59E0B),
                    label: loc.changeLanguage,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      widget.navigationController.showLanguageDialog(context);
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

  Widget _moreTile(
    BuildContext ctx, {
    required FaIconData icon,
    required Color color,
    required String label,
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
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.35)),
                ),
                child: Center(child: FaIcon(icon, color: color, size: 15)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.25),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionSelector extends StatelessWidget {
  final String? selectedIp;
  final void Function(String?) onChanged;

  const _RegionSelector({required this.selectedIp, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'NETHERLINK SERVER',
          style: TextStyle(
            color: Colors.white.withOpacity(0.35),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: AppConstants.relayServers.map((relay) {
            final ip = relay['ip'] as String;
            final name = relay['name'] as String;
            final isSelected = selectedIp == ip;

            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(ip),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    right: relay == AppConstants.relayServers.first ? 6 : 0,
                    left: relay == AppConstants.relayServers.last ? 6 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.10)
                        : Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white.withOpacity(0.30)
                          : Colors.white.withOpacity(0.08),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected) ...[
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4ADE80),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                      ],
                      Text(
                        name,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.45),
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final FaIconData icon;
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
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      splashColor: Colors.white.withOpacity(0.08),
      highlightColor: Colors.white.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 20, color: iconColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

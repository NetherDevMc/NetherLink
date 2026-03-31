import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/navigation_controller.dart';

class BottomGlassSimpleNavBar extends StatefulWidget {
  final NavigationController navigationController;
  final VoidCallback? onHowToTapOverride;
  final VoidCallback? onHelpTapOverride;
  final bool dark;

  const BottomGlassSimpleNavBar({
    Key? key,
    required this.navigationController,
    this.onHowToTapOverride,
    this.onHelpTapOverride,
    this.dark = true,
  }) : super(key: key);

  @override
  State<BottomGlassSimpleNavBar> createState() =>
      _BottomGlassSimpleNavBarState();
}

class _BottomGlassSimpleNavBarState extends State<BottomGlassSimpleNavBar> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;
  bool _hintPlayed = false;

  static const double _minButtonWidth = 72;
  static const double _maxButtonWidth = 160;

  static const double _overlayWidth = 56;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollability());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() => _updateScrollability();

  void _updateScrollability() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    final canLeft = offset > 4;
    final canRight = offset < (max - 4);

    if (mounted) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }

    if (!_hintPlayed && canRight) {
      _hintPlayed = true;
      _playHintAnimation();
    }
  }

  Future<void> _playHintAnimation() async {
    try {
      if (!_scrollController.hasClients) return;
      final double hintOffset = (_minButtonWidth + 12).clamp(20.0, 80.0);
      await _scrollController.animateTo(
        hintOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      await Future.delayed(const Duration(milliseconds: 250));
      if (!_scrollController.hasClients) return;
      await _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } catch (_) {}
  }

  BoxDecoration _bgDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: widget.dark
            ? [Colors.white.withOpacity(0.025), Colors.white.withOpacity(0.015)]
            : [Colors.white.withOpacity(0.85), Colors.white.withOpacity(0.8)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(widget.dark ? 0.06 : 0.12),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(widget.dark ? 0.03 : 0.12),
          offset: const Offset(-2, -2),
          blurRadius: 6,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(widget.dark ? 0.22 : 0.08),
          offset: const Offset(0, 8),
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ],
    );
  }

  Color _iconColor() =>
      widget.dark ? Colors.white.withOpacity(0.95) : Colors.black87;
  Color _labelColor() => widget.dark ? Colors.white70 : Colors.black54;

  void _scrollBy(double delta) {
    if (!_scrollController.hasClients) return;
    final target = (_scrollController.offset + delta).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final items = <_NavEntry>[
      _NavEntry(
        icon: Icons.discord,
        label: loc.discord,
        onTap: () => widget.navigationController.openDiscord(context),
      ),
      _NavEntry(
        icon: Icons.terminal_rounded,
        label: loc.console,
        onTap: () => widget.navigationController.showConsole(context),
      ),
      _NavEntry(
        icon: Icons.help_outline,
        label: loc.howToUseMenu,
        onTap: () {
          if (widget.onHowToTapOverride != null) {
            widget.onHowToTapOverride!();
          } else {
            widget.navigationController.showHowToMenu(context);
          }
        },
      ),
      _NavEntry(
        icon: Icons.info_outline,
        label: loc.support,
        onTap: () {
          if (widget.onHelpTapOverride != null) {
            widget.onHelpTapOverride!();
          } else {
            widget.navigationController.showHelpMenu(context);
          }
        },
      ),
      _NavEntry(
        icon: Icons.public,
        label: loc.website,
        onTap: () => widget.navigationController.openWebsite(context),
      ),
      _NavEntry(
        icon: Icons.language,
        label: loc.changeLanguage,
        onTap: () => widget.navigationController.showLanguageDialog(context),
      ),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 88,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: _bgDecoration(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 8),
                                for (final e in items)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: _NavButton(
                                      minWidth: _minButtonWidth,
                                      maxWidth: _maxButtonWidth,
                                      icon: e.icon,
                                      label: e.label,
                                      onTap: e.onTap,
                                      iconColor: _iconColor(),
                                      labelColor: _labelColor(),
                                    ),
                                  ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: RadialGradient(
                            center: const Alignment(0, -0.2),
                            radius: 1.1,
                            colors: [
                              Colors.black.withOpacity(
                                widget.dark ? 0.06 : 0.03,
                              ),
                              Colors.black.withOpacity(0.02),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (_canScrollLeft)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: _overlayWidth,
                      child: Row(
                        children: [
                          Expanded(
                            child: IgnorePointer(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Theme.of(context).scaffoldBackgroundColor,
                                      Theme.of(context).scaffoldBackgroundColor
                                          .withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: _SmallChevron(
                              icon: Icons.chevron_left_rounded,
                              onPressed: () =>
                                  _scrollBy(-(_minButtonWidth + 12)),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (_canScrollRight)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: _overlayWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: _SmallChevron(
                              icon: Icons.chevron_right_rounded,
                              onPressed: () => _scrollBy(_minButtonWidth + 12),
                            ),
                          ),
                          Expanded(
                            child: IgnorePointer(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Theme.of(context).scaffoldBackgroundColor,
                                      Theme.of(context).scaffoldBackgroundColor
                                          .withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
}

class _SmallChevron extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _SmallChevron({Key? key, required this.icon, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.18),
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class _NavEntry {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _NavEntry({required this.icon, required this.label, required this.onTap});
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color labelColor;
  final double minWidth;
  final double maxWidth;

  const _NavButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    required this.iconColor,
    required this.labelColor,
    required this.minWidth,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          highlightColor: Colors.white.withOpacity(0.06),
          splashColor: Colors.white.withOpacity(0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: iconColor),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(color: labelColor, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

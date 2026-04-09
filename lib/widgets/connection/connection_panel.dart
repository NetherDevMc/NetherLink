import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../util/user_servers.dart';
import '../../util/featured_servers.dart';
import '../../services/featured_servers_service.dart';
import 'featured_servers_banner.dart';

enum PanelMode { lan, nintendo, friends, java }

class ConnectionPanel extends StatefulWidget {
  const ConnectionPanel({
    super.key,
    required this.ipController,
    required this.portController,
    required this.broadcastingNotifier,
    required this.onStartBroadcast,
    required this.onStopBroadcast,
    required this.savedServers,
    required this.onServerSelected,
    required this.onManageServers,
    required this.selectedRelayIp,
    required this.onRelayChanged,
    required this.nintendoDnsMode,
    required this.onNintendoDnsModeChanged,
  });

  final TextEditingController ipController;
  final TextEditingController portController;
  final ValueNotifier<bool> broadcastingNotifier;
  final Future<void> Function(PanelMode) onStartBroadcast;
  final VoidCallback onStopBroadcast;
  final List<UserServer> savedServers;
  final Function(UserServer) onServerSelected;
  final VoidCallback onManageServers;
  final String? selectedRelayIp;
  final void Function(String?) onRelayChanged;
  final bool nintendoDnsMode;
  final ValueChanged<bool> onNintendoDnsModeChanged;

  @override
  State<ConnectionPanel> createState() => _ConnectionPanelState();
}

class _ConnectionPanelState extends State<ConnectionPanel>
    with SingleTickerProviderStateMixin {
  UserServer? _selectedServer;
  Future<List<FeaturedServer>>? _featuredServersFuture;
  PanelMode _mode = PanelMode.lan;

  static const _modes = [
    _ModeConfig(
      mode: PanelMode.lan,
      icon: FontAwesomeIcons.xbox,
      color: Color(0xFF107C10),
      label: 'Xbox / PS4-5',
    ),
    _ModeConfig(
      mode: PanelMode.nintendo,
      icon: FontAwesomeIcons.gamepad,
      color: Color(0xFFE4000F),
      label: 'Nintendo',
    ),
    _ModeConfig(
      mode: PanelMode.friends,
      icon: FontAwesomeIcons.userGroup,
      color: Color(0xFF7C3AED),
      label: 'Friends',
    ),
    _ModeConfig(
      mode: PanelMode.java,
      icon: FontAwesomeIcons.java,
      color: Color(0xFFE76F00),
      label: 'Java',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _featuredServersFuture = FeaturedServersService.fetchFeaturedServers();
    _mode = widget.nintendoDnsMode ? PanelMode.nintendo : PanelMode.lan;
  }

  String _modeLabel(PanelMode mode, AppLocalizations loc) {
    switch (mode) {
      case PanelMode.lan:
        return loc.labelXbox;
      case PanelMode.nintendo:
        return loc.labelNintendo;
      case PanelMode.friends:
        return loc.labelFriends;
      case PanelMode.java:
        return loc.labelJava;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.broadcastingNotifier,
          builder: (context, broadcasting, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGlassCard(broadcasting, loc),
                FutureBuilder<List<FeaturedServer>>(
                  future: _featuredServersFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: FeaturedServersBanner(
                        servers: snapshot.data!,
                        onServerTap: (server) {
                          widget.ipController.text = server.address;
                          widget.portController.text = server.port.toString();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                loc.selectedFeaturedServer(server.name),
                              ),
                              duration: const Duration(seconds: 2),
                              backgroundColor: AppTheme.primaryAccent,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGlassCard(bool broadcasting, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionHeader(loc.serverDetailsLabel),
              const SizedBox(height: 10),
              _buildServerPickerRow(broadcasting, loc),
              const SizedBox(height: 10),
              _buildAddressFields(broadcasting, loc),
            ],
          ),
        ),
        _buildDivider(opacity: 0.08),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              _buildSectionHeader(loc.modeLabel),
              const SizedBox(height: 10),
              _buildModeGrid(broadcasting, loc),
              const SizedBox(height: 14),
              _buildActionButton(broadcasting, loc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider({double opacity = 0.08}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(opacity),
              Colors.white.withOpacity(opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: AppTheme.textMuted,
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildModeGrid(bool broadcasting, AppLocalizations loc) {
    final rows = [
      [_modes[0], _modes[1]],
      [_modes[2], _modes[3]],
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: row.map((cfg) {
              final isSelected = cfg.mode == _mode;
              final color = cfg.color;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: cfg == row.first ? 4 : 0,
                    left: cfg == row.last ? 4 : 0,
                  ),
                  child: GestureDetector(
                    onTap: broadcasting || isSelected
                        ? null
                        : () {
                            setState(() => _mode = cfg.mode);
                            widget.onNintendoDnsModeChanged(
                              cfg.mode == PanelMode.nintendo ||
                                  cfg.mode == PanelMode.friends,
                            );
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withOpacity(0.15)
                            : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? color.withOpacity(0.55)
                              : Colors.white.withOpacity(0.08),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withOpacity(0.18),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            cfg.icon,
                            size: 22,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(
                                    broadcasting ? 0.2 : 0.45,
                                  ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _modeLabel(cfg.mode, loc),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(
                                      broadcasting ? 0.2 : 0.65,
                                    ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(bool broadcasting, AppLocalizations loc) {
    if (broadcasting) {
      return _glassButton(
        onTap: widget.onStopBroadcast,
        color: AppTheme.error,
        icon: Icons.stop_rounded,
        label: loc.stopBroadcasting,
      );
    }

    final cfg = _modes.firstWhere((c) => c.mode == _mode);

    switch (_mode) {
      case PanelMode.lan:
        return Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryAccent,
                AppTheme.primaryAccent.withBlue(255),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryAccent.withOpacity(0.45),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => widget.onStartBroadcast(PanelMode.lan),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    loc.startBroadcasting,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return _glassButton(
          onTap: () => widget.onStartBroadcast(_mode),
          color: cfg.color,
          icon: Icons.play_arrow_rounded,
          label: '${loc.start} ${_modeLabel(_mode, loc)}',
        );
    }
  }

  Widget _buildServerPickerRow(bool broadcasting, AppLocalizations loc) {
    return Row(
      children: [
        Expanded(
          child: _glassField(
            height: 48,
            child: widget.savedServers.isEmpty
                ? Row(
                    children: [
                      Icon(
                        Icons.bookmark_border_rounded,
                        size: 15,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        loc.noSavedServers,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.35),
                        ),
                      ),
                    ],
                  )
                : DropdownButtonHideUnderline(
                    child: DropdownButton<UserServer>(
                      value: _selectedServer,
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.bookmark_border_rounded,
                            size: 15,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            loc.savedServers,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white.withOpacity(0.4),
                        size: 18,
                      ),
                      dropdownColor: const Color(0xFF1E1E2E),
                      menuMaxHeight: 280,
                      items: widget.savedServers.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(
                            s.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      selectedItemBuilder: (_) => widget.savedServers.map((s) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            s.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: broadcasting
                          ? null
                          : (s) {
                              setState(() => _selectedServer = s);
                              if (s != null) widget.onServerSelected(s);
                            },
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 8),
        _glassIconButton(
          icon: Icons.tune_rounded,
          tooltip: loc.manageServersTooltip,
          onPressed: broadcasting ? null : widget.onManageServers,
        ),
      ],
    );
  }

  Widget _buildAddressFields(bool broadcasting, AppLocalizations loc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _glassTextField(
            controller: widget.ipController,
            enabled: !broadcasting,
            hint: loc.serverAddressHint,
            icon: null,
            isPort: false,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: _glassTextField(
            controller: widget.portController,
            enabled: !broadcasting,
            hint: loc.portHint,
            icon: null,
            keyboardType: TextInputType.number,
            isPort: true,
          ),
        ),
      ],
    );
  }

  Widget _glassTextField({
    required TextEditingController controller,
    required bool enabled,
    required String hint,
    IconData? icon,
    TextInputType? keyboardType,
    bool isPort = false,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      textAlign: isPort ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: enabled ? Colors.white : Colors.white.withOpacity(0.3),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.white.withOpacity(0.3),
        ),
        prefixIcon: icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 14, right: 10),
                child: Icon(
                  icon,
                  size: 16,
                  color: enabled
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white.withOpacity(0.2),
                ),
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        isDense: true,
        filled: true,
        fillColor: enabled
            ? Colors.white.withOpacity(0.06)
            : Colors.white.withOpacity(0.02),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isPort ? 8 : 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppTheme.primaryAccent.withOpacity(0.6),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _glassButton({
    required VoidCallback onTap,
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withOpacity(0.25),
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassField({required double height, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _glassIconButton({
    required IconData icon,
    required String tooltip,
    VoidCallback? onPressed,
  }) {
    final enabled = onPressed != null;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(enabled ? 0.07 : 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(enabled ? 0.12 : 0.05),
                ),
              ),
              child: Icon(
                icon,
                size: 18,
                color: enabled
                    ? Colors.white.withOpacity(0.7)
                    : Colors.white.withOpacity(0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeConfig {
  final PanelMode mode;
  final FaIconData icon;
  final Color color;
  final String label;
  const _ModeConfig({
    required this.mode,
    required this.icon,
    required this.color,
    required this.label,
  });
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../util/user_servers.dart';
import '../../util/featured_servers.dart';
import '../../services/featured_servers_service.dart';
import 'featured_servers_banner.dart';
import '../components/relay_selector.dart';

enum PanelMode { lan, nintendo, friends }

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

  @override
  void initState() {
    super.initState();
    _featuredServersFuture = FeaturedServersService.fetchFeaturedServers();
    _mode = widget.nintendoDnsMode ? PanelMode.nintendo : PanelMode.lan;
  }

  @override
  Widget build(BuildContext context) {
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
                _buildGlassCard(broadcasting),
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
                              content: Text('Selected: ${server.name}'),
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

  Widget _buildGlassCard(bool broadcasting) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.07),
                Colors.white.withOpacity(0.03),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildServerPickerRow(broadcasting),
                    const SizedBox(height: 10),
                    _buildAddressFields(broadcasting),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRelaySection(broadcasting),
                    const SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.06),
                                Colors.white.withOpacity(0.06),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildSectionHeader('Mode'),
                      ],
                    ),

                    const SizedBox(height: 8),
                    _buildModeToggleRow(broadcasting),
                    if (_mode == PanelMode.nintendo ||
                        _mode == PanelMode.friends) ...[
                      const SizedBox(height: 10),
                      _buildInfoBox(),
                    ],
                    const SizedBox(height: 14),
                    _buildActionButton(broadcasting),
                  ],
                ),
              ),
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

  Widget _buildServerPickerRow(bool broadcasting) {
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
                        'No saved servers',
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
                            'Saved servers',
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
          tooltip: 'Manage servers',
          onPressed: broadcasting ? null : widget.onManageServers,
        ),
      ],
    );
  }

  Widget _buildAddressFields(bool broadcasting) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _glassTextField(
            controller: widget.ipController,
            enabled: !broadcasting,
            hint: 'Server Address',
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
            hint: 'Port',
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

  Widget _buildActionButton(bool broadcasting) {
    if (broadcasting) {
      return _glassButton(
        onTap: widget.onStopBroadcast,
        color: AppTheme.error,
        icon: Icons.stop_rounded,
        label: 'Stop Broadcasting',
      );
    }

    if (_mode == PanelMode.nintendo) {
      return _glassButton(
        onTap: () => widget.onStartBroadcast(PanelMode.nintendo),
        color: Colors.purpleAccent,
        icon: Icons.wifi_tethering_rounded,
        label: 'Start Nintendo Mode',
      );
    }
    if (_mode == PanelMode.friends) {
      return _glassButton(
        onTap: () => widget.onStartBroadcast(PanelMode.friends),
        color: Colors.purpleAccent,
        icon: Icons.person_add_alt_1_rounded,
        label: 'Start Friends Mode',
      );
    }
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                'Start Broadcasting',
                style: TextStyle(
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
  }

  Widget _buildModeToggleRow(bool broadcasting) {
    return Row(
      children: [
        Expanded(
          child: _modeButton(
            label: "Xbox/PS4-5",
            selected: _mode == PanelMode.lan,
            onTap: broadcasting
                ? null
                : () {
                    setState(() => _mode = PanelMode.lan);
                    widget.onNintendoDnsModeChanged(false);
                  },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _modeButton(
            label: "Nintendo",
            selected: _mode == PanelMode.nintendo,
            onTap: broadcasting
                ? null
                : () {
                    setState(() => _mode = PanelMode.nintendo);
                    widget.onNintendoDnsModeChanged(true);
                  },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _modeButton(
            label: "Friends",
            selected: _mode == PanelMode.friends,
            onTap: broadcasting
                ? null
                : () {
                    setState(() => _mode = PanelMode.friends);
                    widget.onNintendoDnsModeChanged(true);
                  },
          ),
        ),
      ],
    );
  }

  Widget _modeButton({
    required String label,
    required bool selected,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: selected || onTap == null ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? AppTheme.primaryAccent.withOpacity(0.21)
              : Colors.white.withOpacity(0.08),
          border: Border.all(
            color: selected
                ? AppTheme.primaryAccent
                : Colors.white.withOpacity(0.10),
            width: selected ? 2 : 1.2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? AppTheme.primaryAccent
                  : Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    if (_mode == PanelMode.nintendo) {
      return _explanationBox(
        icon: Icons.sports_esports_rounded,
        title: 'Nintendo Switch DNS mode',
        text:
            'Start in Nintendo mode, set your DNS and join a featured server.',
      );
    } else if (_mode == PanelMode.friends) {
      return _explanationBox(
        icon: Icons.person_add_alt_1_rounded,
        title: 'Friend mode',
        text:
            'Add NetherLink\'s friends bots as a friend. Start Friends mode and play',
      );
    }
    return const SizedBox.shrink();
  }

  Widget _explanationBox({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryAccent, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelaySection(bool broadcasting) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: RelaySelector(
            selectedIp: widget.selectedRelayIp,
            onChanged: (ip) {
              if (!broadcasting) widget.onRelayChanged(ip);
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
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
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.4)),
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
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
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
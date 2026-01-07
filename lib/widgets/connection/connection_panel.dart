import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../util/user_servers.dart';
import '../../util/bedrock_profile.dart';
import '../../util/profile_storage.dart';
import '../dialogs/profile_management_dialog.dart';

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
    required this.selectedProfile,
    required this.onProfileChanged,
  });

  final TextEditingController ipController;
  final TextEditingController portController;
  final ValueNotifier<bool> broadcastingNotifier;
  final VoidCallback onStartBroadcast;
  final VoidCallback onStopBroadcast;
  final List<UserServer> savedServers;
  final Function(UserServer) onServerSelected;
  final VoidCallback onManageServers;
  final BedrockProfile? selectedProfile;
  final Function(BedrockProfile?) onProfileChanged;

  @override
  State<ConnectionPanel> createState() => _ConnectionPanelState();
}

class _ConnectionPanelState extends State<ConnectionPanel> {
  UserServer? _selectedServer;
  List<BedrockProfile> _profiles = [];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final profiles = await ProfileStorage.loadProfiles();
    setState(() {
      _profiles = profiles;
    });

    if (widget.selectedProfile == null && profiles.isNotEmpty) {
      final defaultProfile = profiles.firstWhere(
        (p) => p.isDefault,
        orElse: () => profiles.first,
      );
      widget.onProfileChanged(defaultProfile);
    }
  }

  Future<void> _showProfileManagement() async {
    await showDialog(
      context: context,
      builder: (context) => const ProfileManagementDialog(),
    );
    _loadProfiles();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.settings_input_antenna,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Connection Setup',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 208, 209, 209),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ValueListenableBuilder<bool>(
            valueListenable: widget.broadcastingNotifier,
            builder: (context, broadcasting, _) {
              return _buildProfileSection(theme, broadcasting);
            },
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'SERVER',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 20),

          ValueListenableBuilder<bool>(
            valueListenable: widget.broadcastingNotifier,
            builder: (context, broadcasting, _) {
              return _buildSavedServersDropdown(context, theme, broadcasting);
            },
          ),

          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow =
                  constraints.maxWidth < AppConstants.narrowBreakpoint;
              return ValueListenableBuilder<bool>(
                valueListenable: widget.broadcastingNotifier,
                builder: (context, broadcasting, _) {
                  return _buildInputFields(
                    context,
                    theme,
                    broadcasting,
                    isNarrow,
                  );
                },
              );
            },
          ),

          const SizedBox(height: 24),

          _buildActionButtons(theme),
        ],
      ),
    );
  }

  Widget _buildProfileSection(ThemeData theme, bool broadcasting) {
    if (_profiles.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person_add,
                  color: Color(0xFF6366F1),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'No Bedrock Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add your Minecraft Bedrock username first',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: broadcasting ? null : _showProfileManagement,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<BedrockProfile>(
            value: widget.selectedProfile,
            decoration: InputDecoration(
              labelText: 'Bedrock Profile',
              labelStyle: TextStyle(
                color: const Color(0xFF6366F1),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              prefixIcon: const Icon(Icons.person, color: Color(0xFF6366F1)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF6366F1),
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFF6366F1).withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            hint: const Text('Select a profile'),
            isExpanded: true,
            menuMaxHeight: 300,
            items: _buildProfileMenuItems(theme),
            onChanged: broadcasting
                ? null
                : (profile) {
                    widget.onProfileChanged(profile);
                  },
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
          ),
          child: IconButton(
            onPressed: broadcasting ? null : _showProfileManagement,
            icon: const Icon(Icons.edit, size: 20),
            color: const Color(0xFF6366F1),
            tooltip: 'Manage Profiles',
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<BedrockProfile>> _buildProfileMenuItems(
    ThemeData theme,
  ) {
    final List<DropdownMenuItem<BedrockProfile>> items = [];

    for (int i = 0; i < _profiles.length; i++) {
      final profile = _profiles[i];

      items.add(
        DropdownMenuItem(
          value: profile,
          child: Row(
            children: [
              if (profile.isDefault)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 14,
                    color: Color(0xFF10B981),
                  ),
                ),
              Expanded(
                child: Text(
                  profile.label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  Widget _buildSavedServersDropdown(
    BuildContext context,
    ThemeData theme,
    bool broadcasting,
  ) {
    return Row(
      children: [
        Expanded(
          child: widget.savedServers.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'No saved servers yet',
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : DropdownButtonFormField<UserServer>(
                  value: _selectedServer,
                  decoration: InputDecoration(
                    labelText: 'Saved Servers',
                    labelStyle: TextStyle(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.storage,
                      color: Color(0xFF10B981),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF10B981),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF10B981).withOpacity(0.05),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text('Select a server or enter manually'),
                  isExpanded: true,
                  menuMaxHeight: 300,
                  items: _buildServerMenuItems(theme),
                  onChanged: broadcasting
                      ? null
                      : (server) {
                          setState(() {
                            _selectedServer = server;
                          });
                          if (server != null) {
                            widget.onServerSelected(server);
                          }
                        },
                  selectedItemBuilder: (BuildContext context) {
                    return widget.savedServers.map<Widget>((UserServer server) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              server.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
          ),
          child: IconButton(
            onPressed: broadcasting ? null : widget.onManageServers,
            icon: const Icon(Icons.edit, size: 20),
            color: const Color(0xFF10B981),
            tooltip: 'Manage Servers',
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<UserServer>> _buildServerMenuItems(ThemeData theme) {
    final List<DropdownMenuItem<UserServer>> items = [];

    for (int i = 0; i < widget.savedServers.length; i++) {
      final server = widget.savedServers[i];

      items.add(
        DropdownMenuItem(
          value: server,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.dns,
                  color: Color(0xFF10B981),
                  size: 14,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  server.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  Widget _buildInputFields(
    BuildContext context,
    ThemeData theme,
    bool broadcasting,
    bool isNarrow,
  ) {
    if (isNarrow) {
      return Column(
        children: [
          TextField(
            controller: widget.ipController,
            decoration: const InputDecoration(
              labelText: 'Server Address',
              prefixIcon: Icon(Icons.dns),
              hintText: 'play.example.com',
            ),
            enabled: !broadcasting,
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: widget.portController,
            decoration: const InputDecoration(
              labelText: 'Port',
              prefixIcon: Icon(Icons.numbers),
            ),
            enabled: !broadcasting,
            keyboardType: TextInputType.number,
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: widget.ipController,
              decoration: const InputDecoration(
                labelText: 'Server Address',
                prefixIcon: Icon(Icons.dns),
                hintText: 'play.example.com',
              ),
              enabled: !broadcasting,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: TextField(
              controller: widget.portController,
              decoration: const InputDecoration(
                labelText: 'Port',
                prefixIcon: Icon(Icons.numbers),
              ),
              enabled: !broadcasting,
              keyboardType: TextInputType.number,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildActionButtons(ThemeData theme) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.broadcastingNotifier,
      builder: (context, broadcasting, _) {
        final canStart = widget.selectedProfile != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!canStart && !broadcasting)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Select a Bedrock profile to continue',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 400) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: (broadcasting || !canStart)
                            ? null
                            : widget.onStartBroadcast,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Broadcasting'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF10B981),
                          disabledBackgroundColor: const Color(
                            0xFF065F46,
                          ).withOpacity(0.3),
                          disabledForegroundColor: Colors.white.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: broadcasting ? widget.onStopBroadcast : null,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFF87171)),
                          foregroundColor: const Color(0xFFF87171),
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (broadcasting || !canStart)
                            ? null
                            : widget.onStartBroadcast,
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: const Text('Start Broadcasting'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF10B981),
                          disabledBackgroundColor: const Color(
                            0xFF065F46,
                          ).withOpacity(0.3),
                          disabledForegroundColor: Colors.white.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: broadcasting ? widget.onStopBroadcast : null,
                      icon: const Icon(Icons.stop, size: 18),
                      label: const Text('Stop'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        side: const BorderSide(color: Color(0xFFF87171)),
                        foregroundColor: const Color(0xFFF87171),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

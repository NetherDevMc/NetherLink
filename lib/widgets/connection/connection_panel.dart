import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../theme/app_theme.dart';
import '../../util/user_servers.dart';
import '../../util/bedrock_profile.dart';
import '../../util/profile_storage.dart';
import '../../util/featured_servers.dart';
import '../../services/featured_servers_service.dart';
import '../dialogs/profile_management_dialog.dart';
import 'featured_servers_banner.dart';

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
  Future<List<FeaturedServer>>? _featuredServersFuture;

  @override
  void initState() {
    super.initState();
    _featuredServersFuture = FeaturedServersService.fetchFeaturedServers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(color: AppTheme.borderGray),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(child: Divider(color: AppTheme.borderGray)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'BEDROCK PROFILE',
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppTheme.borderGray)),
                ],
              ),
              const SizedBox(height: 20),
              _buildProfileSelector(theme),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppTheme.borderGray)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'SERVER',
                      style: TextStyle(
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppTheme.borderGray)),
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
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: widget.broadcastingNotifier,
                builder: (context, broadcasting, _) {
                  return _buildActionButton(broadcasting);
                },
              ),
              
              FutureBuilder<List<FeaturedServer>>(
                future: _featuredServersFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return FeaturedServersBanner(
                    servers: snapshot.data!,
                    onServerTap: (server) {
                      widget.ipController.text = server.address;
                      widget.portController.text = server.port.toString();
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text('Selected: ${server.name}'),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: AppTheme.primaryAccent,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSelector(ThemeData theme) {
    return FutureBuilder<List<BedrockProfile>>(
      future: ProfileStorage.loadProfiles(),
      builder: (context, snapshot) {
        final profiles = snapshot.data ?? [];

        return Row(
          children: [
            Expanded(
              child: profiles.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLight.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.borderGray),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'No profiles yet',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : DropdownButtonFormField<BedrockProfile>(
                      value: widget.selectedProfile,
                      decoration: InputDecoration(
                        labelText: 'Bedrock Profile',
                        labelStyle: const TextStyle(
                          color: AppTheme.primaryAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: AppTheme.primaryAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppTheme.primaryAccent.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppTheme.primaryAccent.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppTheme.primaryAccent,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppTheme.primaryAccent.withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      hint: const Text('Select a profile'),
                      isExpanded: true,
                      menuMaxHeight: 300,
                      items: _buildProfileMenuItems(profiles),
                      onChanged: (profile) {
                        widget.onProfileChanged(profile);
                      },
                    ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppTheme.primaryAccent.withOpacity(0.3)),
              ),
              child: IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => const ProfileManagementDialog(),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.edit, size: 20),
                color: AppTheme.primaryAccent,
                tooltip: 'Manage Profiles',
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<BedrockProfile>> _buildProfileMenuItems(
      List<BedrockProfile> profiles) {
    final List<DropdownMenuItem<BedrockProfile>> items = [];

    for (int i = 0; i < profiles.length; i++) {
      final profile = profiles[i];
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
                    color: AppTheme.primaryAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.star,
                    size: 14,
                    color: AppTheme.primaryAccent,
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
                    color: AppTheme.surfaceLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderGray),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'No saved servers yet',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textMuted,
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
                    labelStyle: const TextStyle(
                      color: AppTheme.primaryAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.storage,
                      color: AppTheme.primaryAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppTheme.primaryAccent.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppTheme.primaryAccent.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppTheme.primaryAccent,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: AppTheme.primaryAccent.withOpacity(0.05),
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
            color: AppTheme.primaryAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.primaryAccent.withOpacity(0.3)),
          ),
          child: IconButton(
            onPressed: broadcasting ? null : widget.onManageServers,
            icon: const Icon(Icons.edit, size: 20),
            color: AppTheme.primaryAccent,
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
                  color: AppTheme.primaryAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.dns,
                  color: AppTheme.primaryAccent,
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
            enabled: !broadcasting,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              labelText: 'Server Address',
              hintText: 'play.example.com',
              hintStyle: TextStyle(color: AppTheme.textMuted),
              prefixIcon: const Icon(
                Icons.dns,
                color: AppTheme.primaryAccent,
              ),
              labelStyle: const TextStyle(color: AppTheme.primaryAccent),
              filled: true,
              fillColor: AppTheme.surfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppTheme.primaryAccent,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: widget.portController,
            enabled: !broadcasting,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              labelText: 'Port',
              hintText: '19132',
              hintStyle: TextStyle(color: AppTheme.textMuted),
              prefixIcon: const Icon(
                Icons.settings_ethernet,
                color: AppTheme.primaryAccent,
              ),
              labelStyle: const TextStyle(color: AppTheme.primaryAccent),
              filled: true,
              fillColor: AppTheme.surfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppTheme.primaryAccent,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: widget.ipController,
            enabled: !broadcasting,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              labelText: 'Server Address',
              hintText: 'play.example.com',
              hintStyle: TextStyle(color: AppTheme.textMuted),
              prefixIcon: const Icon(
                Icons.dns,
                color: AppTheme.primaryAccent,
              ),
              labelStyle: const TextStyle(color: AppTheme.primaryAccent),
              filled: true,
              fillColor: AppTheme.surfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppTheme.primaryAccent,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: TextField(
            controller: widget.portController,
            enabled: !broadcasting,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              labelText: 'Port',
              hintText: '19132',
              hintStyle: TextStyle(color: AppTheme.textMuted),
              labelStyle: const TextStyle(color: AppTheme.primaryAccent),
              filled: true,
              fillColor: AppTheme.surfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppTheme.primaryAccent,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppTheme.borderGray),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(bool broadcasting) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: broadcasting ? widget.onStopBroadcast : widget.onStartBroadcast,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              broadcasting ? AppTheme.error : AppTheme.primaryAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              broadcasting ? Icons.stop_circle : Icons.play_circle_filled,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              broadcasting ? 'STOP BROADCASTING' : 'START BROADCASTING',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
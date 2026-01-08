import 'package:flutter/material.dart';
import '../../util/bedrock_profile.dart';
import '../../util/profile_storage.dart';

class ProfileManagementDialog extends StatefulWidget {
  const ProfileManagementDialog({super.key});

  @override
  State<ProfileManagementDialog> createState() =>
      _ProfileManagementDialogState();
}

class _ProfileManagementDialogState extends State<ProfileManagementDialog> {
  List<BedrockProfile> _profiles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final profiles = await ProfileStorage.loadProfiles();
    setState(() {
      _profiles = profiles;
      _loading = false;
    });
  }

  Future<void> _addProfile() async {
    final result = await showDialog<BedrockProfile>(
      context: context,
      builder: (context) => const AddProfileDialog(),
    );

    if (result != null) {
      await ProfileStorage.addProfile(result);
      _loadProfiles();
    }
  }

  Future<void> _editProfile(BedrockProfile profile) async {
    final result = await showDialog<BedrockProfile>(
      context: context,
      builder: (context) => AddProfileDialog(profile: profile),
    );

    if (result != null) {
      await ProfileStorage.updateProfile(profile.id, result);
      _loadProfiles();
    }
  }

  Future<void> _deleteProfile(BedrockProfile profile) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A1419),
        title: const Text(
          'Delete Profile',
          style: TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
        ),
        content: Text(
          'Delete profile "${profile.label}"? ',
          style: TextStyle(
            color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF87171),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ProfileStorage.removeProfile(profile.id);
      _loadProfiles();
    }
  }

  Future<void> _setDefault(BedrockProfile profile) async {
    final updated = profile.copyWith(isDefault: true);
    await ProfileStorage.updateProfile(profile.id, updated);
    _loadProfiles();
  }

  void _showProfileMenu(BedrockProfile profile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A1419),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF152228),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D9FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF00D9FF),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.label,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 208, 209, 209),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          profile.username,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 208, 209, 209)
                                .withOpacity(0.6),
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color(0xFF152228),
              height: 1,
            ),
            if (! profile.isDefault)
              ListTile(
                leading: const Icon(Icons.star, color: Color(0xFFFFD700)),
                title: const Text(
                  'Set as Default',
                  style: TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _setDefault(profile);
                },
              ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF00D9FF)),
              title: const Text(
                'Edit Profile',
                style: TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              ),
              onTap: () {
                Navigator.pop(context);
                _editProfile(profile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFFF87171)),
              title: const Text(
                'Delete Profile',
                style: TextStyle(color: Color(0xFFF87171)),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteProfile(profile);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0A1419),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D9FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_circle,
                      color: Color(0xFF00D9FF),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bedrock Profiles',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 208, 209, 209),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage your Minecraft Bedrock accounts',
                          style: TextStyle(
                            fontSize: 13,
                            color: const Color.fromARGB(255, 208, 209, 209)
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: const Color.fromARGB(255, 208, 209, 209)
                          .withOpacity(0.6),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00D9FF),
                      ),
                    )
                  :  _profiles.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_off_outlined,
                                size: 64,
                                color: const Color(0xFF152228),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No profiles yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 208, 209, 209)
                                      .withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add your first Bedrock profile to get started',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: const Color.fromARGB(255, 208, 209, 209)
                                      .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _profiles.length,
                          itemBuilder: (context, index) {
                            final profile = _profiles[index];
                            return _buildProfileCard(profile);
                          },
                        ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addProfile,
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Add Profile',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D9FF),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BedrockProfile profile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF152228),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: profile.isDefault
              ? const Color(0xFFFFD700).withOpacity(0.5)
              : const Color(0xFF00D9FF).withOpacity(0.3),
          width: profile.isDefault ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showProfileMenu(profile),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: profile.isDefault
                            ? const Color(0xFFFFD700).withOpacity(0.15)
                            : const Color(0xFF00D9FF).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.person,
                        color: profile.isDefault
                            ?  const Color(0xFFFFD700)
                            : const Color(0xFF00D9FF),
                        size: 28,
                      ),
                    ),
                    if (profile.isDefault)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF152228),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.label,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 208, 209, 209),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.badge,
                            size: 14,
                            color: const Color.fromARGB(255, 208, 209, 209)
                                .withOpacity(0.6),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              profile.username,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 208, 209, 209)
                                    .withOpacity(0.6),
                                fontFamily: 'monospace',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.more_vert,
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddProfileDialog extends StatefulWidget {
  final BedrockProfile? profile;

  const AddProfileDialog({super.key, this.profile});

  @override
  State<AddProfileDialog> createState() => _AddProfileDialogState();
}

class _AddProfileDialogState extends State<AddProfileDialog> {
  late final TextEditingController _usernameController;
  late final TextEditingController _displayNameController;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.profile?.username ?? '',
    );
    _displayNameController = TextEditingController(
      text: widget.profile?.displayName ?? '',
    );
    _isDefault = widget.profile?.isDefault ?? false;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void _save() {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Username is required'),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      BedrockProfile(
        id: widget.profile?.id ?? ProfileStorage.generateId(),
        username: username,
        displayName: _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
        isDefault: _isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0A1419),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.profile == null ? 'Add Profile' : 'Edit Profile',
        style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Bedrock Username *',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
                ),
                hintText: 'Your Minecraft username',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.4),
                ),
                prefixIcon: const Icon(Icons.badge, color: Color(0xFF00D9FF)),
                filled: true,
                fillColor: const Color(0xFF152228),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF152228)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF00D9FF),
                    width: 2,
                  ),
                ),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _displayNameController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Display Name (Optional)',
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
                ),
                hintText: 'Friendly name for this profile',
                hintStyle:  TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.4),
                ),
                prefixIcon: const Icon(Icons.label, color: Color(0xFF00D9FF)),
                filled: true,
                fillColor: const Color(0xFF152228),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF152228)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF00D9FF),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF152228),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF00D9FF).withOpacity(0.3),
                ),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Set as default profile',
                  style: TextStyle(
                    color: Color.fromARGB(255, 208, 209, 209),
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  'Use this profile by default',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                value: _isDefault,
                onChanged: (value) {
                  setState(() => _isDefault = value);
                },
                activeColor: const Color(0xFFFFD700),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D9FF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
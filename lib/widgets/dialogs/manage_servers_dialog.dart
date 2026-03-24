import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../util/user_servers.dart';
import '../../util/user_servers_storage.dart';

class ManageServersDialog extends StatefulWidget {
  const ManageServersDialog({super.key});

  @override
  State<ManageServersDialog> createState() => _ManageServersDialogState();
}

class _ManageServersDialogState extends State<ManageServersDialog> {
  List<UserServer> _servers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  Future<void> _loadServers() async {
    final servers = await UserServersStorage.loadServers();
    setState(() {
      _servers = servers;
      _loading = false;
    });
  }

  Future<void> _addServer() async {
    final result = await showDialog<UserServer>(
      context: context,
      builder: (context) => const AddServerDialog(),
    );

    if (result != null) {
      await UserServersStorage.addServer(result);
      _loadServers();
    }
  }

  Future<void> _editServer(int index) async {
    final result = await showDialog<UserServer>(
      context: context,
      builder: (context) => AddServerDialog(server: _servers[index]),
    );

    if (result != null) {
      await UserServersStorage.updateServer(index, result);
      _loadServers();
    }
  }

  Future<void> _deleteServer(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: const Text(
          'Delete Server',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: Text(
          'Delete "${_servers[index].name}"?',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await UserServersStorage.removeServer(index);
      _loadServers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 550, maxHeight: 650),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.storage,
                    color: AppTheme.primaryAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Servers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Quick access servers',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppTheme.textMuted),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryAccent,
                      ),
                    )
                  : _servers.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dns_outlined,
                            size: 64,
                            color: AppTheme.borderGray,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No saved servers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add servers to quickly connect later',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _servers.length,
                      itemBuilder: (context, index) {
                        final server = _servers[index];
                        return _buildServerCard(server, index, theme);
                      },
                    ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addServer,
                icon: const Icon(Icons.add),
                label: const Text('Add Server'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerCard(UserServer server, int index, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryAccent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.dns,
                    color: AppTheme.primaryAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    server.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () => _editServer(index),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    color: AppTheme.primaryAccent,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    onPressed: () => _deleteServer(index),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    color: AppTheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.primaryAccent.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: AppTheme.primaryAccent.withOpacity(0.7),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${server.address}:${server.port}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (server.description != null &&
                server.description!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 14, color: AppTheme.textMuted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      server.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddServerDialog extends StatefulWidget {
  final UserServer? server;

  const AddServerDialog({super.key, this.server});

  @override
  State<AddServerDialog> createState() => _AddServerDialogState();
}

class _AddServerDialogState extends State<AddServerDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _portController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.server?.name ?? '');
    _addressController = TextEditingController(
      text: widget.server?.address ?? '',
    );
    _portController = TextEditingController(
      text: widget.server?.port.toString() ?? '19132',
    );
    _descriptionController = TextEditingController(
      text: widget.server?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _portController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final address = _addressController.text.trim();
    final portStr = _portController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('⚠️ Name and address are required'),
          backgroundColor: AppTheme.warning,
        ),
      );
      return;
    }

    final port = int.tryParse(portStr);
    if (port == null || port < 1 || port > 65535) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('⚠️ Invalid port number'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      UserServer(
        name: name,
        address: address,
        port: port,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Add Server',
        style: TextStyle(color: AppTheme.textPrimary),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                labelText: 'Server Name *',
                hintText: 'My Awesome Server',
                hintStyle: TextStyle(color: AppTheme.textMuted),
                prefixIcon: const Icon(
                  Icons.label,
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
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                labelText: 'Address *',
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
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _portController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                labelText: 'Port *',
                prefixIcon: const Icon(
                  Icons.numbers,
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
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Survival server with friends',
                hintStyle: TextStyle(color: AppTheme.textMuted),
                prefixIcon: const Icon(
                  Icons.description,
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
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

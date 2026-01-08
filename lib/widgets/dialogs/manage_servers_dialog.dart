import 'package:flutter/material.dart';
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
        backgroundColor: const Color(0xFF0A1419),
        title: const Text(
          'Delete Server',
          style: TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
        ),
        content: Text(
          'Delete "${_servers[index].name}"?',
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
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFF87171)),
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
      backgroundColor: const Color(0xFF0A1419),
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
                    color: const Color(0xFF00D9FF).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.storage,
                    color: Color(0xFF00D9FF),
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
                          color: Color.fromARGB(255, 208, 209, 209),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Quick access servers',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 208, 209, 209)
                              .withOpacity(0.5),
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
            const SizedBox(height: 20),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00D9FF),
                      ),
                    )
                  :  _servers.isEmpty
                      ?  Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dns_outlined,
                                size: 64,
                                color: const Color(0xFF152228),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No saved servers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 208, 209, 209)
                                      .withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add servers to quickly connect later',
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
                  backgroundColor: const Color(0xFF00D9FF),
                  foregroundColor: Colors.black,
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
        color: const Color(0xFF152228),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00D9FF).withOpacity(0.3),
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
                    color: const Color(0xFF00D9FF).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.dns,
                    color: Color(0xFF00D9FF),
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
                      color: Color.fromARGB(255, 208, 209, 209),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D9FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () => _editServer(index),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    color: const Color(0xFF00D9FF),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF87171).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    onPressed: () => _deleteServer(index),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    color: const Color(0xFFF87171),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0A1419),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF00D9FF).withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: const Color(0xFF00D9FF).withOpacity(0.7),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${server.address}:${server.port}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 208, 209, 209),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (server.description != null && server.description!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: const Color.fromARGB(255, 208, 209, 209)
                        .withOpacity(0.5),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      server.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color.fromARGB(255, 208, 209, 209)
                            .withOpacity(0.6),
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
        const SnackBar(
          content: Text('⚠️ Name and address are required'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final port = int.tryParse(portStr);
    if (port == null || port < 1 || port > 65535) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Invalid port number'),
          backgroundColor: Colors.red,
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
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: const Color(0xFF0A1419),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Add Server',
        style: TextStyle(
          color: Color.fromARGB(255, 208, 209, 209),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Server Name *',
                hintText: 'My Awesome Server',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.4),
                ),
                prefixIcon: const Icon(Icons.label, color: Color(0xFF00D9FF)),
                labelStyle: const TextStyle(color: Color(0xFF00D9FF)),
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
              controller: _addressController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Address *',
                hintText: 'play.example.com',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.4),
                ),
                prefixIcon: const Icon(Icons.dns, color: Color(0xFF00D9FF)),
                labelStyle: const TextStyle(color: Color(0xFF00D9FF)),
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
            const SizedBox(height: 16),
            TextField(
              controller: _portController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Port *',
                prefixIcon: const Icon(Icons.numbers, color: Color(0xFF00D9FF)),
                labelStyle: const TextStyle(color: Color(0xFF00D9FF)),
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
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Color.fromARGB(255, 208, 209, 209)),
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Survival server with friends',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 208, 209, 209).withOpacity(0.4),
                ),
                prefixIcon: const Icon(Icons.description, color: Color(0xFF00D9FF)),
                labelStyle: const TextStyle(color: Color(0xFF00D9FF)),
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
              maxLines: 2,
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
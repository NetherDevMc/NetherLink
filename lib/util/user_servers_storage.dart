import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'user_servers.dart';

class UserServersStorage {
  static const String _fileName = 'user_servers.json';

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<List<UserServer>> loadServers() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) return [];

      final String contents = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(contents);
      return decoded.map((json) => UserServer.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveServers(List<UserServer> servers) async {
    final file = await _getFile();
    final List<Map<String, dynamic>> jsonList = servers
        .map((s) => s.toJson())
        .toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<void> addServer(UserServer server) async {
    final servers = await loadServers();
    servers.add(server);
    await saveServers(servers);
  }

  static Future<void> removeServer(int index) async {
    final servers = await loadServers();
    if (index >= 0 && index < servers.length) {
      servers.removeAt(index);
      await saveServers(servers);
    }
  }

  static Future<void> updateServer(int index, UserServer server) async {
    final servers = await loadServers();
    if (index >= 0 && index < servers.length) {
      servers[index] = server;
      await saveServers(servers);
    }
  }
}

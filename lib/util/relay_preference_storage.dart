import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class RelayPreferenceStorage {
  static const String _fileName = 'selected_relay.json';

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  static Future<String?> loadSelectedRelayIp() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) return null;
      final content = await file.readAsString();
      final decoded = json.decode(content);
      return decoded['relayIp'] as String?;
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveSelectedRelayIp(String? ip) async {
    if (ip == null) return;
    final file = await _getFile();
    await file.writeAsString(json.encode({'relayIp': ip}));
  }
}
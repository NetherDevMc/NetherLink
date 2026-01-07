import 'dart:convert';
import 'package:http/http.dart' as http;
import '../util/server_entry.dart';

class ServerLoader {
  final String jsonUrl;

  ServerLoader({required this.jsonUrl});

  Future<List<ServerEntry>> loadServers() async {
    try {
      final response = await http.get(Uri.parse(jsonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((entry) => ServerEntry.fromJson(entry)).toList();
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load servers: $e');
    }
  }
}

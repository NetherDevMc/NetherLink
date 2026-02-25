import 'dart:convert';
import 'dart:io';
import '../util/featured_servers.dart';

class FeaturedServersService {
  static const String _endpoint =
      'https://raw.githubusercontent.com/NetherDevMc/FeaturedServers/refs/heads/main/featured-servers';
  static const Duration _timeout = Duration(seconds: 5);

  static Future<List<FeaturedServer>> fetchFeaturedServers() async {
    try {
      final client = HttpClient();
      client.connectionTimeout = _timeout;

      final request = await client.getUrl(Uri.parse(_endpoint));
      final response = await request.close();

      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        final List<dynamic> jsonList = json.decode(body);
        return jsonList.map((json) => FeaturedServer.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
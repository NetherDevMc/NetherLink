import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static Future<Map<String, String>?> fetchNotice(String base) async {
    final uri = Uri.parse('$base/notification');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) return null;
      final jsonData = json.decode(response.body);
      if (jsonData is Map &&
          jsonData['message'] != null &&
          (jsonData['message'] as String).trim().isNotEmpty) {
        return {
          "title": jsonData["title"] ?? "NetherLink Notice",
          "message": jsonData["message"] ?? "",
          "type": jsonData["type"] ?? "info",
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
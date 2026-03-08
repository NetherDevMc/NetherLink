import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String notificationUrl = 'https://raw.githubusercontent.com/NetherDevMc/NetherLinkData/refs/heads/main/notifications/notice.json';

  static Future<Map<String, String>?> fetchNotice() async {
    try {
      final response = await http.get(Uri.parse(notificationUrl));
      if (response.statusCode != 200) return null;
      final jsonData = json.decode(response.body);
      if (jsonData is Map && jsonData['message'] != null && (jsonData['message'] as String).trim().isNotEmpty) {
        return {
          "title": jsonData["title"] ?? "NetherLink Notice",
          "message": jsonData["message"] ?? "",
          "type": jsonData["type"] ?? "info",
        };
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
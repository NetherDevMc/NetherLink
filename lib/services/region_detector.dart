import 'dart:async';
import 'dart:io';
import '../constants/app_constants.dart';

class RegionDetector {
  static Future<String?> detectBestRelayIp() async {
    final relays = AppConstants.relayServers;

    final results = await Future.wait(relays.map((r) => _httpPing(r['ip']!)));

    String? bestIp;
    int bestMs = 999999;

    for (var i = 0; i < relays.length; i++) {
      final ms = results[i];
      if (ms != null && ms < bestMs) {
        bestMs = ms;
        bestIp = relays[i]['ip'];
      }
    }

    return bestIp ?? relays[0]['ip'];
  }

  static Future<int?> _httpPing(String ip) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 4);

      final sw = Stopwatch()..start();
      final req = await client.getUrl(Uri.parse('http://$ip/ping'));
      final res = await req.close();
      sw.stop();

      await res.drain();
      client.close();

      if (res.statusCode == 200) {
        return sw.elapsedMilliseconds;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

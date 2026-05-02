import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class RelayPingResult {
  final String ip;
  final String base;
  final String name;
  final int latencyMs;
  final String? version;

  const RelayPingResult({
    required this.ip,
    required this.base,
    required this.name,
    required this.latencyMs,
    this.version,
  });
}

class RegionDetector {
  static Future<RelayPingResult> detectBestRelay() async {
    final relays = AppConstants.relayServers;

    final List<RelayPingResult?> httpsResults = await Future.wait(
      relays.map<Future<RelayPingResult?>>((r) => _versionPing(r)),
    );

    RelayPingResult? best;
    for (final result in httpsResults) {
      if (result != null &&
          (best == null || result.latencyMs < best.latencyMs)) {
        best = result;
      }
    }

    if (best != null) return best;

    final List<int?> httpPings = await Future.wait(
      relays.map<Future<int?>>((r) => _httpPing(r['ip']!)),
    );

    int bestMs = 999999;
    int bestIdx = 0;
    for (int i = 0; i < relays.length; i++) {
      final ms = httpPings[i];
      if (ms != null && ms < bestMs) {
        bestMs = ms;
        bestIdx = i;
      }
    }

    final fallback = relays[bestIdx];
    return RelayPingResult(
      ip: fallback['ip']!,
      base: fallback['base']!,
      name: fallback['name']!,
      latencyMs: bestMs,
      version: null,
    );
  }

  static Future<RelayPingResult?> _versionPing(
      Map<String, String> relay) async {
    try {
      final sw = Stopwatch()..start();
      final response = await http
          .get(Uri.parse('${relay['api']}/version'))
          .timeout(const Duration(seconds: 5));
      sw.stop();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RelayPingResult(
          ip: relay['ip']!,
          base: relay['base']!,
          name: relay['name']!,
          latencyMs: sw.elapsedMilliseconds,
          version: data['version'] as String?,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<int?> _httpPing(String ip) async {
    try {
      final sw = Stopwatch()..start();
      final response = await http
          .get(Uri.parse('http://$ip/ping'))
          .timeout(const Duration(seconds: 4));
      sw.stop();

      if (response.statusCode == 200) return sw.elapsedMilliseconds;
      return null;
    } catch (_) {
      return null;
    }
  }
}

import '../constants/app_constants.dart';

class RelayHelper {
  static String apiBaseFor(String ip) {
    final relay = AppConstants.relayServers.firstWhere(
      (e) => e['ip'] == ip,
      orElse: () => {'api': 'https://$ip'},
    );
    final api = (relay['api'] ?? 'https://$ip').toString();
    return api.replaceAll(RegExp(r'/$'), '');
  }
}
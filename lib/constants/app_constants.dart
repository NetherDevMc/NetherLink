class AppConstants {
  static const String websiteUrl = 'https://netherlink.net';
  static const String discordUrl = 'https://discord.gg/xvaNzE35Rs';

static const relayServers = [
  {
    'name': 'EU Server',
    'ip': '161.97.182.113',
    'base': 'https://eubackend.netherlink.net',
    'api': 'https://eubackend.netherlink.net/api',
  },
  {
    'name': 'US Server',
    'ip': '217.77.15.138',
    'base': 'https://usbackend.netherlink.net',
    'api': 'https://usbackend.netherlink.net/api',
  },
];

  static const Duration serverRotationDuration = Duration(seconds: 5);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration progressUpdateInterval = Duration(milliseconds: 50);

  static const int maxLogEntries = 1000;

  static const double borderRadius = 12.0;
  static const double cardHeight = 140.0;
  static const double mobileBreakpoint = 700.0;
  static const double narrowBreakpoint = 500.0;

  static const String appCreator = 'NetherDev';
}
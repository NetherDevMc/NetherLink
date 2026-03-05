class AppConstants {
  static const String websiteUrl = 'https://netherlink.net';
  static const String discordUrl = 'https://discord.gg/xvaNzE35Rs';

  static const String defaultServerAddress = 'mc.cosmosmc.org';

  static const relayServers = [
    {
      'name': 'EU Server',
      'ip': '161.97.182.113',
    },
    {
      'name': 'US Server',
      'ip': '217.77.15.138',
    },
  ];

  //'ip': '161.97.182.113',

  static const Duration serverRotationDuration = Duration(seconds: 5);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration progressUpdateInterval = Duration(milliseconds: 50);

  static const int maxLogEntries = 1000;

  static const double borderRadius = 12.0;
  static const double cardHeight = 140.0;
  static const double mobileBreakpoint = 700.0;
  static const double narrowBreakpoint = 500.0;

  static const String appCreator = 'NetherDev';

static const String helpText = '''
Created by $appCreator.

How to use:
1. Enter your Minecraft server address and port (default: 19132)
   — or select a previously saved server from the dropdown
2. (Optional) Choose a Relay Server (EU or US) closest to your location
3. Click "Start Broadcasting" to begin
4. On your console/device: Minecraft > Play > Friends
5. You should see a LAN server called "NetherLink"
6. Click it to join your external server via NetherLink

Nintendo Switch (DNS mode):
1. Enable "Nintendo Switch" in the connection panel
2. Select a Relay Server (EU or US)
3. Click "Send DNS Config" — this sends your config to the relay
   (it does NOT broadcast a LAN server)
4. On your Switch, apply your NetherLink DNS setup and join
   using the server entry you use for NetherLink

Notes:
- For LAN broadcasting, NetherLink and console must be on the same local network.
- Tip: Choose the relay server closest to you for the best performance.''';
}
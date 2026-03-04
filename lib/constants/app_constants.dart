class AppConstants {
  static const String websiteUrl = 'https://netherlink.net';
  static const String discordUrl = 'https://discord.gg/xvaNzE35Rs';

  static const String defaultServerAddress = 'play.myserver.com';

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

How to use (PlayStation / Xbox / Android / iOS):
1. Create a Bedrock Profile with your Minecraft username
2. Add your external Minecraft server details (or select a saved server)
3. Enter the server address and port (default: 19132)
4. (Optional) Open "Advanced" and choose a Relay Server (EU or US) closest to your location
5. Click "Start Broadcasting" to begin
6. On your console/device: Minecraft > Play > Friends
7. You should see a LAN server called "NetherLink"
8. Click it to join your external server via NetherLink

Nintendo Switch (DNS mode):
1. Open "Advanced" and enable "Nintendo Switch (DNS mode)"
2. Select a Relay Server (EU or US)
3. Click "Start DNS (Nintendo)" (this sends your config to the relay; it does NOT broadcast a LAN server)
4. On your Switch, apply your NetherLink DNS setup and join using the server entry you use for NetherLink

Features:
- Manage multiple Bedrock profiles for different players
- Save frequently used servers for quick access
- Set a default profile to use automatically
- Choose between EU and US relay servers for the best connection
- Nintendo Switch support via DNS mode (config-only)
- View real-time connection logs in the console
- Enable Debug Mode to see detailed network logs

Notes:
- For LAN broadcasting, your PC and console must be on the same local network.
Tip: Choose the relay server closest to you for the best performance.''';
}
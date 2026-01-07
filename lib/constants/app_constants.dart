class AppConstants {
  static const String serversApiUrl =
      'https://backend.netherlink.net/api/servers';
  static const String websiteUrl = 'https://netherlink.net';
  static const String discordUrl = 'https://discord.gg/xvaNzE35Rs';

  static const String defaultServerAddress = 'test.geysermc.org';

  static const Duration serverRotationDuration = Duration(seconds: 5);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration progressUpdateInterval = Duration(milliseconds: 50);

  static const int maxLogEntries = 1000;

  static const double borderRadius = 12.0;
  static const double cardHeight = 140.0;
  static const double mobileBreakpoint = 700.0;
  static const double narrowBreakpoint = 500.0;

  static const String appVersion = '2.0';
  static const String appCreator = 'Jens-Co';

  static const String helpText =
      '''NetherLink version $appVersion
Created by $appCreator.

How to use:
1. Create a Bedrock Profile with your Minecraft username
2. Add your external Minecraft server details (or select a saved server)
3. Enter the server address and port (default: 19132)
4. Click "Start Broadcasting" to begin
5. On your PlayStation or Bedrock device, go to "Play" > "Friends"
6. You should see a LAN game under your profile name
7. Click it to join your external server via NetherLink!

Features:
- Manage multiple Bedrock profiles for different players
- Save frequently used servers for quick access
- Set a default profile to use automatically
- View real-time connection logs in the console
- Enable Debug Mode to see detailed network logs

Note: Your PC and console must be on the same local network.''';
}

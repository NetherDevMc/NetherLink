// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Console';

  @override
  String get consoleOutput => 'Console Output';

  @override
  String get noLogsYet => 'No logs yet';

  @override
  String get startBroadcastingToSeeOutput => 'Start broadcasting to see output';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Join Us';

  @override
  String get more => 'More';

  @override
  String get website => 'Website';

  @override
  String get howToUseMenu => 'How to use';

  @override
  String get support => 'Support';

  @override
  String helpText(Object appCreator) {
    return 'Created by $appCreator.\n\nHow to use:\n1. Enter your Minecraft server address and port (default: 19132)\n   — or select a previously saved server from the dropdown\n2. (Optional) Choose a Relay Server (EU or US) closest to your location\n3. Click \"Start Broadcasting\" to begin\n4. On your console/device: Minecraft > Play > Friends\n5. You should see a LAN server called \"NetherLink\"\n6. Click it to join your external server via NetherLink\n\nNintendo Switch (DNS mode):\n1. Enable \"Nintendo Switch\" in the connection panel\n2. Select a Relay Server (EU or US)\n3. Click \"Send DNS Config\" — this sends your config to the relay\n   (it does NOT broadcast a LAN server)\n4. On your Switch, apply your NetherLink DNS setup and join\n   using the server entry you use for NetherLink\n\nNotes:\n- For LAN broadcasting, NetherLink and console must be on the same local network.\n- Tip: Choose the relay server closest to you for the best performance.';
  }

  @override
  String get serverDetailsLabel => 'Server Details';

  @override
  String get start => 'Start';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Start Java Mode';

  @override
  String get javaInfoTitle => 'Java Mode';

  @override
  String get javaInfoText => 'Connect to Java Edition servers';

  @override
  String get howToJavaTitle => 'Java Mode';

  @override
  String get howToJavaSubtitle => 'Connect to Java Edition servers via NetherLink';

  @override
  String get aternosSubtext => 'Create your own free Minecraft server';

  @override
  String get howToJavaBody => 'Java Mode — quick steps:\n1. In the app, select Java mode.\n2. Enter your Java Edition server address and port (default: 25565).\n3. Press \"Start Java Mode\" — NetherLink bridges the connection.\n4. Open Minecraft Bedrock and go to the Friends tab.\n5. Select the LAN server named \"NetherLink\" to join the Java server.\n\n⚠️ Important warnings:\n- A valid Java Edition account (Microsoft) is required.\n- Some servers use anti-cheat systems that may detect and ban your account.\n- Certain servers explicitly prohibit Bedrock clients — always check the server rules.\n- NetherLink is not responsible for any account bans, suspensions, or other account-related issues that may result from using this feature.\n- Use at your own risk.';

  @override
  String get language => 'English';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Toggle debug';

  @override
  String get copyLogs => 'Copy logs';

  @override
  String get clear => 'Clear';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteServer => 'Delete Server';

  @override
  String get delete => 'Delete';

  @override
  String get myServers => 'My Servers';

  @override
  String get quickAccessServers => 'Quick access servers';

  @override
  String get addServer => 'Add Server';

  @override
  String get addServersHint => 'Add servers to quickly connect later';

  @override
  String get serverNameLabel => 'Server Name *';

  @override
  String get addressLabel => 'Address *';

  @override
  String get portLabel => 'Port *';

  @override
  String get descriptionLabel => 'Description (Optional)';

  @override
  String get save => 'Save';

  @override
  String get initializing => 'Initializing...';

  @override
  String get createdBy => 'Created by NetherDev';

  @override
  String get bedrockBridge => 'Bedrock Bridge';

  @override
  String get clientDisconnected => 'Client disconnected — Broadcast stopped';

  @override
  String get pleaseEnterServer => '⚠️ Please enter a server address';

  @override
  String get invalidPort => '⚠️ Invalid port number (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS config sent to relay';

  @override
  String get broadcastingStarted => 'Broadcasting started';

  @override
  String get broadcastStopped => 'Broadcast stopped';

  @override
  String selectedServer(Object name) {
    return '📋 Selected: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Selected: $name';
  }

  @override
  String get noLogsToCopy => 'No logs to copy';

  @override
  String copiedLogs(Object count) {
    return 'Copied $count log entries to clipboard';
  }

  @override
  String get debugEnabled => 'Debug logs enabled';

  @override
  String get debugDisabled => 'Debug logs disabled';

  @override
  String get howToUseTitle => 'How to use NetherLink';

  @override
  String get iUnderstand => 'I understand';

  @override
  String get playOnSwitchTitle => 'Play on Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Play with Friends';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Selected: $relayName\n\nHow to connect:\n1. Go to your Switch Settings and change the DNS to: $relayIp\n2. Open Minecraft and select a server from the list (like Cubecraft or Hive).\n3. You will now be sent to your own server automatically.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'How to connect:\n1. On your console, add $friend as a friend.\n2. Open Minecraft and go to the Friends tab.\n3. Look for your server under LAN Worlds and select it to join.';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'Select relay $name';
  }

  @override
  String get noSavedServers => 'No saved servers';

  @override
  String get savedServers => 'Saved servers';

  @override
  String get serverAddressHint => 'Server Address';

  @override
  String get portHint => 'Port';

  @override
  String get manageServers => 'Manage servers';

  @override
  String get manageServersTooltip => 'Manage servers';

  @override
  String get stopBroadcasting => 'Stop Broadcasting';

  @override
  String get startNintendoMode => 'Start Nintendo Mode';

  @override
  String get startFriendsMode => 'Start Friends Mode';

  @override
  String get startBroadcasting => 'Start Broadcasting';

  @override
  String get modeLabel => 'Mode';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Friends';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS mode';

  @override
  String get nintendoInfoText => 'Start in Nintendo mode, set your DNS and join a featured server.';

  @override
  String get friendModeTitle => 'Friend mode';

  @override
  String get friendModeText => 'Add NetherLink\'s friends bots as a friend. Start Friends mode and play';

  @override
  String get selectedRelayCheck => 'Selected';

  @override
  String relayFallbackWarning(Object name) {
    return 'Warning: original relay did not respond. Fallback relay in use: $name';
  }

  @override
  String get relayUnableConnect => 'Unable to connect to ANY NetherLink relay server. Try again later or check your internet.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Play via LAN broadcast or proxy';

  @override
  String get howToXboxBody => 'How to connect (Xbox / PS4 / PS5):\n1. Ensure your device running NetherLink and your console are on the same local network.\n2. In the app, enter your Minecraft server address and port and press \"Start Broadcasting\".\n3. On the console open Minecraft → Play → look for LAN Worlds or the Friends tab and refresh the list.\n4. Select the LAN server named \"NetherLink\" to join.\nNotes:\n- If the server does not appear, confirm both devices are on the same subnet and that the app is still broadcasting.\n- Some console models or routers may block LAN discovery; try toggling the app or router settings if needed.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS mode)';

  @override
  String get howToNintendoSubtitle => 'DNS relay instructions for Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS mode (step-by-step):\n1. In the app enable \"Nintendo\" mode and select a Relay Server (EU or US).\n2. Tap \"Send DNS Config\" to push the DNS IP to the relay.\n3. On your Nintendo Switch go to System Settings → Internet → Internet Settings → (your network) → Change Settings → DNS and set the Primary DNS to the relay IP.\n4. Open Minecraft and join a public server; you will be redirected to your server using the relay DNS.\nNotes:\n- DNS mode does not broadcast a LAN server; it routes game traffic through the relay.\n- Revert your DNS after you are done if you need normal network behavior.';

  @override
  String get howToFriendsTitle => 'Friends mode';

  @override
  String get howToFriendsSubtitle => 'Invite friends and join via LAN';

  @override
  String get howToFriendsBody => 'Friends mode — quick steps:\n1. Add the NetherLink friend account (relay friend) on your console or platform if required.\n2. In the app enable Friends mode and send the relay configuration (if applicable).\n3. On your console open Minecraft → Friends and search for LAN Worlds — your server should appear there as a LAN world.\n4. Select it to join your server with friends.\nNotes:\n- Make sure both you and your friends have the same NAT/settings that allow friend presence.\n- Friend-mode relies on platform friend features and may require accepting friend requests.';

  @override
  String get helpNetherlinkTitle => 'NetherLink does not appear';

  @override
  String get helpNetherlinkSubtitle => 'Troubleshooting LAN discovery issues';

  @override
  String get helpNetherlinkBody => 'If the server isn\'t appearing on your console, try these steps:\n\n✅ Basic Checks:\n1. Same WiFi Network - Your phone/tablet and console MUST be on the same WiFi\n2. Correct Server Address - Double-check the IP and port (default: 19132)\n3. Broadcasting Active - Verify NetherLink shows \"Broadcasting\" status\n\n🔄 Quick Fixes:\n• Restart the app: Stop broadcasting, close NetherLink completely, reopen and try again\n• Restart your console: Sometimes the console needs a refresh to detect LAN games\n• Check Friends/LAN tab: The server appears under \"Friends\" or \"LAN Games\", NOT in server list\n• Wait 10-15 seconds after starting broadcasting\n• Disable VPNs: VPNs can block local broadcasts\n\n⚠️ Common Issues:\n\"No route found for user\" → Ensure both devices are on the same Wi‑Fi (avoid Guest networks)\n\"Unable to connect to NetherLink relay server\" → Check your internet / relay status\n\n📱 Still having issues? Enable Debug Mode in NetherLink and check logs, or try a different server.';

  @override
  String get helpMultiplayerFailedTitle => 'Multiplayer Connection Failed';

  @override
  String get helpMultiplayerFailedSubtitle => 'Explanation why this is not a NetherLink error';

  @override
  String get helpMultiplayerFailedBody => '⚠️ This is not an issue with NetherLink!\n\nNetherLink successfully redirected you to the requested server. The message \"Multiplayer Connection Failed\" indicates that the target server is currently unreachable. Possible reasons:\n\n• The target Minecraft server is offline or overloaded\n• The server requires an updated client version or specific edition\n• Network issues between the relay and the target server\n\nTry connecting to a different server or contact the server\'s support. If the problem persists for multiple servers, enable Debug Mode in NetherLink and check logs.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS does not work';

  @override
  String get helpNintendoDnsSubtitle => 'Common DNS / relay issues';

  @override
  String get helpNintendoDnsBody => 'If Nintendo DNS mode isn\'t working, check the following:\n\n1. Confirm you pushed DNS config from the app (Send DNS Config).\n2. Verify you applied the relay IP as Primary DNS on the Switch.\n3. Ensure the relay server selected (EU/US) is online and not overloaded.\n4. Some networks (e.g., captive portals) prevent custom DNS — test on a different network.\n\nIf issues persist, enable Debug Mode and check logs or try the Friends-mode alternative.';

  @override
  String get helpFriendsModeTitle => 'Friends mode does not work';

  @override
  String get helpFriendsModeSubtitle => 'Common friend issues';

  @override
  String get helpFriendsModeBody => 'Friends mode troubleshooting tips:\n\n1. Make sure the relay friend account is added/accepted on the console (if required).\n2. Try restarting the game and refreshing the Friends/LAN tab after enabling Friends mode.\n\nIf the server still doesn\'t appear to friends, enable Debug Mode and check logs to identify errors.';

  @override
  String get changeLanguageTitle => 'Change language';

  @override
  String get changeLanguage => 'Language';

  @override
  String get useSystemLanguage => 'Use system language';

  @override
  String get couldNotOpenUrl => 'Could not open URL';
}

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
}

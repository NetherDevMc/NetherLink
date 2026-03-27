// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Console';

  @override
  String get consoleOutput => 'Console Uitvoer';

  @override
  String get noLogsYet => 'Nog geen logs';

  @override
  String get startBroadcastingToSeeOutput => 'Start uitzenden om uitvoer te zien';

  @override
  String get close => 'Sluit';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Sluit je aan';

  @override
  String get website => 'Website';

  @override
  String get howToUseMenu => 'Hoe gebruiken';

  @override
  String get support => 'Ondersteuning';

  @override
  String helpText(Object appCreator) {
    return 'Gemaakt door $appCreator.\n\nHoe te gebruiken:\n1. Voer uw Minecraft server adres en poort in (standaard: 19132)\n   - of selecteer een eerder opgeslagen server uit de dropdown\n2. (Optioneel) Kies een Relay server(EU of US) die het dichtst bij uw locatie is\n3. Klik op \"Start uitzending\"\n4 Om te starten ga op je console/apparaat: Minecraft > Play > Vrienden\n5. Je zou een LAN server moeten zien genaamd \"NetherLink\"\n6. Klik op de server om toe te treden tot uw externe server via NetherLink\n\nNintendo Switch (DNS-modus):\n1. Schakel \"Nintendo Switch\" in in het verbindingspaneel\n2. Selecteer een RelayServer (EU of US)\n3. Klik op \"Stuur DNS Config\" - dit stuurt uw configuratie naar het relais\n   (het zend NIET een LAN server)\n4. Op uw Switch, Pas uw NetherLink DNS setup toe en neem deel aan\n   met behulp van de server die u gebruikt voor NetherLink\n\nNotities:\n- voor LAN uitzendingen, Netherlink en console moeten op hetzelfde lokale netwerk zitten.\n- Tip: Kies de dichtstbijzijnde server voor de beste prestaties.';
  }

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Schakel debug aan/uit';

  @override
  String get copyLogs => 'Logs kopiëren';

  @override
  String get clear => 'Wis';

  @override
  String get cancel => 'Annuleren';

  @override
  String get deleteServer => 'Server Verwijderen';

  @override
  String get delete => 'Verwijderen';

  @override
  String get myServers => 'Mijn Servers';

  @override
  String get quickAccessServers => 'Snelle toegang tot servers';

  @override
  String get addServer => 'Server toevoegen';

  @override
  String get addServersHint => 'Servers toevoegen om later snel te verbinden';

  @override
  String get serverNameLabel => 'Server Naam *';

  @override
  String get addressLabel => 'Adres *';

  @override
  String get portLabel => 'Poort *';

  @override
  String get descriptionLabel => 'Beschrijving (optioneel)';

  @override
  String get save => 'Opslaan';

  @override
  String get initializing => 'Initialiseren...';

  @override
  String get createdBy => 'Gemaakt door NetherDev';

  @override
  String get bedrockBridge => 'Bedrock Brug';

  @override
  String get clientDisconnected => 'Client verbroken - Uitzending gestopt';

  @override
  String get pleaseEnterServer => '⚠️ Voer een serveradres in';

  @override
  String get invalidPort => '⚠️ Ongeldig poortnummer (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS configuratie verzonden naar relay';

  @override
  String get broadcastingStarted => 'Uitzending gestart';

  @override
  String get broadcastStopped => 'Uitzending gestopt';

  @override
  String selectedServer(Object name) {
    return '📋 Geselecteerd: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Geselecteerd: $name';
  }

  @override
  String get noLogsToCopy => 'Geen logs om te kopiëren';

  @override
  String copiedLogs(Object count) {
    return 'Gekopieerd $count logs naar het klembord';
  }

  @override
  String get debugEnabled => 'Debug logs ingeschakeld';

  @override
  String get debugDisabled => 'Debug logs uitgeschakeld';

  @override
  String get howToUseTitle => 'Hoe gebruik je NetherLink';

  @override
  String get iUnderstand => 'Ik begrijp het';

  @override
  String get playOnSwitchTitle => 'Speel op Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Spelen via vrienden';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Geselecteerd: $relayName\n\nHoe te verbinden:\n1. Ga naar uw Switch Instellingen en wijzig de DNS naar: $relayIp\n2. Open Minecraft en selecteer een server uit de lijst (zoals Cubecraft of Hive).\n3. Je wordt nu automatisch naar je eigen server verzonden.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Hoe te verbinden:\n1. Voeg $friend toe als vriend op je console.\n2. Open Minecraft en ga naar het tabblad Vrienden.\n3. Zoek naar je server onder LAN werelden en selecteer om mee te doen.';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'Geselecteerd: $name';
  }

  @override
  String get noSavedServers => 'Geen opgeslagen servers';

  @override
  String get savedServers => 'Opgeslagen servers';

  @override
  String get serverAddressHint => 'Server Address';

  @override
  String get portHint => 'Poort';

  @override
  String get manageServers => 'Beheer servers';

  @override
  String get manageServersTooltip => 'Beheer servers';

  @override
  String get stopBroadcasting => 'Uitzenden stoppen';

  @override
  String get startNintendoMode => 'Nintendo Modus starten';

  @override
  String get startFriendsMode => 'Start vrienden modus';

  @override
  String get startBroadcasting => 'Uitzending starten';

  @override
  String get modeLabel => 'Modus';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Vrienden';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS-modus';

  @override
  String get nintendoInfoText => 'Start in Nintendo modus, stel uw DNS in en word lid van een featured server.';

  @override
  String get friendModeTitle => 'Vriend modus';

  @override
  String get friendModeText => 'Voeg NetherLink\'s vriend bots toe als vriend, Start vriend modus en speel';

  @override
  String get selectedRelayCheck => 'Geselecteerd';

  @override
  String relayFallbackWarning(Object name) {
    return 'Waarschuwing: origineel Relay heeft niet gereageerd. Fallback Relay in gebruik: $name';
  }

  @override
  String get relayUnableConnect => 'Kan geen verbinding maken met geen enkele NetherLink relay server. Probeer het later opnieuw of controleer je internet.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Play via LAN broadcast or proxy';

  @override
  String get howToXboxBody => 'How to connect (Xbox / PS4 / PS5):\n1. Ensure your PC running NetherLink and your console are on the same local network.\n2. In the app, enter your Minecraft server address and port and press \"Start Broadcasting\".\n3. On the console open Minecraft → Play → look for LAN Worlds or the Friends tab and refresh the list.\n4. Select the LAN server named \"NetherLink\" to join.\nNotes:\n- If the server does not appear, confirm both devices are on the same subnet and that the app is still broadcasting.\n- Some console models or routers may block LAN discovery; try toggling the app or router settings if needed.';

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
  String get helpNintendoDnsSubtitle => 'Common DNS / relay issues (placeholder)';

  @override
  String get helpNintendoDnsBody => 'If Nintendo DNS mode isn\'t working, check the following:\n\n1. Confirm you pushed DNS config from the app (Send DNS Config).\n2. Verify you applied the relay IP as Primary DNS on the Switch.\n3. Ensure the relay server selected (EU/US) is online and not overloaded.\n4. Some networks (e.g., captive portals) prevent custom DNS — test on a different network.\n\nIf issues persist, enable Debug Mode and check logs or try the Friends-mode alternative.';

  @override
  String get helpFriendsModeTitle => 'Friends mode does not work';

  @override
  String get helpFriendsModeSubtitle => 'Common friend/finding issues (placeholder)';

  @override
  String get helpFriendsModeBody => 'Friends mode troubleshooting tips:\n\n1. Make sure the relay friend account is added/accepted on the console (if required).\n2. Ensure both you and your friends have visibility / NAT settings that allow presence.\n3. Try restarting the game and refreshing the Friends/LAN tab after enabling Friends mode.\n\nIf the server still doesn\'t appear to friends, enable Debug Mode and check logs to identify errors.';
}

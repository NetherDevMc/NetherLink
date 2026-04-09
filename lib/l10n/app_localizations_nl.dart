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
  String get joinUs => 'Word lid';

  @override
  String get more => 'Meer';

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
  String get serverDetailsLabel => 'Serverdetails';

  @override
  String get start => 'Starten';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Java-modus starten';

  @override
  String get javaInfoTitle => 'Java-modus';

  @override
  String get javaInfoText => 'Verbinden met Java Edition-servers';

  @override
  String get howToJavaTitle => 'Java-modus';

  @override
  String get howToJavaSubtitle => 'Verbinden met Java Edition-servers via NetherLink';

  @override
  String get howToJavaBody => 'Java-modus — snelle stappen:\n1. Selecteer in de app de Java-modus.\n2. Voer het adres en de poort van je Java Edition-server in (standaard: 25565).\n3. Druk op \"Java-modus starten\" — NetherLink overbrugt de verbinding.\n4. Open Minecraft Bedrock en ga naar het tabblad Vrienden.\n5. Selecteer de LAN-server met de naam \"NetherLink\" om deel te nemen aan de Java-server.\n\n⚠️ Belangrijke waarschuwingen:\n- Een geldig Java Edition-account (Microsoft) is vereist.\n- Sommige servers gebruiken anti-cheat-systemen die je account kunnen detecteren en verbannen.\n- Sommige servers verbieden Bedrock-clients expliciet — controleer altijd de serverregels.\n- NetherLink is niet verantwoordelijk voor accountverboden, schorsingen of andere accountgerelateerde problemen die uit het gebruik van deze functie kunnen voortkomen.\n- Gebruik op eigen risico.';

  @override
  String get language => 'Nederlands';

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
  String get nldServerLabel => 'NETHERLINK-SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'Geselecteerd: $name';
  }

  @override
  String get noSavedServers => 'Geen opgeslagen servers';

  @override
  String get savedServers => 'Opgeslagen servers';

  @override
  String get serverAddressHint => 'Serveradres';

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
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / proxyverbinding)';

  @override
  String get howToXboxSubtitle => 'Spelen via LAN of proxy';

  @override
  String get howToXboxBody => 'Hoe verbinding te maken (Xbox / PS4 / PS5):\n1. Zorg ervoor dat NetherLink en jouw console op hetzelfde lokale netwerk zitten.\n2. Voer in de app uw Minecraft serveradres en poort in en druk op \"Uitzending Starten\".\n3. In de console open Minecraft → Play → zoek naar LAN werelden of het tabblad Vrienden en ververs de lijst.\n4. Selecteer de LAN-server genaamd \"NetherLink\" om toe te treden.\nnotities:\n- Als de server niet verschijnt, bevestig dan dat beide apparaten op hetzelfde subnet staan en dat de app nog steeds wordt uitgezonden.\n- Sommige console modellen of routers kunnen LAN ontdekking blokkeren; probeer indien nodig de app of router aan te zetten.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS-modus)';

  @override
  String get howToNintendoSubtitle => 'Instructies voor DNS-relay voor Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch - DNS modus (stap voor stap):\n1. In de app \"Nintendo\" modus inschakelen en selecteer een Relay Server (EU of US).\n2. Tik op \"Stuur DNS Config\" om de gegevens naar het relay te sturen.\n3. Op uw Nintendo Switch ga naar Systeeminstellingen → Internet → internetinstellingen → (uw netwerk) → Instellingen wijzigen → DNS en stel de primaire DNS in op het relais-IP.\n4. Open Minecraft en word lid van een openbare server; je wordt omgeleid naar je server met behulp van de relay DNS.\nOpmerkingen:\n- DNS-modus zend geen LAN-server uit; het stuurt spelverkeer door de relais.\n- Zet je DNS terug nadat je klaar bent als je een normaal netwerkgedrag nodig hebt.';

  @override
  String get howToFriendsTitle => 'Vrienden modus';

  @override
  String get howToFriendsSubtitle => 'Nodig vrienden uit en doe mee via LAN';

  @override
  String get howToFriendsBody => 'Vrienden-modus - snelle stappen:\n1. Voeg het NetherLinkvriend-account (relay vriend) toe op uw console of platform indien nodig.\n2. Schakel in de app Vrienden modus in en stuur de relay configuratie.\n3. Open op je console Minecraft → Vrienden en zoek naar LAN Worlds - jouw server zou daar als een LAN-wereld moeten verschijnen.\n4. Selecteer het om je server te betreden.\nOpmerkingen:\n- Vriendschapsmodus is afhankelijk van de functies van het platform vriend en kan het vereisen dat je vriendschapsverzoeken accepteert.';

  @override
  String get helpNetherlinkTitle => 'Netherlink verschijnt niet';

  @override
  String get helpNetherlinkSubtitle => 'Problemen met het oplossen van LAN ontdekking';

  @override
  String get helpNetherlinkBody => 'Als de server niet verschijnt op je console, probeer dan deze stappen:\n\n✅ Basiscontroles:\n\n1. Zelfde wifi-netwerk – Je telefoon/tablet en console MOETEN op dezelfde wifi zitten\n2. Correct serveradres – Controleer het IP-adres en de poort (standaard: 19132)\n3. Broadcasting actief – Controleer of NetherLink de status \"Broadcasting\" toont\n\n🔄 Snelle oplossingen:\n• Herstart de app: Stop het uitzenden, sluit NetherLink volledig af, open het opnieuw en probeer het opnieuw\n• Herstart je console: Soms heeft de console een refresh nodig om LAN-games te detecteren\n• Controleer het tabblad Vrienden/LAN: De server verschijnt onder \"Vrienden\" of \"LAN-games\", NIET in de serverlijst\n• Wacht 10–15 seconden na het starten van het uitzenden\n• Schakel VPN’s uit: VPN’s kunnen lokale broadcasts blokkeren\n\n⚠️ Veelvoorkomende problemen:\n\"Geen route gevonden voor gebruiker\" → Zorg ervoor dat beide apparaten op dezelfde wifi zitten (vermijd gastnetwerken)\n\"Kan geen verbinding maken met de NetherLink relay-server\" → Controleer je internet / relay-status\n\n📱 Nog steeds problemen? Schakel de debugmodus in NetherLink in en bekijk de logs, of probeer een andere server.';

  @override
  String get helpMultiplayerFailedTitle => 'Multiplayer verbinding mislukt';

  @override
  String get helpMultiplayerFailedSubtitle => 'Uitleg waarom dit geen NetherLink fout is';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Dit is geen probleem met NetherLink!\n\nNetherLink heeft je met succes doorgestuurd naar de server. Het bericht \"Multiplayer Verbinding Mislukt\" geeft aan dat de doelserver op dit moment niet bereikbaar is. Mogelijke redenen:\n\n• De doel Minecraft-server is offline of overgeladen\n• De server vereist een bijgewerkte clientversie of specifieke editie\n• Netwerkproblemen tussen het relais en de doelserver\n\nProbeer verbinding te maken met een andere server of neem contact op met de ondersteuning van de server. Als het probleem aanhoudt voor meerdere servers, schakel dan Debug Mode in NetherLink in en controleer de logs.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS werkt niet';

  @override
  String get helpNintendoDnsSubtitle => 'Voorkomende problemen met DNS / Relay (placeholder)';

  @override
  String get helpNintendoDnsBody => 'Als Nintendo DNS modus niet werkt, controleer dan het volgende:\n\n1. Bevestig dat je DNS-configuratie hebt gestuurd (Send DNS Config).\n2. Controleer of u het relais-IP als primaire DNS heeft toegepast op de Switch.\n3. Zorg ervoor dat de relaisserver (EU/US) online is en niet overbelast.\n4. Sommige netwerken (bijv. captive portals) voorkomen aangepaste DNS — test op een ander netwerk.\n\nAls problemen aanhouden, schakel dan Debug Mode in en bekijk de logs of probeer het alternatief Vriends-modus.';

  @override
  String get helpFriendsModeTitle => 'Vrienden modus werkt niet';

  @override
  String get helpFriendsModeSubtitle => 'Veelvoorkomende vriend/vinden problemen (placeholder)';

  @override
  String get helpFriendsModeBody => 'Vrienden-modus probleemoplossingstips:\n\n1. Zorg ervoor dat de relay account is toegevoegd/geaccepteerd in de console (indien nodig).\n2. Zorg ervoor dat zowel jij als je vrienden zichtbaarheid / NAT instellingen hebben die aanwezigheid toestaan.\n3. Probeer het spel opnieuw te starten en het tabblad Vrienden/LAN te verversen na het inschakelen van Vrienden-modus.\n\nAls de server nog steeds niet bij vrienden verschijnt, schakel dan Debugmodus in en controleer de logs om fouten te identificeren.';

  @override
  String get changeLanguageTitle => 'Taal wijzigen';

  @override
  String get changeLanguage => 'Taal';

  @override
  String get useSystemLanguage => 'Systeemtaal gebruiken';

  @override
  String get couldNotOpenUrl => 'Kon URL niet openen';
}

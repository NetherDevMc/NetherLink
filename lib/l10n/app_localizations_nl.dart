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
  String get more => 'More';

  @override
  String get website => 'Website';

  @override
  String get howToUseMenu => 'Hoe gebruiken';

  @override
  String get support => 'Ondersteuning';

  @override
  String helpText(Object appCreator) {
    return 'Gemaakt door $appCreator.\n\nZo gebruik je het:\n1. Voer het adres en de poort van je Minecraft-server in (standaard: 19132)\n   - of selecteer een eerder opgeslagen server uit de keuzelijst\n2. (Optioneel) Kies de relayserver (EU of US) die het dichtst bij je locatie is\n3. Klik op \"Uitzending starten\" om te beginnen\n4. Ga op je console/apparaat naar: Minecraft > Spelen > Vrienden\n5. Je zou een LAN-server met de naam \"NetherLink\" moeten zien\n6. Klik erop om via NetherLink verbinding te maken met je externe server\n\nNintendo Switch (DNS-modus):\n1. Schakel \"Nintendo Switch\" in het verbindingspaneel in\n2. Selecteer een relayserver (EU of US)\n3. Klik op \"DNS-configuratie verzenden\" - dit stuurt je configuratie naar de relay\n   (hiermee wordt GEEN LAN-server uitgezonden)\n4. Pas op je Switch de NetherLink-DNS-instellingen toe en maak verbinding\n   met de serververmelding die je voor NetherLink gebruikt\n\nOpmerkingen:\n- Voor LAN-uitzendingen moeten NetherLink en je console zich op hetzelfde lokale netwerk bevinden.\n- Tip: Kies de dichtstbijzijnde relayserver voor de beste prestaties.';
  }

  @override
  String get serverDetailsLabel => 'Servergegevens';

  @override
  String get start => 'Start';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Start Java-modus';

  @override
  String get javaInfoTitle => 'Java-modus';

  @override
  String get javaInfoText => 'Verbind met Java Edition-servers';

  @override
  String get howToJavaTitle => 'Java-modus';

  @override
  String get howToJavaSubtitle => 'Verbind via NetherLink met Java Edition-servers';

  @override
  String get howToJavaBody => 'Java-modus — snelle stappen:\n1. Selecteer in de app de Java-modus.\n2. Voer het adres en de poort van je Java Edition-server in (standaard: 25565).\n3. Druk op \"Start Java-modus\" — NetherLink overbrugt de verbinding.\n4. Open Minecraft Bedrock en ga naar het tabblad Vrienden.\n5. Selecteer de LAN-server met de naam \"NetherLink\" om lid te worden van de Java-server.\n\n⚠️ Belangrijke waarschuwingen:\n- Een geldig Java Edition-account (Microsoft) is vereist.\n- Sommige servers gebruiken anticheatsystemen die je account kunnen detecteren en verbannen.\n- Sommige servers verbieden Bedrock-clients uitdrukkelijk — controleer altijd de serverregels.\n- NetherLink is niet verantwoordelijk voor accountbans, schorsingen of andere accountgerelateerde problemen die kunnen ontstaan door het gebruik van deze functie.\n- Gebruik op eigen risico.';

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
    return 'Zo maak je verbinding:\n1. Voeg $friend toe als vriend op je console.\n2. Open Minecraft en ga naar het tabblad Vrienden.\n3. Zoek je server onder LAN-werelden en selecteer deze om deel te nemen.';
  }

  @override
  String get nldServerLabel => 'NETHERLINK-server';

  @override
  String selectRelayLabel(Object name) {
    return 'Selecteer relay $name';
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
  String get startFriendsMode => 'Vriendenmodus starten';

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
    return 'Waarschuwing: de oorspronkelijke relay reageerde niet. Vervangende relay in gebruik: $name';
  }

  @override
  String get relayUnableConnect => 'Kan geen verbinding maken met een NetherLink-relayserver. Probeer het later opnieuw of controleer je internetverbinding.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / proxy)';

  @override
  String get howToXboxSubtitle => 'Spelen via LAN of proxy';

  @override
  String get howToXboxBody => 'Zo maak je verbinding (Xbox / PS4 / PS5):\n1. Zorg ervoor dat het apparaat waarop NetherLink draait en je console zich op hetzelfde lokale netwerk bevinden.\n2. Voer in de app het adres en de poort van je Minecraft-server in en druk op \"Uitzending starten\".\n3. Open op de console Minecraft → Spelen → zoek naar LAN-werelden of het tabblad Vrienden en vernieuw de lijst.\n4. Selecteer de LAN-server met de naam \"NetherLink\" om deel te nemen.\nOpmerkingen:\n- Als de server niet verschijnt, controleer dan of beide apparaten zich op hetzelfde subnet bevinden en of de app nog steeds uitzendt.\n- Sommige consolemodellen of routers kunnen LAN-detectie blokkeren; probeer indien nodig de instellingen van de app of router aan te passen.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS-modus)';

  @override
  String get howToNintendoSubtitle => 'Instructies voor DNS-relay voor Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch - DNS-modus (stap voor stap):\n1. Schakel in de app de modus \"Nintendo\" in en selecteer een relayserver (EU of US).\n2. Tik op \"DNS-configuratie verzenden\" om het DNS-IP naar de relay te sturen.\n3. Ga op je Nintendo Switch naar Systeeminstellingen → Internet → Internetinstellingen → (je netwerk) → Instellingen wijzigen → DNS en stel de primaire DNS in op het relay-IP.\n4. Open Minecraft en maak verbinding met een openbare server; je wordt via de relay-DNS naar je eigen server doorgestuurd.\nOpmerkingen:\n- De DNS-modus zendt geen LAN-server uit; het spelverkeer wordt via de relay geleid.\n- Zet je DNS-instelling na afloop terug als je weer normaal netwerkgedrag wilt.';

  @override
  String get howToFriendsTitle => 'Vrienden modus';

  @override
  String get howToFriendsSubtitle => 'Nodig vrienden uit en doe mee via LAN';

  @override
  String get howToFriendsBody => 'Vriendenmodus - snelle stappen:\n1. Voeg indien nodig het NetherLink-vriendaccount (relay-vriend) toe op je console of platform.\n2. Schakel in de app de vriendenmodus in en verstuur de relayconfiguratie.\n3. Open op je console Minecraft → Vrienden en zoek naar LAN-werelden - je server zou daar als LAN-wereld moeten verschijnen.\n4. Selecteer deze om verbinding te maken met je server.\nOpmerkingen:\n- De vriendenmodus is afhankelijk van de vriendenfuncties van het platform en kan vereisen dat je vriendschapsverzoeken accepteert.';

  @override
  String get helpNetherlinkTitle => 'Netherlink verschijnt niet';

  @override
  String get helpNetherlinkSubtitle => 'Problemen met het oplossen van LAN ontdekking';

  @override
  String get helpNetherlinkBody => 'Als de server niet op je console verschijnt, probeer dan deze stappen:\n\n✅ Basiscontroles:\n\n1. Zelfde wifi-netwerk – Je telefoon/tablet en console MOETEN op dezelfde wifi zitten\n2. Correct serveradres – Controleer het IP-adres en de poort (standaard: 19132)\n3. Uitzending actief – Controleer of NetherLink de status \"Uitzenden\" toont\n\n🔄 Snelle oplossingen:\n• Herstart de app: Stop het uitzenden, sluit NetherLink volledig af, open het opnieuw en probeer het opnieuw\n• Herstart je console: Soms heeft de console een vernieuwing nodig om LAN-games te detecteren\n• Controleer het tabblad Vrienden/LAN: De server verschijnt onder \"Vrienden\" of \"LAN-games\", NIET in de serverlijst\n• Wacht 10–15 seconden na het starten van het uitzenden\n• Schakel VPN’s uit: VPN’s kunnen lokale uitzendingen blokkeren\n\n⚠️ Veelvoorkomende problemen:\n\"Geen route gevonden voor gebruiker\" → Zorg ervoor dat beide apparaten op dezelfde wifi zitten (vermijd gastnetwerken)\n\"Kan geen verbinding maken met de NetherLink-relayserver\" → Controleer je internet / relaystatus\n\n📱 Nog steeds problemen? Schakel de debugmodus in NetherLink in en bekijk de logs, of probeer een andere server.';

  @override
  String get helpMultiplayerFailedTitle => 'Multiplayer verbinding mislukt';

  @override
  String get helpMultiplayerFailedSubtitle => 'Uitleg waarom dit geen NetherLink fout is';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Dit is geen probleem met NetherLink!\n\nNetherLink heeft je met succes doorgestuurd naar de gevraagde server. Het bericht \"Multiplayer Verbinding Mislukt\" geeft aan dat de doelserver momenteel niet bereikbaar is. Mogelijke redenen:\n\n• De doel-Minecraft-server is offline of overbelast\n• De server vereist een bijgewerkte clientversie of een specifieke editie\n• Netwerkproblemen tussen de relay en de doelserver\n\nProbeer verbinding te maken met een andere server of neem contact op met de ondersteuning van die server. Als het probleem bij meerdere servers blijft optreden, schakel dan de debugmodus in NetherLink in en controleer de logs.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS werkt niet';

  @override
  String get helpNintendoDnsSubtitle => 'Veelvoorkomende DNS-/relayproblemen';

  @override
  String get helpNintendoDnsBody => 'Als de Nintendo-DNS-modus niet werkt, controleer dan het volgende:\n\n1. Controleer of je de DNS-configuratie vanuit de app hebt verzonden (DNS-configuratie verzenden).\n2. Controleer of je het relay-IP als primaire DNS op de Switch hebt ingesteld.\n3. Zorg ervoor dat de geselecteerde relayserver (EU/US) online is en niet overbelast.\n4. Sommige netwerken (zoals captive portals) blokkeren aangepaste DNS — test op een ander netwerk.\n\nAls de problemen aanhouden, schakel dan de debugmodus in en controleer de logs of probeer als alternatief de vriendenmodus.';

  @override
  String get helpFriendsModeTitle => 'Vrienden modus werkt niet';

  @override
  String get helpFriendsModeSubtitle => 'Veelvoorkomende problemen met vrienden';

  @override
  String get helpFriendsModeBody => 'Tips voor het oplossen van problemen met de vriendenmodus:\n\n1. Zorg ervoor dat het relay-vriendaccount is toegevoegd/geaccepteerd op de console (indien nodig).\n2. Zorg ervoor dat zowel jij als je vrienden zichtbaarheids-/NAT-instellingen hebben die aanwezigheid toestaan.\n3. Probeer het spel opnieuw te starten en het tabblad Vrienden/LAN te vernieuwen nadat je de vriendenmodus hebt ingeschakeld.\n\nAls de server nog steeds niet voor vrienden verschijnt, schakel dan de debugmodus in en controleer de logs om fouten te achterhalen.';

  @override
  String get changeLanguageTitle => 'Taal wijzigen';

  @override
  String get changeLanguage => 'Taal';

  @override
  String get useSystemLanguage => 'Systeemtaal gebruiken';

  @override
  String get couldNotOpenUrl => 'Kon URL niet openen';
}

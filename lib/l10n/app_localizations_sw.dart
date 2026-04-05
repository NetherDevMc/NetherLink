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
  String get console => 'Konsoli';

  @override
  String get consoleOutput => 'Matokeo ya Konsoli';

  @override
  String get noLogsYet => 'Bado hakuna kumbukumbu';

  @override
  String get startBroadcastingToSeeOutput => 'Anza kutangaza ili kuona matokeo';

  @override
  String get close => 'Funga';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Jiunge Nasi';

  @override
  String get website => 'Tovuti';

  @override
  String get howToUseMenu => 'Jinsi ya kutumia';

  @override
  String get support => 'Msaada';

  @override
  String helpText(Object appCreator) {
    return 'Imetengenezwa na $appCreator.\n\nJinsi ya kutumia:\n1. Weka anwani na port ya seva yako ya Minecraft (chaguo-msingi: 19132)\n   — au chagua seva iliyohifadhiwa awali kutoka kwenye menyu ya kushuka\n2. (Hiari) Chagua Relay Server (EU au US) iliyo karibu zaidi na eneo lako\n3. Bofya "Anza Kutangaza" ili kuanza\n4. Kwenye konsoli/kifaa chako: Minecraft > Play > Friends\n5. Unapaswa kuona seva ya LAN inayoitwa "NetherLink"\n6. Bofya ili kujiunga na seva yako ya nje kupitia NetherLink\n\nNintendo Switch (hali ya DNS):\n1. Washa "Nintendo Switch" kwenye paneli ya muunganisho\n2. Chagua Relay Server (EU au US)\n3. Bofya "Send DNS Config" — hii hutuma usanidi wako kwa relay\n   (hii HAITANGAZI seva ya LAN)\n4. Kwenye Switch yako, tumia mipangilio ya DNS ya NetherLink kisha jiunge\n   kwa kutumia ingizo la seva unalotumia kwa NetherLink\n\nVidokezo:\n- Kwa utangazaji wa LAN, NetherLink na konsoli lazima ziwe kwenye mtandao mmoja wa ndani.\n- Dokezo: Chagua seva ya relay iliyo karibu zaidi nawe kwa utendaji bora.';
  }

  @override
  String get language => 'Kiswahili';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Badili hali ya utatuzi';

  @override
  String get copyLogs => 'Nakili kumbukumbu';

  @override
  String get clear => 'Futa';

  @override
  String get cancel => 'Ghairi';

  @override
  String get deleteServer => 'Futa Seva';

  @override
  String get delete => 'Futa';

  @override
  String get myServers => 'Seva Zangu';

  @override
  String get quickAccessServers => 'Seva za ufikiaji wa haraka';

  @override
  String get addServer => 'Ongeza Seva';

  @override
  String get addServersHint => 'Ongeza seva ili kuunganika haraka baadaye';

  @override
  String get serverNameLabel => 'Jina la Seva *';

  @override
  String get addressLabel => 'Anwani *';

  @override
  String get portLabel => 'Port *';

  @override
  String get descriptionLabel => 'Maelezo (Hiari)';

  @override
  String get save => 'Hifadhi';

  @override
  String get initializing => 'Inaandaliwa...';

  @override
  String get createdBy => 'Imetengenezwa na NetherDev';

  @override
  String get bedrockBridge => 'Daraja la Bedrock';

  @override
  String get clientDisconnected => 'Mteja ametenganishwa — Utangazaji umesimama';

  @override
  String get pleaseEnterServer => '⚠️ Tafadhali weka anwani ya seva';

  @override
  String get invalidPort => '⚠️ Nambari ya port si sahihi (1-65535)';

  @override
  String get dnsConfigSent => '✅ Usanidi wa DNS umetumwa kwa relay';

  @override
  String get broadcastingStarted => 'Utangazaji umeanza';

  @override
  String get broadcastStopped => 'Utangazaji umesimama';

  @override
  String selectedServer(Object name) {
    return '📋 Imechaguliwa: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Imechaguliwa: $name';
  }

  @override
  String get noLogsToCopy => 'Hakuna kumbukumbu za kunakili';

  @override
  String copiedLogs(Object count) {
    return 'Ime nakili maingizo $count ya kumbukumbu kwenye clipboard';
  }

  @override
  String get debugEnabled => 'Kumbukumbu za utatuzi zimewashwa';

  @override
  String get debugDisabled => 'Kumbukumbu za utatuzi zimezimwa';

  @override
  String get howToUseTitle => 'Jinsi ya kutumia NetherLink';

  @override
  String get iUnderstand => 'Nimeelewa';

  @override
  String get playOnSwitchTitle => 'Cheza kwenye Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Cheza na Marafiki';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Imechaguliwa: $relayName\n\nJinsi ya kuunganika:\n1. Nenda kwenye Mipangilio ya Switch yako na ubadilishe DNS kuwa: $relayIp\n2. Fungua Minecraft na uchague seva kutoka kwenye orodha (kama Cubecraft au Hive).\n3. Sasa utapelekwa moja kwa moja kwenye seva yako mwenyewe.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Jinsi ya kuunganika:\n1. Kwenye konsoli yako, ongeza $friend kama rafiki.\n2. Fungua Minecraft na uende kwenye kichupo cha Friends.\n3. Tafuta seva yako chini ya LAN Worlds na uchague ili kujiunga.';
  }

  @override
  String get nldServerLabel => 'SEVA YA NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'Chagua relay $name';
  }

  @override
  String get noSavedServers => 'Hakuna seva zilizohifadhiwa';

  @override
  String get savedServers => 'Seva zilizohifadhiwa';

  @override
  String get serverAddressHint => 'Anwani ya Seva';

  @override
  String get portHint => 'Port';

  @override
  String get manageServers => 'Dhibiti seva';

  @override
  String get manageServersTooltip => 'Dhibiti seva';

  @override
  String get stopBroadcasting => 'Simamisha Utangazaji';

  @override
  String get startNintendoMode => 'Anza Hali ya Nintendo';

  @override
  String get startFriendsMode => 'Anza Hali ya Marafiki';

  @override
  String get startBroadcasting => 'Anza Kutangaza';

  @override
  String get modeLabel => 'Hali';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Marafiki';

  @override
  String get nintendoInfoTitle => 'Hali ya DNS ya Nintendo Switch';

  @override
  String get nintendoInfoText => 'Anza kwenye hali ya Nintendo, weka DNS yako na jiunge na seva iliyopendekezwa.';

  @override
  String get friendModeTitle => 'Hali ya Marafiki';

  @override
  String get friendModeText => 'Ongeza roboti za marafiki za NetherLink kama rafiki. Anza hali ya Marafiki na ucheze';

  @override
  String get selectedRelayCheck => 'Imechaguliwa';

  @override
  String relayFallbackWarning(Object name) {
    return 'Onyo: relay ya awali haikujibu. Relay mbadala inatumika: $name';
  }

  @override
  String get relayUnableConnect => 'Imeshindikana kuunganika kwa seva YOYOTE ya relay ya NetherLink. Jaribu tena baadaye au angalia intaneti yako.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Cheza kupitia utangazaji wa LAN au proxy';

  @override
  String get howToXboxBody => 'Jinsi ya kuunganika (Xbox / PS4 / PS5):\n1. Hakikisha kifaa chako kinachoendesha NetherLink na konsoli yako viko kwenye mtandao mmoja wa ndani.\n2. Kwenye programu, weka anwani na port ya seva yako ya Minecraft kisha bonyeza "Anza Kutangaza".\n3. Kwenye konsoli, fungua Minecraft → Play → tafuta LAN Worlds au kichupo cha Friends kisha sasisha orodha.\n4. Chagua seva ya LAN iitwayo "NetherLink" ili kujiunga.\nVidokezo:\n- Ikiwa seva haionekani, hakikisha vifaa vyote viko kwenye subnet moja na programu bado inatangaza.\n- Baadhi ya miundo ya konsoli au router inaweza kuzuia ugunduzi wa LAN; jaribu kubadili mipangilio ya programu au router ikihitajika.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (hali ya DNS)';

  @override
  String get howToNintendoSubtitle => 'Maelekezo ya DNS relay kwa Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — hali ya DNS (hatua kwa hatua):\n1. Kwenye programu, washa hali ya "Nintendo" na uchague Relay Server (EU au US).\n2. Gusa "Send DNS Config" ili kutuma DNS IP kwa relay.\n3. Kwenye Nintendo Switch yako nenda kwenye System Settings → Internet → Internet Settings → (mtandao wako) → Change Settings → DNS na weka Primary DNS kuwa relay IP.\n4. Fungua Minecraft na ujiunge na seva ya umma; utaelekezwa kwenye seva yako kwa kutumia relay DNS.\nVidokezo:\n- Hali ya DNS haitangazi seva ya LAN; inaelekeza trafiki ya mchezo kupitia relay.\n- Rudisha DNS yako baada ya kumaliza ikiwa unahitaji tabia ya kawaida ya mtandao.';

  @override
  String get howToFriendsTitle => 'Hali ya Marafiki';

  @override
  String get howToFriendsSubtitle => 'Alika marafiki na ujiunge kupitia LAN';

  @override
  String get howToFriendsBody => 'Hali ya Marafiki — hatua za haraka:\n1. Ongeza akaunti ya rafiki ya NetherLink kwenye konsoli au jukwaa lako ikiwa inahitajika.\n2. Kwenye programu washa hali ya Marafiki na utume usanidi wa relay (ikiwa unatumika).\n3. Kwenye konsoli yako fungua Minecraft → Friends na utafute LAN Worlds — seva yako inapaswa kuonekana hapo kama ulimwengu wa LAN.\n4. Ichague ili kujiunga na seva yako pamoja na marafiki.\nVidokezo:\n- Hakikisha wewe na marafiki zako mna NAT/mipangilio sawa inayoruhusu uwepo wa marafiki.\n- Hali ya Marafiki hutegemea vipengele vya urafiki vya jukwaa na huenda ikahitaji kukubali maombi ya urafiki.';

  @override
  String get helpNetherlinkTitle => 'NetherLink haionekani';

  @override
  String get helpNetherlinkSubtitle => 'Utatuzi wa matatizo ya ugunduzi wa LAN';

  @override
  String get helpNetherlinkBody => 'Ikiwa seva haionekani kwenye konsoli yako, jaribu hatua hizi:\n\n✅ Ukaguzi wa msingi:\n1. Mtandao ule ule wa WiFi - Simu/tablet yako na konsoli LAZIMA ziwe kwenye WiFi ile ile\n2. Anwani sahihi ya seva - Hakiki tena IP na port (chaguo-msingi: 19132)\n3. Utangazaji uko hai - Hakikisha NetherLink inaonyesha hali ya "Inatangaza"\n\n🔄 Marekebisho ya haraka:\n• Anzisha tena programu: simamisha utangazaji, funga NetherLink kabisa, ifungue tena na ujaribu upya\n• Anzisha tena konsoli yako: wakati mwingine konsoli huhitaji kusasishwa ili kugundua michezo ya LAN\n• Angalia kichupo cha Friends/LAN: seva huonekana chini ya "Friends" au "LAN Games", SI kwenye orodha ya seva\n• Subiri sekunde 10-15 baada ya kuanza kutangaza\n• Zima VPN: VPN zinaweza kuzuia matangazo ya ndani\n\n⚠️ Matatizo ya kawaida:\n"No route found for user" → Hakikisha vifaa vyote viwili viko kwenye Wi‑Fi ile ile (epuka mitandao ya wageni)\n"Unable to connect to NetherLink relay server" → Angalia intaneti yako / hali ya relay\n\n📱 Bado una matatizo? Washa hali ya utatuzi kwenye NetherLink na uangalie kumbukumbu, au jaribu seva tofauti.';

  @override
  String get helpMultiplayerFailedTitle => 'Muunganisho wa Multiplayer Umeshindikana';

  @override
  String get helpMultiplayerFailedSubtitle => 'Maelezo kwa nini hili si kosa la NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Hili si tatizo la NetherLink!\n\nNetherLink ilikuelekeza kwa mafanikio kwenye seva iliyoombwa. Ujumbe wa "Multiplayer Connection Failed" unaonyesha kuwa seva lengwa haipatikani kwa sasa. Sababu zinazowezekana:\n\n• Seva lengwa ya Minecraft iko nje ya mtandao au imeelemewa\n• Seva inahitaji toleo la mteja lililosasishwa au toleo maalum\n• Matatizo ya mtandao kati ya relay na seva lengwa\n\nJaribu kuunganika kwenye seva tofauti au wasiliana na msaada wa seva husika. Tatizo likiendelea kwenye seva nyingi, washa hali ya utatuzi kwenye NetherLink na uangalie kumbukumbu.';

  @override
  String get helpNintendoDnsTitle => 'DNS ya Nintendo haifanyi kazi';

  @override
  String get helpNintendoDnsSubtitle => 'Matatizo ya kawaida ya DNS / relay';

  @override
  String get helpNintendoDnsBody => 'Ikiwa hali ya DNS ya Nintendo haifanyi kazi, angalia yafuatayo:\n\n1. Thibitisha kuwa umetuma usanidi wa DNS kutoka kwenye programu (Send DNS Config).\n2. Thibitisha kuwa umetumia relay IP kama DNS Kuu kwenye Switch.\n3. Hakikisha seva ya relay iliyochaguliwa (EU/US) iko mtandaoni na haijaelemewa.\n4. Baadhi ya mitandao (kwa mfano captive portals) huzuia DNS maalum — jaribu kwenye mtandao tofauti.\n\nTatizo likiendelea, washa hali ya utatuzi na uangalie kumbukumbu au ujaribu mbadala wa hali ya Marafiki.';

  @override
  String get helpFriendsModeTitle => 'Hali ya Marafiki haifanyi kazi';

  @override
  String get helpFriendsModeSubtitle => 'Matatizo ya kawaida ya marafiki';

  @override
  String get helpFriendsModeBody => 'Vidokezo vya utatuzi wa hali ya Marafiki:\n\n1. Hakikisha akaunti ya rafiki ya relay imeongezwa/imekubaliwa kwenye konsoli (ikiwa inahitajika).\n2. Jaribu kuanzisha tena mchezo na kusasisha kichupo cha Friends/LAN baada ya kuwasha hali ya Marafiki.\n\nIkiwa seva bado haionekani kwa marafiki, washa hali ya utatuzi na uangalie kumbukumbu ili kutambua makosa.';

  @override
  String get changeLanguageTitle => 'Badilisha lugha';

  @override
  String get changeLanguage => 'Lugha';

  @override
  String get useSystemLanguage => 'Tumia lugha ya mfumo';

  @override
  String get couldNotOpenUrl => 'Haikuweza kufungua URL';
}
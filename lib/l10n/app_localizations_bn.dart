// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'কনসোল';

  @override
  String get consoleOutput => 'কনসোল আউটপুট';

  @override
  String get noLogsYet => 'এখনও কোনো লগ নেই';

  @override
  String get startBroadcastingToSeeOutput => 'আউটপুট দেখতে সম্প্রচার শুরু করুন';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'আমাদের সঙ্গে যোগ দিন';

  @override
  String get website => 'ওয়েবসাইট';

  @override
  String get howToUseMenu => 'ব্যবহারের নিয়ম';

  @override
  String get support => 'সহায়তা';

  @override
  String helpText(Object appCreator) {
    return '$appCreator দ্বারা তৈরি।\n\nব্যবহারের নিয়ম:\n1. আপনার Minecraft সার্ভারের ঠিকানা এবং পোর্ট লিখুন (ডিফল্ট: 19132)\n   — অথবা ড্রপডাউন থেকে আগে সংরক্ষিত কোনো সার্ভার বেছে নিন\n2. (ঐচ্ছিক) আপনার অবস্থানের নিকটতম Relay Server (EU বা US) বেছে নিন\n3. শুরু করতে \"সম্প্রচার শুরু করুন\" এ ক্লিক করুন\n4. আপনার কনসোল/ডিভাইসে: Minecraft > Play > Friends\n5. আপনি \"NetherLink\" নামের একটি LAN সার্ভার দেখতে পাবেন\n6. NetherLink এর মাধ্যমে আপনার বাহ্যিক সার্ভারে যোগ দিতে সেটিতে ক্লিক করুন\n\nNintendo Switch (DNS মোড):\n1. সংযোগ প্যানেলে \"Nintendo Switch\" সক্রিয় করুন\n2. একটি Relay Server (EU বা US) নির্বাচন করুন\n3. \"DNS কনফিগ পাঠান\" এ ক্লিক করুন — এটি আপনার কনফিগ relay-এ পাঠাবে\n   (এটি কোনো LAN সার্ভার সম্প্রচার করে না)\n4. আপনার Switch-এ NetherLink DNS সেটআপ প্রয়োগ করুন এবং যোগ দিন\n   NetherLink এর জন্য যে server entry ব্যবহার করেন তা ব্যবহার করে\n\nনোট:\n- LAN সম্প্রচারের জন্য NetherLink এবং কনসোলকে একই লোকাল নেটওয়ার্কে থাকতে হবে।\n- পরামর্শ: সর্বোত্তম পারফরম্যান্সের জন্য আপনার নিকটতম relay server বেছে নিন।';
  }

  @override
  String get language => 'বাংলা';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'ডিবাগ চালু/বন্ধ করুন';

  @override
  String get copyLogs => 'লগ কপি করুন';

  @override
  String get clear => 'মুছুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get deleteServer => 'সার্ভার মুছুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get myServers => 'আমার সার্ভারসমূহ';

  @override
  String get quickAccessServers => 'দ্রুত প্রবেশের সার্ভার';

  @override
  String get addServer => 'সার্ভার যোগ করুন';

  @override
  String get addServersHint => 'পরে দ্রুত সংযোগের জন্য সার্ভার যোগ করুন';

  @override
  String get serverNameLabel => 'সার্ভারের নাম *';

  @override
  String get addressLabel => 'ঠিকানা *';

  @override
  String get portLabel => 'পোর্ট *';

  @override
  String get descriptionLabel => 'বিবরণ (ঐচ্ছিক)';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get initializing => 'শুরু করা হচ্ছে...';

  @override
  String get createdBy => 'NetherDev দ্বারা তৈরি';

  @override
  String get bedrockBridge => 'বেডরক ব্রিজ';

  @override
  String get clientDisconnected => 'ক্লায়েন্ট সংযোগ বিচ্ছিন্ন হয়েছে — সম্প্রচার বন্ধ হয়েছে';

  @override
  String get pleaseEnterServer => '⚠️ অনুগ্রহ করে একটি সার্ভার ঠিকানা লিখুন';

  @override
  String get invalidPort => '⚠️ অবৈধ পোর্ট নম্বর (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS কনফিগ relay-এ পাঠানো হয়েছে';

  @override
  String get broadcastingStarted => 'সম্প্রচার শুরু হয়েছে';

  @override
  String get broadcastStopped => 'সম্প্রচার বন্ধ হয়েছে';

  @override
  String selectedServer(Object name) {
    return '📋 নির্বাচিত: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'নির্বাচিত: $name';
  }

  @override
  String get noLogsToCopy => 'কপি করার মতো কোনো লগ নেই';

  @override
  String copiedLogs(Object count) {
    return '$countটি লগ এন্ট্রি ক্লিপবোর্ডে কপি করা হয়েছে';
  }

  @override
  String get debugEnabled => 'ডিবাগ লগ চালু হয়েছে';

  @override
  String get debugDisabled => 'ডিবাগ লগ বন্ধ হয়েছে';

  @override
  String get howToUseTitle => 'NetherLink কীভাবে ব্যবহার করবেন';

  @override
  String get iUnderstand => 'আমি বুঝেছি';

  @override
  String get playOnSwitchTitle => 'Nintendo Switch-এ খেলুন';

  @override
  String get playWithFriendsTitle => 'বন্ধুদের সঙ্গে খেলুন';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'নির্বাচিত: $relayName\n\nকীভাবে সংযোগ করবেন:\n1. আপনার Switch Settings-এ যান এবং DNS পরিবর্তন করে এটি দিন: $relayIp\n2. Minecraft খুলুন এবং তালিকা থেকে একটি সার্ভার নির্বাচন করুন (যেমন Cubecraft বা Hive)।\n3. এখন আপনাকে স্বয়ংক্রিয়ভাবে আপনার নিজের সার্ভারে পাঠানো হবে।';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'কীভাবে সংযোগ করবেন:\n1. আপনার কনসোলে $friend-কে বন্ধু হিসেবে যোগ করুন।\n2. Minecraft খুলে Friends ট্যাবে যান।\n3. LAN Worlds-এর নিচে আপনার সার্ভার খুঁজে সেটি নির্বাচন করে যোগ দিন।';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'রিলে নির্বাচন করুন $name';
  }

  @override
  String get noSavedServers => 'কোনো সংরক্ষিত সার্ভার নেই';

  @override
  String get savedServers => 'সংরক্ষিত সার্ভার';

  @override
  String get serverAddressHint => 'সার্ভার ঠিকানা';

  @override
  String get portHint => 'পোর্ট';

  @override
  String get manageServers => 'সার্ভার পরিচালনা করুন';

  @override
  String get manageServersTooltip => 'সার্ভার পরিচালনা করুন';

  @override
  String get stopBroadcasting => 'সম্প্রচার বন্ধ করুন';

  @override
  String get startNintendoMode => 'Nintendo মোড শুরু করুন';

  @override
  String get startFriendsMode => 'বন্ধু মোড শুরু করুন';

  @override
  String get startBroadcasting => 'সম্প্রচার শুরু করুন';

  @override
  String get modeLabel => 'মোড';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'বন্ধুরা';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS মোড';

  @override
  String get nintendoInfoText => 'Nintendo মোডে শুরু করুন, আপনার DNS সেট করুন এবং একটি নির্বাচিত সার্ভারে যোগ দিন।';

  @override
  String get friendModeTitle => 'বন্ধু মোড';

  @override
  String get friendModeText => 'NetherLink-এর friend bot-গুলোকে বন্ধু হিসেবে যোগ করুন। বন্ধু মোড শুরু করুন এবং খেলুন';

  @override
  String get selectedRelayCheck => 'নির্বাচিত';

  @override
  String relayFallbackWarning(Object name) {
    return 'সতর্কতা: মূল relay সাড়া দেয়নি। বিকল্প relay ব্যবহৃত হচ্ছে: $name';
  }

  @override
  String get relayUnableConnect => 'কোনো NetherLink relay server-এ সংযোগ করা যায়নি। পরে আবার চেষ্টা করুন অথবা আপনার ইন্টারনেট পরীক্ষা করুন।';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'LAN সম্প্রচার বা প্রক্সির মাধ্যমে খেলুন';

  @override
  String get howToXboxBody => 'কীভাবে সংযোগ করবেন (Xbox / PS4 / PS5):\n1. নিশ্চিত করুন যে NetherLink চালানো আপনার ডিভাইস এবং আপনার কনসোল একই লোকাল নেটওয়ার্কে আছে।\n2. অ্যাপে আপনার Minecraft server address এবং port লিখে \"সম্প্রচার শুরু করুন\" চাপুন।\n3. কনসোলে Minecraft → Play খুলুন → LAN Worlds অথবা Friends ট্যাব খুঁজুন এবং তালিকাটি রিফ্রেশ করুন।\n4. যোগ দিতে \"NetherLink\" নামের LAN server নির্বাচন করুন।\nনোট:\n- সার্ভার না দেখালে নিশ্চিত করুন যে দুই ডিভাইস একই subnet-এ আছে এবং অ্যাপ এখনও সম্প্রচার করছে।\n- কিছু কনসোল মডেল বা রাউটার LAN discovery ব্লক করতে পারে; প্রয়োজন হলে অ্যাপ বা রাউটারের সেটিংস পরিবর্তন করে দেখুন।';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS মোড)';

  @override
  String get howToNintendoSubtitle => 'Switch-এর জন্য DNS রিলে নির্দেশনা';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS মোড (ধাপে ধাপে):\n1. অ্যাপে \"Nintendo\" মোড চালু করুন এবং একটি রিলে সার্ভার (EU বা US) নির্বাচন করুন।\n2. DNS IP রিলেতে পাঠাতে \"DNS কনফিগ পাঠান\" এ ট্যাপ করুন।\n3. আপনার Nintendo Switch-এ System Settings → Internet → Internet Settings → (your network) → Change Settings → DNS এ যান এবং Primary DNS হিসেবে রিলে IP সেট করুন।\n4. Minecraft খুলে একটি public server-এ যোগ দিন; রিলে DNS ব্যবহার করে আপনাকে আপনার সার্ভারে পুনর্নির্দেশ করা হবে।\nনোট:\n- DNS মোড কোনো LAN server সম্প্রচার করে না; এটি রিলের মাধ্যমে game traffic রাউট করে।\n- স্বাভাবিক নেটওয়ার্ক আচরণ দরকার হলে কাজ শেষে DNS আগের অবস্থায় ফিরিয়ে দিন।';

  @override
  String get howToFriendsTitle => 'বন্ধু মোড';

  @override
  String get howToFriendsSubtitle => 'বন্ধুদের আমন্ত্রণ করুন এবং LAN দিয়ে যোগ দিন';

  @override
  String get howToFriendsBody => 'বন্ধু মোড — দ্রুত ধাপসমূহ:\n1. প্রয়োজন হলে আপনার কনসোল বা প্ল্যাটফর্মে NetherLink friend account (relay friend) যোগ করুন।\n2. অ্যাপে বন্ধু মোড চালু করুন এবং relay configuration পাঠান (যদি প্রযোজ্য হয়)।\n3. আপনার কনসোলে Minecraft → Friends খুলে LAN Worlds খুঁজুন — আপনার সার্ভার সেখানে একটি LAN world হিসেবে দেখা উচিত।\n4. বন্ধুদের সঙ্গে আপনার সার্ভারে যোগ দিতে সেটি নির্বাচন করুন।\nনোট:\n- নিশ্চিত করুন যে আপনার এবং আপনার বন্ধুদের NAT/settings একই এবং friend presence অনুমোদন করে।\n- বন্ধু মোড প্ল্যাটফর্মের friend features-এর ওপর নির্ভরশীল এবং friend request গ্রহণ করতে হতে পারে।';

  @override
  String get helpNetherlinkTitle => 'NetherLink দেখা যাচ্ছে না';

  @override
  String get helpNetherlinkSubtitle => 'LAN শনাক্তকরণ সমস্যার সমাধান';

  @override
  String get helpNetherlinkBody => 'যদি আপনার কনসোলে সার্ভারটি না দেখা যায়, তাহলে এই ধাপগুলো চেষ্টা করুন:\n\n✅ প্রাথমিক পরীক্ষা:\n1. একই WiFi নেটওয়ার্ক - আপনার ফোন/ট্যাবলেট এবং কনসোল অবশ্যই একই WiFi-তে থাকতে হবে\n2. সঠিক সার্ভার ঠিকানা - IP এবং port আবার পরীক্ষা করুন (ডিফল্ট: 19132)\n3. সম্প্রচার সক্রিয় - NetherLink \"Broadcasting\" স্ট্যাটাস দেখাচ্ছে কি না নিশ্চিত করুন\n\n🔄 দ্রুত সমাধান:\n• অ্যাপ রিস্টার্ট করুন: সম্প্রচার বন্ধ করুন, NetherLink পুরোপুরি বন্ধ করুন, আবার খুলে চেষ্টা করুন\n• কনসোল রিস্টার্ট করুন: কখনও কখনও LAN game শনাক্ত করতে কনসোলকে রিফ্রেশ করতে হয়\n• Friends/LAN ট্যাব পরীক্ষা করুন: সার্ভারটি \"Friends\" বা \"LAN Games\" এর নিচে দেখা যায়, server list-এ নয়\n• সম্প্রচার শুরু করার পর 10-15 সেকেন্ড অপেক্ষা করুন\n• VPN বন্ধ করুন: VPN লোকাল সম্প্রচার ব্লক করতে পারে\n\n⚠️ সাধারণ সমস্যা:\n\"No route found for user\" → নিশ্চিত করুন যে দুই ডিভাইস একই Wi‑Fi-তে আছে (Guest network এড়িয়ে চলুন)\n\"Unable to connect to NetherLink relay server\" → আপনার ইন্টারনেট / relay status পরীক্ষা করুন\n\n📱 এখনও সমস্যা হচ্ছে? NetherLink-এ Debug Mode চালু করে logs পরীক্ষা করুন, অথবা অন্য কোনো সার্ভার চেষ্টা করুন।';

  @override
  String get helpMultiplayerFailedTitle => 'মাল্টিপ্লেয়ার সংযোগ ব্যর্থ';

  @override
  String get helpMultiplayerFailedSubtitle => 'কেন এটি NetherLink-এর ত্রুটি নয় তার ব্যাখ্যা';

  @override
  String get helpMultiplayerFailedBody => '⚠️ এটি NetherLink-এর কোনো সমস্যা নয়!\n\nNetherLink আপনাকে সফলভাবে অনুরোধকৃত সার্ভারে পুনর্নির্দেশ করেছে। \"Multiplayer Connection Failed\" বার্তাটি বোঝায় যে লক্ষ্য সার্ভারটি বর্তমানে অপ্রাপ্য। সম্ভাব্য কারণ:\n\n• লক্ষ্য Minecraft server অফলাইন বা অতিরিক্ত লোডে আছে\n• সার্ভারের জন্য আপডেটেড client version বা নির্দিষ্ট edition প্রয়োজন\n• relay এবং লক্ষ্য সার্ভারের মধ্যে নেটওয়ার্ক সমস্যা\n\nঅন্য কোনো সার্ভারে সংযোগ করার চেষ্টা করুন অথবা সার্ভারের support-এর সাথে যোগাযোগ করুন। যদি একাধিক সার্ভারে একই সমস্যা থাকে, NetherLink-এ Debug Mode চালু করে logs পরীক্ষা করুন।';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS কাজ করছে না';

  @override
  String get helpNintendoDnsSubtitle => 'সাধারণ DNS / relay সমস্যা';

  @override
  String get helpNintendoDnsBody => 'যদি Nintendo DNS মোড কাজ না করে, তাহলে নিচের বিষয়গুলো পরীক্ষা করুন:\n\n1. নিশ্চিত করুন যে আপনি অ্যাপ থেকে DNS config পাঠিয়েছেন (DNS কনফিগ পাঠান)।\n2. নিশ্চিত করুন যে আপনি Switch-এ relay IP-কে Primary DNS হিসেবে প্রয়োগ করেছেন।\n3. নিশ্চিত করুন যে নির্বাচিত relay server (EU/US) অনলাইনে আছে এবং অতিরিক্ত লোডে নেই।\n4. কিছু নেটওয়ার্ক (যেমন captive portal) custom DNS প্রতিরোধ করে — অন্য নেটওয়ার্কে পরীক্ষা করুন।\n\nযদি সমস্যা থেকে যায়, Debug Mode চালু করে logs পরীক্ষা করুন বা Friends-mode বিকল্পটি চেষ্টা করুন।';

  @override
  String get helpFriendsModeTitle => 'বন্ধু মোড কাজ করছে না';

  @override
  String get helpFriendsModeSubtitle => 'সাধারণ বন্ধু সংক্রান্ত সমস্যা';

  @override
  String get helpFriendsModeBody => 'বন্ধু মোড সমস্যা সমাধানের টিপস:\n\n1. নিশ্চিত করুন যে relay friend account কনসোলে যোগ/গ্রহণ করা হয়েছে (যদি প্রয়োজন হয়)।\n2. বন্ধু মোড চালু করার পর গেমটি রিস্টার্ট করে Friends/LAN ট্যাব রিফ্রেশ করার চেষ্টা করুন।\n\nযদি সার্ভারটি এখনও বন্ধুদের কাছে না দেখা যায়, তবে Debug Mode চালু করে logs পরীক্ষা করুন যাতে ত্রুটি শনাক্ত করা যায়।';

  @override
  String get changeLanguageTitle => 'ভাষা পরিবর্তন করুন';

  @override
  String get changeLanguage => 'ভাষা';

  @override
  String get useSystemLanguage => 'সিস্টেমের ভাষা ব্যবহার করুন';

  @override
  String get couldNotOpenUrl => 'URL খোলা যায়নি';
}

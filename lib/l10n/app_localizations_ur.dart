// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'کنسول';

  @override
  String get consoleOutput => 'کنسول آؤٹ پٹ';

  @override
  String get noLogsYet => 'ابھی تک کوئی لاگز نہیں';

  @override
  String get startBroadcastingToSeeOutput => 'آؤٹ پٹ دیکھنے کے لیے براڈکاسٹنگ شروع کریں';

  @override
  String get close => 'بند کریں';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'ہمارے ساتھ شامل ہوں';

  @override
  String get website => 'ویب سائٹ';

  @override
  String get howToUseMenu => 'استعمال کا طریقہ';

  @override
  String get support => 'مدد';

  @override
  String helpText(Object appCreator) {
    return '$appCreator کی طرف سے بنایا گیا۔\n\nاستعمال کا طریقہ:\n1. اپنے Minecraft سرور کا ایڈریس اور پورٹ درج کریں (ڈیفالٹ: 19132)\n   — یا ڈراپ ڈاؤن سے پہلے سے محفوظ شدہ سرور منتخب کریں\n2. (اختیاری) اپنی جگہ کے قریب ترین Relay Server (EU یا US) منتخب کریں\n3. شروع کرنے کے لیے "براڈکاسٹنگ شروع کریں" پر کلک کریں\n4. اپنے کنسول/ڈیوائس پر: Minecraft > Play > Friends\n5. آپ کو "NetherLink" نام کا ایک LAN سرور نظر آنا چاہیے\n6. اپنے بیرونی سرور میں شامل ہونے کے لیے اس پر کلک کریں\n\nNintendo Switch (DNS mode):\n1. کنیکشن پینل میں "Nintendo Switch" فعال کریں\n2. ایک Relay Server (EU یا US) منتخب کریں\n3. "Send DNS Config" پر کلک کریں — یہ آپ کی سیٹنگ relay کو بھیجتا ہے\n   (یہ LAN سرور براڈکاسٹ نہیں کرتا)\n4. اپنے Switch پر NetherLink DNS سیٹ اپ لاگو کریں اور شامل ہوں\n   اس سرور اندراج کو استعمال کرتے ہوئے جو آپ NetherLink کے لیے استعمال کرتے ہیں\n\nنوٹس:\n- LAN براڈکاسٹنگ کے لیے NetherLink اور کنسول کا ایک ہی مقامی نیٹ ورک پر ہونا ضروری ہے۔\n- مشورہ: بہترین کارکردگی کے لیے اپنے قریب ترین relay سرور کا انتخاب کریں۔';
  }

  @override
  String get language => 'اردو';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'ڈیبگ ٹوگل کریں';

  @override
  String get copyLogs => 'لاگز کاپی کریں';

  @override
  String get clear => 'صاف کریں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get deleteServer => 'سرور حذف کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get myServers => 'میرے سرورز';

  @override
  String get quickAccessServers => 'فوری رسائی والے سرورز';

  @override
  String get addServer => 'سرور شامل کریں';

  @override
  String get addServersHint => 'بعد میں جلدی جڑنے کے لیے سرورز شامل کریں';

  @override
  String get serverNameLabel => 'سرور کا نام *';

  @override
  String get addressLabel => 'ایڈریس *';

  @override
  String get portLabel => 'پورٹ *';

  @override
  String get descriptionLabel => 'تفصیل (اختیاری)';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get initializing => 'شروع کیا جا رہا ہے...';

  @override
  String get createdBy => 'NetherDev کی طرف سے بنایا گیا';

  @override
  String get bedrockBridge => 'بیڈراک برج';

  @override
  String get clientDisconnected => 'کلائنٹ منقطع ہو گیا — براڈکاسٹ بند ہو گئی';

  @override
  String get pleaseEnterServer => '⚠️ براہ کرم سرور ایڈریس درج کریں';

  @override
  String get invalidPort => '⚠️ غلط پورٹ نمبر (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS کنفیگ relay کو بھیج دی گئی';

  @override
  String get broadcastingStarted => 'براڈکاسٹنگ شروع ہو گئی';

  @override
  String get broadcastStopped => 'براڈکاسٹ بند ہو گئی';

  @override
  String selectedServer(Object name) {
    return '📋 منتخب شدہ: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'منتخب شدہ: $name';
  }

  @override
  String get noLogsToCopy => 'کاپی کرنے کے لیے کوئی لاگز نہیں';

  @override
  String copiedLogs(Object count) {
    return '$count لاگ اندراجات کلپ بورڈ میں کاپی کر دیے گئے';
  }

  @override
  String get debugEnabled => 'ڈیبگ لاگز فعال ہیں';

  @override
  String get debugDisabled => 'ڈیبگ لاگز غیر فعال ہیں';

  @override
  String get howToUseTitle => 'NetherLink استعمال کرنے کا طریقہ';

  @override
  String get iUnderstand => 'میں سمجھ گیا';

  @override
  String get playOnSwitchTitle => 'Nintendo Switch پر کھیلیں';

  @override
  String get playWithFriendsTitle => 'دوستوں کے ساتھ کھیلیں';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'منتخب شدہ: $relayName\n\nجڑنے کا طریقہ:\n1. اپنے Switch کی Settings میں جائیں اور DNS کو اس میں تبدیل کریں: $relayIp\n2. Minecraft کھولیں اور فہرست میں سے ایک سرور منتخب کریں (جیسے Cubecraft یا Hive)۔\n3. اب آپ خودکار طور پر اپنے سرور پر بھیج دیے جائیں گے۔';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'جڑنے کا طریقہ:\n1. اپنے کنسول پر $friend کو دوست کے طور پر شامل کریں۔\n2. Minecraft کھولیں اور Friends ٹیب میں جائیں۔\n3. اپنے سرور کو LAN Worlds کے تحت تلاش کریں اور شامل ہونے کے لیے اسے منتخب کریں۔';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'ریلے منتخب کریں $name';
  }

  @override
  String get noSavedServers => 'کوئی محفوظ شدہ سرور نہیں';

  @override
  String get savedServers => 'محفوظ شدہ سرورز';

  @override
  String get serverAddressHint => 'سرور ایڈریس';

  @override
  String get portHint => 'پورٹ';

  @override
  String get manageServers => 'سرورز منظم کریں';

  @override
  String get manageServersTooltip => 'سرورز منظم کریں';

  @override
  String get stopBroadcasting => 'براڈکاسٹنگ بند کریں';

  @override
  String get startNintendoMode => 'Nintendo موڈ شروع کریں';

  @override
  String get startFriendsMode => 'دوست موڈ شروع کریں';

  @override
  String get startBroadcasting => 'براڈکاسٹنگ شروع کریں';

  @override
  String get modeLabel => 'موڈ';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'دوست';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS موڈ';

  @override
  String get nintendoInfoText => 'Nintendo موڈ میں شروع کریں، اپنا DNS سیٹ کریں اور نمایاں سرور میں شامل ہوں۔';

  @override
  String get friendModeTitle => 'دوست موڈ';

  @override
  String get friendModeText => 'NetherLink کے دوست bots کو دوست کے طور پر شامل کریں۔ دوست موڈ شروع کریں اور کھیلیں';

  @override
  String get selectedRelayCheck => 'منتخب شدہ';

  @override
  String relayFallbackWarning(Object name) {
    return 'انتباہ: اصل relay نے جواب نہیں دیا۔ متبادل relay استعمال ہو رہا ہے: $name';
  }

  @override
  String get relayUnableConnect => 'کسی بھی NetherLink relay سرور سے جڑنا ممکن نہیں۔ بعد میں دوبارہ کوشش کریں یا اپنا انٹرنیٹ چیک کریں۔';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'LAN براڈکاسٹ یا پراکسی کے ذریعے کھیلیں';

  @override
  String get howToXboxBody => 'جڑنے کا طریقہ (Xbox / PS4 / PS5):\n1. یقینی بنائیں کہ NetherLink چلانے والی آپ کی ڈیوائس اور آپ کا کنسول ایک ہی مقامی نیٹ ورک پر ہیں۔\n2. ایپ میں اپنا Minecraft سرور ایڈریس اور پورٹ درج کریں اور "براڈکاسٹنگ شروع کریں" دبائیں۔\n3. کنسول پر Minecraft → Play کھولیں → LAN Worlds یا Friends ٹیب تلاش کریں اور فہرست تازہ کریں۔\n4. شامل ہونے کے لیے "NetherLink" نامی LAN سرور منتخب کریں۔\nنوٹس:\n- اگر سرور ظاہر نہ ہو تو تصدیق کریں کہ دونوں ڈیوائسز ایک ہی subnet پر ہیں اور ایپ اب بھی براڈکاسٹ کر رہی ہے۔\n- کچھ کنسول ماڈلز یا routers LAN دریافت کو بلاک کر سکتے ہیں؛ ضرورت ہو تو ایپ یا router settings تبدیل کر کے دیکھیں۔';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS mode)';

  @override
  String get howToNintendoSubtitle => 'Switch کے لیے DNS ریلے ہدایات';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS موڈ (مرحلہ وار):\n1. ایپ میں "Nintendo" موڈ فعال کریں اور ایک Relay Server (EU یا US) منتخب کریں۔\n2. DNS IP کو relay پر بھیجنے کے لیے "Send DNS Config" پر ٹیپ کریں۔\n3. اپنے Nintendo Switch پر System Settings → Internet → Internet Settings → (آپ کا نیٹ ورک) → Change Settings → DNS میں جائیں اور Primary DNS کو relay IP پر سیٹ کریں۔\n4. Minecraft کھولیں اور کسی عوامی سرور میں شامل ہوں؛ آپ relay DNS کے ذریعے اپنے سرور پر ری ڈائریکٹ ہو جائیں گے۔\nنوٹس:\n- DNS موڈ LAN سرور براڈکاسٹ نہیں کرتا؛ یہ گیم ٹریفک کو relay کے ذریعے چلاتا ہے۔\n- اگر آپ کو عام نیٹ ورک رویہ چاہیے تو کام مکمل ہونے کے بعد اپنا DNS واپس تبدیل کر دیں۔';

  @override
  String get howToFriendsTitle => 'دوست موڈ';

  @override
  String get howToFriendsSubtitle => 'دوستوں کو مدعو کریں اور LAN کے ذریعے شامل ہوں';

  @override
  String get howToFriendsBody => 'دوست موڈ — فوری مراحل:\n1. اگر ضرورت ہو تو اپنے کنسول یا پلیٹ فارم پر NetherLink دوست اکاؤنٹ شامل کریں۔\n2. ایپ میں دوست موڈ فعال کریں اور relay کنفیگریشن بھیجیں (اگر لاگو ہو)۔\n3. اپنے کنسول پر Minecraft → Friends کھولیں اور LAN Worlds تلاش کریں — آپ کا سرور وہاں LAN world کے طور پر ظاہر ہونا چاہیے۔\n4. دوستوں کے ساتھ اپنے سرور میں شامل ہونے کے لیے اسے منتخب کریں۔\nنوٹس:\n- یقینی بنائیں کہ آپ اور آپ کے دوست ایک جیسی NAT/settings رکھتے ہوں جو دوستوں کی موجودگی کی اجازت دیتی ہیں۔\n- دوست موڈ پلیٹ فارم کے دوستی features پر انحصار کرتا ہے اور friend requests قبول کرنے کی ضرورت پڑ سکتی ہے۔';

  @override
  String get helpNetherlinkTitle => 'NetherLink ظاہر نہیں ہوتا';

  @override
  String get helpNetherlinkSubtitle => 'LAN دریافت کے مسائل کا حل';

  @override
  String get helpNetherlinkBody => 'اگر سرور آپ کے کنسول پر ظاہر نہیں ہو رہا تو یہ مراحل آزمائیں:\n\n✅ بنیادی جانچ:\n1. ایک ہی WiFi نیٹ ورک - آپ کا فون/ٹیبلیٹ اور کنسول لازماً ایک ہی WiFi پر ہوں\n2. درست سرور ایڈریس - IP اور پورٹ دوبارہ چیک کریں (ڈیفالٹ: 19132)\n3. براڈکاسٹنگ فعال ہے - تصدیق کریں کہ NetherLink "براڈکاسٹنگ" اسٹیٹس دکھا رہا ہے\n\n🔄 فوری حل:\n• ایپ دوبارہ شروع کریں: براڈکاسٹنگ بند کریں، NetherLink مکمل طور پر بند کریں، دوبارہ کھولیں اور پھر کوشش کریں\n• اپنا کنسول دوبارہ شروع کریں: کبھی کبھی LAN گیمز کا پتہ لگانے کے لیے کنسول کو ریفریش درکار ہوتا ہے\n• Friends/LAN ٹیب چیک کریں: سرور "Friends" یا "LAN Games" کے تحت ظاہر ہوتا ہے، سرور لسٹ میں نہیں\n• براڈکاسٹنگ شروع کرنے کے بعد 10-15 سیکنڈ انتظار کریں\n• VPNs بند کریں: VPNs مقامی براڈکاسٹس کو بلاک کر سکتے ہیں\n\n⚠️ عام مسائل:\n"No route found for user" → یقینی بنائیں کہ دونوں ڈیوائسز ایک ہی Wi‑Fi پر ہیں (Guest نیٹ ورکس سے بچیں)\n"Unable to connect to NetherLink relay server" → اپنا انٹرنیٹ / relay اسٹیٹس چیک کریں\n\n📱 پھر بھی مسئلہ ہے؟ NetherLink میں ڈیبگ موڈ فعال کریں اور لاگز چیک کریں، یا کوئی مختلف سرور آزمائیں۔';

  @override
  String get helpMultiplayerFailedTitle => 'ملٹی پلیئر کنکشن ناکام ہو گیا';

  @override
  String get helpMultiplayerFailedSubtitle => 'یہ NetherLink کی خرابی کیوں نہیں ہے، اس کی وضاحت';

  @override
  String get helpMultiplayerFailedBody => '⚠️ یہ NetherLink کا مسئلہ نہیں ہے!\n\nNetherLink نے آپ کو کامیابی سے مطلوبہ سرور پر ری ڈائریکٹ کیا ہے۔ "Multiplayer Connection Failed" کا مطلب ہے کہ ہدف سرور اس وقت قابلِ رسائی نہیں۔ ممکنہ وجوہات:\n\n• ہدف Minecraft سرور آف لائن ہے یا بہت زیادہ بوجھ میں ہے\n• سرور کو اپ ڈیٹ شدہ کلائنٹ ورژن یا مخصوص ایڈیشن درکار ہے\n• relay اور ہدف سرور کے درمیان نیٹ ورک مسائل\n\nکسی مختلف سرور سے جڑنے کی کوشش کریں یا سرور سپورٹ سے رابطہ کریں۔ اگر یہ مسئلہ کئی سرورز پر برقرار رہے تو NetherLink میں ڈیبگ موڈ فعال کریں اور لاگز چیک کریں۔';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS کام نہیں کرتا';

  @override
  String get helpNintendoDnsSubtitle => 'عام DNS / relay مسائل';

  @override
  String get helpNintendoDnsBody => 'اگر Nintendo DNS موڈ کام نہیں کر رہا تو درج ذیل چیک کریں:\n\n1. تصدیق کریں کہ آپ نے ایپ سے DNS config بھیجی ہے (Send DNS Config)۔\n2. تصدیق کریں کہ آپ نے Switch پر relay IP کو Primary DNS کے طور پر لاگو کیا ہے۔\n3. یقینی بنائیں کہ منتخب کردہ relay سرور (EU/US) آن لائن ہے اور بہت زیادہ بوجھ میں نہیں۔\n4. کچھ نیٹ ورکس (مثلاً captive portals) کسٹم DNS کو روکتے ہیں — کسی دوسرے نیٹ ورک پر آزما کر دیکھیں۔\n\nاگر مسئلہ برقرار رہے تو ڈیبگ موڈ فعال کریں اور لاگز چیک کریں یا دوست موڈ متبادل آزمائیں۔';

  @override
  String get helpFriendsModeTitle => 'دوست موڈ کام نہیں کرتا';

  @override
  String get helpFriendsModeSubtitle => 'دوستوں سے متعلق عام مسائل';

  @override
  String get helpFriendsModeBody => 'دوست موڈ کے لیے مسئلہ حل کرنے کی تجاویز:\n\n1. یقینی بنائیں کہ relay دوست اکاؤنٹ کنسول پر شامل/قبول کیا گیا ہے (اگر ضرورت ہو)۔\n2. دوست موڈ فعال کرنے کے بعد گیم دوبارہ شروع کریں اور Friends/LAN ٹیب ریفریش کریں۔\n\nاگر سرور اب بھی دوستوں کو نظر نہیں آتا تو ڈیبگ موڈ فعال کریں اور غلطیوں کی شناخت کے لیے لاگز چیک کریں۔';

  @override
  String get changeLanguageTitle => 'زبان تبدیل کریں';

  @override
  String get changeLanguage => 'زبان';

  @override
  String get useSystemLanguage => 'سسٹم کی زبان استعمال کریں';

  @override
  String get couldNotOpenUrl => 'URL نہیں کھولا جا سکا';
}

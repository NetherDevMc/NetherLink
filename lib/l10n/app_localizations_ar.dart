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
  String get console => 'وحدة التحكم';

  @override
  String get consoleOutput => 'مخرجات وحدة التحكم';

  @override
  String get noLogsYet => 'لا توجد سجلات بعد';

  @override
  String get startBroadcastingToSeeOutput => 'ابدأ البث لرؤية المخرجات';

  @override
  String get close => 'إغلاق';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'انضم إلينا';

  @override
  String get website => 'الموقع الإلكتروني';

  @override
  String get howToUseMenu => 'طريقة الاستخدام';

  @override
  String get support => 'الدعم';

  @override
  String helpText(Object appCreator) {
    return 'تم الإنشاء بواسطة $appCreator.\n\nطريقة الاستخدام:\n1. أدخل عنوان خادم Minecraft والمنفذ الخاص بك (الافتراضي: 19132)\n   — أو اختر خادمًا محفوظًا مسبقًا من القائمة المنسدلة\n2. (اختياري) اختر خادم ترحيل (EU أو US) الأقرب إلى موقعك\n3. اضغط على \"بدء البث\" للبدء\n4. على جهازك/وحدة التحكم: Minecraft > لعب > الأصدقاء\n5. يجب أن ترى خادم شبكة محلية باسم \"NetherLink\"\n6. اضغط عليه للانضمام إلى خادمك الخارجي عبر NetherLink\n\nNintendo Switch (وضع DNS):\n1. فعّل \"Nintendo Switch\" في لوحة الاتصال\n2. اختر خادم ترحيل (EU أو US)\n3. اضغط على \"إرسال إعداد DNS\" — سيؤدي ذلك إلى إرسال إعداداتك إلى خادم الترحيل\n   (لن يقوم ببث خادم شبكة محلية)\n4. على جهاز Switch الخاص بك، طبّق إعدادات DNS الخاصة بـ NetherLink وانضم\n   باستخدام إدخال الخادم الذي تستخدمه مع NetherLink\n\nملاحظات:\n- لكي يعمل بث الشبكة المحلية، يجب أن يكون NetherLink ووحدة التحكم على نفس الشبكة المحلية.\n- نصيحة: اختر خادم الترحيل الأقرب إليك للحصول على أفضل أداء.';
  }

  @override
  String get language => 'العربية';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'تبديل التصحيح';

  @override
  String get copyLogs => 'نسخ السجلات';

  @override
  String get clear => 'مسح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get deleteServer => 'حذف الخادم';

  @override
  String get delete => 'حذف';

  @override
  String get myServers => 'خوادمي';

  @override
  String get quickAccessServers => 'خوادم الوصول السريع';

  @override
  String get addServer => 'إضافة خادم';

  @override
  String get addServersHint => 'أضف خوادم للاتصال السريع لاحقًا';

  @override
  String get serverNameLabel => 'اسم الخادم *';

  @override
  String get addressLabel => 'العنوان *';

  @override
  String get portLabel => 'المنفذ *';

  @override
  String get descriptionLabel => 'الوصف (اختياري)';

  @override
  String get save => 'حفظ';

  @override
  String get initializing => 'جارٍ التهيئة...';

  @override
  String get createdBy => 'تم الإنشاء بواسطة NetherDev';

  @override
  String get bedrockBridge => 'جسر Bedrock';

  @override
  String get clientDisconnected => 'تم فصل العميل — تم إيقاف البث';

  @override
  String get pleaseEnterServer => '⚠️ يرجى إدخال عنوان الخادم';

  @override
  String get invalidPort => '⚠️ رقم منفذ غير صالح (1-65535)';

  @override
  String get dnsConfigSent => '✅ تم إرسال إعداد DNS إلى خادم الترحيل';

  @override
  String get broadcastingStarted => 'تم بدء البث';

  @override
  String get broadcastStopped => 'تم إيقاف البث';

  @override
  String selectedServer(Object name) {
    return '📋 المحدد: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'المحدد: $name';
  }

  @override
  String get noLogsToCopy => 'لا توجد سجلات لنسخها';

  @override
  String copiedLogs(Object count) {
    return 'تم نسخ $count من إدخالات السجل إلى الحافظة';
  }

  @override
  String get debugEnabled => 'تم تفعيل سجلات التصحيح';

  @override
  String get debugDisabled => 'تم تعطيل سجلات التصحيح';

  @override
  String get howToUseTitle => 'كيفية استخدام NetherLink';

  @override
  String get iUnderstand => 'أنا أفهم';

  @override
  String get playOnSwitchTitle => 'اللعب على Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'اللعب مع الأصدقاء';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'المحدد: $relayName\n\nكيفية الاتصال:\n1. انتقل إلى إعدادات Switch الخاصة بك وغيّر DNS إلى: $relayIp\n2. افتح Minecraft واختر خادمًا من القائمة (مثل Cubecraft أو Hive).\n3. سيتم الآن توجيهك تلقائيًا إلى خادمك الخاص.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'كيفية الاتصال:\n1. على وحدة التحكم الخاصة بك، أضف $friend كصديق.\n2. افتح Minecraft وانتقل إلى تبويب Friends.\n3. ابحث عن خادمك ضمن LAN Worlds وحدده للانضمام.';
  }

  @override
  String get nldServerLabel => 'خادم NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'اختر خادم الترحيل $name';
  }

  @override
  String get noSavedServers => 'لا توجد خوادم محفوظة';

  @override
  String get savedServers => 'الخوادم المحفوظة';

  @override
  String get serverAddressHint => 'عنوان الخادم';

  @override
  String get portHint => 'المنفذ';

  @override
  String get manageServers => 'إدارة الخوادم';

  @override
  String get manageServersTooltip => 'إدارة الخوادم';

  @override
  String get stopBroadcasting => 'إيقاف البث';

  @override
  String get startNintendoMode => 'بدء وضع Nintendo';

  @override
  String get startFriendsMode => 'بدء وضع الأصدقاء';

  @override
  String get startBroadcasting => 'بدء البث';

  @override
  String get modeLabel => 'الوضع';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'الأصدقاء';

  @override
  String get nintendoInfoTitle => 'وضع DNS على Nintendo Switch';

  @override
  String get nintendoInfoText => 'ابدأ في وضع Nintendo، واضبط DNS ثم انضم إلى خادم مميز.';

  @override
  String get friendModeTitle => 'وضع الأصدقاء';

  @override
  String get friendModeText => 'أضف روبوتات أصدقاء NetherLink كأصدقاء. ابدأ وضع الأصدقاء وابدأ اللعب';

  @override
  String get selectedRelayCheck => 'المحدد';

  @override
  String relayFallbackWarning(Object name) {
    return 'تحذير: لم يستجب Relay الأصلي. يتم استخدام Relay احتياطي: $name';
  }

  @override
  String get relayUnableConnect => 'تعذر الاتصال بأي خادم Relay تابع لـ NetherLink. حاول مرة أخرى لاحقًا أو تحقق من اتصالك بالإنترنت.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (شبكة محلية / وكيل)';

  @override
  String get howToXboxSubtitle => 'العب عبر بث الشبكة المحلية أو الوكيل';

  @override
  String get howToXboxBody => 'كيفية الاتصال (Xbox / PS4 / PS5):\n1. تأكد من أن الجهاز الذي يشغّل NetherLink ووحدة التحكم الخاصة بك على نفس الشبكة المحلية.\n2. في التطبيق، أدخل عنوان خادم Minecraft والمنفذ ثم اضغط على \"بدء البث\".\n3. على وحدة التحكم افتح Minecraft → لعب → وابحث عن عوالم الشبكة المحلية أو تبويب الأصدقاء ثم حدّث القائمة.\n4. اختر خادم الشبكة المحلية المسمى \"NetherLink\" للانضمام.\nملاحظات:\n- إذا لم يظهر الخادم، فتأكد من أن الجهازين على نفس الشبكة الفرعية وأن التطبيق ما يزال يبث.\n- قد تمنع بعض طرازات وحدات التحكم أو أجهزة التوجيه اكتشاف الشبكة المحلية؛ جرّب تغيير إعدادات التطبيق أو جهاز التوجيه عند الحاجة.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (وضع DNS)';

  @override
  String get howToNintendoSubtitle => 'تعليمات DNS لخادم الترحيل على Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — وضع DNS (خطوة بخطوة):\n1. في التطبيق، فعّل وضع \"Nintendo\" واختر خادم ترحيل (EU أو US).\n2. اضغط على \"إرسال إعداد DNS\" لإرسال عنوان DNS IP إلى خادم الترحيل.\n3. على جهاز Nintendo Switch، انتقل إلى إعدادات النظام → الإنترنت → إعدادات الإنترنت → (شبكتك) → تغيير الإعدادات → DNS واضبط DNS الأساسي على عنوان IP الخاص بخادم الترحيل.\n4. افتح Minecraft وانضم إلى خادم عام؛ سيتم توجيهك إلى خادمك باستخدام DNS الخاص بخادم الترحيل.\nملاحظات:\n- وضع DNS لا يقوم ببث خادم شبكة محلية؛ بل يوجّه حركة مرور اللعبة عبر خادم الترحيل.\n- أعد DNS إلى وضعه السابق بعد الانتهاء إذا كنت بحاجة إلى سلوك شبكة طبيعي.';

  @override
  String get howToFriendsTitle => 'وضع الأصدقاء';

  @override
  String get howToFriendsSubtitle => 'ادعُ الأصدقاء وانضم عبر الشبكة المحلية';

  @override
  String get howToFriendsBody => 'وضع الأصدقاء — خطوات سريعة:\n1. أضف حساب صديق NetherLink (صديق الترحيل) على وحدة التحكم أو المنصة إذا لزم الأمر.\n2. في التطبيق، فعّل وضع الأصدقاء وأرسل إعداد خادم الترحيل (إذا كان ذلك مطلوبًا).\n3. على وحدة التحكم، افتح Minecraft → الأصدقاء وابحث عن عوالم الشبكة المحلية — يجب أن يظهر خادمك هناك كعالم شبكة محلية.\n4. اختره للانضمام إلى خادمك مع الأصدقاء.\nملاحظات:\n- تأكد من أن لديك أنت وأصدقاؤك نفس إعدادات NAT/الإعدادات التي تسمح بظهور الأصدقاء.\n- يعتمد وضع الأصدقاء على ميزات الأصدقاء الخاصة بالمنصة وقد يتطلب قبول طلبات الصداقة.';

  @override
  String get helpNetherlinkTitle => 'NetherLink لا يظهر';

  @override
  String get helpNetherlinkSubtitle => 'استكشاف مشكلات اكتشاف الشبكة المحلية وإصلاحها';

  @override
  String get helpNetherlinkBody => 'إذا لم يظهر الخادم على وحدة التحكم الخاصة بك، فجرّب هذه الخطوات:\n\n✅ فحوصات أساسية:\n1. نفس شبكة WiFi - يجب أن يكون هاتفك/جهازك اللوحي ووحدة التحكم على نفس شبكة WiFi\n2. عنوان الخادم الصحيح - تحقق مرة أخرى من IP والمنفذ (الافتراضي: 19132)\n3. البث نشط - تأكد من أن NetherLink يعرض حالة \"جاري البث\"\n\n🔄 إصلاحات سريعة:\n• أعد تشغيل التطبيق: أوقف البث، أغلق NetherLink بالكامل، أعد فتحه ثم حاول مرة أخرى\n• أعد تشغيل وحدة التحكم: أحيانًا تحتاج وحدة التحكم إلى تحديث لاكتشاف ألعاب الشبكة المحلية\n• تحقق من تبويب الأصدقاء/الشبكة المحلية: يظهر الخادم ضمن \"الأصدقاء\" أو \"ألعاب الشبكة المحلية\" وليس في قائمة الخوادم\n• انتظر من 10 إلى 15 ثانية بعد بدء البث\n• عطّل VPN: يمكن أن تمنع شبكات VPN البث المحلي\n\n⚠️ مشكلات شائعة:\n\"No route found for user\" → تأكد من أن كلا الجهازين على نفس شبكة Wi‑Fi (وتجنب شبكات الضيوف)\n\"Unable to connect to NetherLink relay server\" → تحقق من الإنترنت / حالة خادم الترحيل\n\n📱 ما زلت تواجه مشاكل؟ فعّل وضع التصحيح في NetherLink وافحص السجلات، أو جرّب خادمًا مختلفًا.';

  @override
  String get helpMultiplayerFailedTitle => 'فشل اتصال اللعب الجماعي';

  @override
  String get helpMultiplayerFailedSubtitle => 'شرح لماذا لا يعد هذا خطأ في NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ هذه ليست مشكلة في NetherLink!\n\nلقد قام NetherLink بإعادتك بنجاح إلى الخادم المطلوب. تشير رسالة \"فشل اتصال اللعب الجماعي\" إلى أن الخادم الهدف غير متاح حاليًا. الأسباب المحتملة:\n\n• خادم Minecraft الهدف غير متصل أو مثقل بالتحميل\n• يتطلب الخادم إصدار عميل محدثًا أو إصدارًا معينًا\n• توجد مشكلات في الشبكة بين Relay والخادم الهدف\n\nحاول الاتصال بخادم مختلف أو تواصل مع دعم الخادم. إذا استمرت المشكلة على عدة خوادم، فعّل وضع التصحيح في NetherLink وافحص السجلات.';

  @override
  String get helpNintendoDnsTitle => 'DNS الخاص بـ Nintendo لا يعمل';

  @override
  String get helpNintendoDnsSubtitle => 'مشكلات DNS / خادم الترحيل الشائعة';

  @override
  String get helpNintendoDnsBody => 'إذا لم يعمل وضع DNS الخاص بـ Nintendo، فتحقق مما يلي:\n\n1. تأكد من أنك أرسلت إعداد DNS من التطبيق (إرسال إعداد DNS).\n2. تحقق من أنك طبّقت عنوان IP الخاص بخادم الترحيل كـ DNS أساسي على Switch.\n3. تأكد من أن خادم الترحيل المحدد (EU/US) متصل وغير مثقل بالتحميل.\n4. بعض الشبكات (مثل البوابات المقيدة) تمنع DNS المخصص — جرّب على شبكة مختلفة.\n\nإذا استمرت المشكلات، فعّل وضع التصحيح وافحص السجلات أو جرّب البديل وهو وضع الأصدقاء.';

  @override
  String get helpFriendsModeTitle => 'وضع الأصدقاء لا يعمل';

  @override
  String get helpFriendsModeSubtitle => 'مشكلات الأصدقاء الشائعة';

  @override
  String get helpFriendsModeBody => 'نصائح استكشاف أخطاء وضع الأصدقاء وإصلاحها:\n\n1. تأكد من إضافة/قبول حساب صديق Relay على وحدة التحكم (إذا لزم الأمر).\n2. جرّب إعادة تشغيل اللعبة وتحديث تبويب Friends/LAN بعد تفعيل وضع الأصدقاء.\n\nإذا كان الخادم لا يزال لا يظهر للأصدقاء، ففعّل وضع التصحيح وافحص السجلات لتحديد الأخطاء.';

  @override
  String get changeLanguageTitle => 'تغيير اللغة';

  @override
  String get changeLanguage => 'اللغة';

  @override
  String get useSystemLanguage => 'استخدام لغة النظام';

  @override
  String get couldNotOpenUrl => 'تعذر فتح الرابط';
}

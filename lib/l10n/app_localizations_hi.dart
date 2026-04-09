// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'कंसोल';

  @override
  String get consoleOutput => 'कंसोल आउटपुट';

  @override
  String get noLogsYet => 'अभी तक कोई लॉग नहीं';

  @override
  String get startBroadcastingToSeeOutput => 'आउटपुट देखने के लिए ब्रॉडकास्टिंग शुरू करें';

  @override
  String get close => 'बंद करें';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'हमसे जुड़ें';

  @override
  String get website => 'वेबसाइट';

  @override
  String get howToUseMenu => 'कैसे उपयोग करें';

  @override
  String get support => 'सहायता';

  @override
  String helpText(Object appCreator) {
    return '$appCreator द्वारा बनाया गया।\r\n\r\nकैसे उपयोग करें:\r\n1. अपना Minecraft सर्वर पता और पोर्ट दर्ज करें (डिफ़ॉल्ट: 19132)\r\n   — या ड्रॉपडाउन से पहले से सहेजा गया सर्वर चुनें\r\n2. (वैकल्पिक) अपनी लोकेशन के सबसे पास का Relay Server (EU या US) चुनें\r\n3. शुरू करने के लिए \\\"ब्रॉडकास्टिंग शुरू करें\\\" पर क्लिक करें\r\n4. अपने कंसोल/डिवाइस पर: Minecraft > Play > Friends\r\n5. आपको \\\"NetherLink\\\" नाम का एक LAN सर्वर दिखाई देना चाहिए\r\n6. NetherLink के माध्यम से अपने बाहरी सर्वर से जुड़ने के लिए उस पर क्लिक करें\r\n\r\nNintendo Switch (DNS mode):\r\n1. कनेक्शन पैनल में \\\"Nintendo Switch\\\" सक्षम करें\r\n2. एक Relay Server (EU या US) चुनें\r\n3. \\\"DNS Config भेजें\\\" पर क्लिक करें — यह आपकी config को relay पर भेजता है\r\n   (यह LAN सर्वर ब्रॉडकास्ट नहीं करता)\r\n4. अपने Switch पर NetherLink DNS सेटअप लागू करें और\r\n   NetherLink के लिए उपयोग होने वाली server entry से जुड़ें\r\n\r\nनोट्स:\r\n- LAN ब्रॉडकास्टिंग के लिए NetherLink और कंसोल एक ही लोकल नेटवर्क पर होने चाहिए।\r\n- सुझाव: सर्वोत्तम प्रदर्शन के लिए अपने सबसे नज़दीकी relay server को चुनें।';
  }

  @override
  String get serverDetailsLabel => 'सर्वर विवरण';

  @override
  String get start => 'शुरू करें';

  @override
  String get labelJava => 'जावा';

  @override
  String get startJavaMode => 'जावा मोड शुरू करें';

  @override
  String get javaInfoTitle => 'जावा मोड';

  @override
  String get javaInfoText => 'Java Edition सर्वरों से कनेक्ट करें';

  @override
  String get howToJavaTitle => 'जावा मोड';

  @override
  String get howToJavaSubtitle => 'NetherLink के माध्यम से Java Edition सर्वरों से कनेक्ट करें';

  @override
  String get howToJavaBody => 'जावा मोड — त्वरित चरण:\r\n1. ऐप में जावा मोड चुनें।\r\n2. अपने Java Edition सर्वर का पता और पोर्ट दर्ज करें (डिफ़ॉल्ट: 25565)।\r\n3. \"जावा मोड शुरू करें\" दबाएँ — NetherLink कनेक्शन को ब्रिज करेगा।\r\n4. Minecraft Bedrock खोलें और Friends टैब पर जाएँ।\r\n5. Java सर्वर से जुड़ने के लिए \"NetherLink\" नाम वाले LAN सर्वर को चुनें।\r\n\r\n⚠️ महत्वपूर्ण चेतावनियाँ:\r\n- एक वैध Java Edition खाता (Microsoft) आवश्यक है।\r\n- कुछ सर्वर एंटी-चीट सिस्टम का उपयोग करते हैं जो आपके खाते का पता लगाकर उसे बैन कर सकते हैं।\r\n- कुछ सर्वर Bedrock क्लाइंट्स को स्पष्ट रूप से प्रतिबंधित करते हैं — हमेशा सर्वर के नियम जाँचें।\r\n- इस सुविधा के उपयोग से होने वाले किसी भी अकाउंट बैन, निलंबन या अन्य अकाउंट-संबंधित समस्याओं के लिए NetherLink ज़िम्मेदार नहीं है।\r\n- इसे अपने जोखिम पर उपयोग करें।';

  @override
  String get language => 'हिन्दी';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'डिबग टॉगल करें';

  @override
  String get copyLogs => 'लॉग कॉपी करें';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get deleteServer => 'सर्वर हटाएँ';

  @override
  String get delete => 'हटाएँ';

  @override
  String get myServers => 'मेरे सर्वर';

  @override
  String get quickAccessServers => 'त्वरित पहुँच सर्वर';

  @override
  String get addServer => 'सर्वर जोड़ें';

  @override
  String get addServersHint => 'बाद में जल्दी कनेक्ट करने के लिए सर्वर जोड़ें';

  @override
  String get serverNameLabel => 'सर्वर नाम *';

  @override
  String get addressLabel => 'पता *';

  @override
  String get portLabel => 'पोर्ट *';

  @override
  String get descriptionLabel => 'विवरण (वैकल्पिक)';

  @override
  String get save => 'सहेजें';

  @override
  String get initializing => 'आरंभ किया जा रहा है...';

  @override
  String get createdBy => 'NetherDev द्वारा बनाया गया';

  @override
  String get bedrockBridge => 'बेडरॉक ब्रिज';

  @override
  String get clientDisconnected => 'क्लाइंट डिस्कनेक्ट हो गया — ब्रॉडकास्ट बंद हो गया';

  @override
  String get pleaseEnterServer => '⚠️ कृपया एक सर्वर पता दर्ज करें';

  @override
  String get invalidPort => '⚠️ अमान्य पोर्ट नंबर (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS config relay को भेज दिया गया';

  @override
  String get broadcastingStarted => 'ब्रॉडकास्टिंग शुरू हो गई';

  @override
  String get broadcastStopped => 'ब्रॉडकास्ट बंद हो गया';

  @override
  String selectedServer(Object name) {
    return '📋 चयनित: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'चयनित: $name';
  }

  @override
  String get noLogsToCopy => 'कॉपी करने के लिए कोई लॉग नहीं';

  @override
  String copiedLogs(Object count) {
    return '$count लॉग एंट्रियाँ क्लिपबोर्ड पर कॉपी की गईं';
  }

  @override
  String get debugEnabled => 'डिबग लॉग सक्षम किए गए';

  @override
  String get debugDisabled => 'डिबग लॉग अक्षम किए गए';

  @override
  String get howToUseTitle => 'NetherLink का उपयोग कैसे करें';

  @override
  String get iUnderstand => 'मैं समझ गया';

  @override
  String get playOnSwitchTitle => 'Nintendo Switch पर खेलें';

  @override
  String get playWithFriendsTitle => 'दोस्तों के साथ खेलें';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'चयनित: $relayName\r\n\r\nकैसे कनेक्ट करें:\r\n1. अपने Switch Settings में जाएँ और DNS को इस पर बदलें: $relayIp\r\n2. Minecraft खोलें और सूची से एक सर्वर चुनें (जैसे Cubecraft या Hive)।\r\n3. अब आपको अपने सर्वर पर अपने आप भेज दिया जाएगा।';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'कैसे कनेक्ट करें:\r\n1. अपने कंसोल पर $friend को मित्र के रूप में जोड़ें।\r\n2. Minecraft खोलें और Friends टैब पर जाएँ।\r\n3. LAN Worlds के अंतर्गत अपने सर्वर को ढूँढें और जुड़ने के लिए उसे चुनें।';
  }

  @override
  String get nldServerLabel => 'NETHERLINK सर्वर';

  @override
  String selectRelayLabel(Object name) {
    return 'रिले चुनें $name';
  }

  @override
  String get noSavedServers => 'कोई सहेजा गया सर्वर नहीं';

  @override
  String get savedServers => 'सहेजे गए सर्वर';

  @override
  String get serverAddressHint => 'सर्वर पता';

  @override
  String get portHint => 'पोर्ट';

  @override
  String get manageServers => 'सर्वर प्रबंधित करें';

  @override
  String get manageServersTooltip => 'सर्वर प्रबंधित करें';

  @override
  String get stopBroadcasting => 'ब्रॉडकास्टिंग बंद करें';

  @override
  String get startNintendoMode => 'Nintendo मोड शुरू करें';

  @override
  String get startFriendsMode => 'मित्र मोड शुरू करें';

  @override
  String get startBroadcasting => 'ब्रॉडकास्टिंग शुरू करें';

  @override
  String get modeLabel => 'मोड';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'दोस्त';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS मोड';

  @override
  String get nintendoInfoText => 'Nintendo मोड में शुरू करें, अपना DNS सेट करें और किसी चुने हुए सर्वर से जुड़ें।';

  @override
  String get friendModeTitle => 'मित्र मोड';

  @override
  String get friendModeText => 'NetherLink के मित्र बॉट्स को मित्र के रूप में जोड़ें। मित्र मोड शुरू करें और खेलें';

  @override
  String get selectedRelayCheck => 'चयनित';

  @override
  String relayFallbackWarning(Object name) {
    return 'चेतावनी: मूल relay ने जवाब नहीं दिया। Fallback relay उपयोग में है: $name';
  }

  @override
  String get relayUnableConnect => 'किसी भी NetherLink relay server से कनेक्ट नहीं हो सका। बाद में फिर प्रयास करें या अपना इंटरनेट जाँचें।';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / प्रॉक्सी)';

  @override
  String get howToXboxSubtitle => 'LAN ब्रॉडकास्ट या प्रॉक्सी के माध्यम से खेलें';

  @override
  String get howToXboxBody => 'कैसे कनेक्ट करें (Xbox / PS4 / PS5):\r\n1. सुनिश्चित करें कि NetherLink चलाने वाला आपका डिवाइस और आपका कंसोल एक ही लोकल नेटवर्क पर हैं।\r\n2. ऐप में अपना Minecraft server address और port दर्ज करें और \\\"ब्रॉडकास्टिंग शुरू करें\\\" दबाएँ।\r\n3. कंसोल पर Minecraft → Play खोलें → LAN Worlds या Friends टैब देखें और सूची को रिफ्रेश करें।\r\n4. जुड़ने के लिए \\\"NetherLink\\\" नाम वाले LAN server को चुनें।\r\nनोट्स:\r\n- यदि सर्वर दिखाई नहीं देता, तो पुष्टि करें कि दोनों डिवाइस एक ही subnet पर हैं और ऐप अभी भी ब्रॉडकास्ट कर रही है।\r\n- कुछ कंसोल मॉडल या राउटर LAN discovery को ब्लॉक कर सकते हैं; जरूरत पड़ने पर ऐप या राउटर सेटिंग्स बदलकर देखें।';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS मोड)';

  @override
  String get howToNintendoSubtitle => 'Switch के लिए DNS रिले निर्देश';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS मोड (स्टेप-बाय-स्टेप):\r\n1. ऐप में \\\"Nintendo\\\" मोड सक्षम करें और एक रिले सर्वर (EU या US) चुनें।\r\n2. DNS IP को रिले तक भेजने के लिए \\\"DNS Config भेजें\\\" पर टैप करें।\r\n3. अपने Nintendo Switch पर System Settings → Internet → Internet Settings → (your network) → Change Settings → DNS पर जाएँ और Primary DNS को रिले IP पर सेट करें।\r\n4. Minecraft खोलें और किसी सार्वजनिक सर्वर से जुड़ें; रिले DNS का उपयोग करते हुए आपको आपके सर्वर पर रीडायरेक्ट कर दिया जाएगा।\r\nनोट्स:\r\n- DNS मोड LAN सर्वर ब्रॉडकास्ट नहीं करता; यह गेम ट्रैफ़िक को रिले के माध्यम से रूट करता है।\r\n- काम पूरा होने के बाद यदि सामान्य नेटवर्क व्यवहार चाहिए, तो DNS वापस बदल दें।';

  @override
  String get howToFriendsTitle => 'मित्र मोड';

  @override
  String get howToFriendsSubtitle => 'मित्रों को आमंत्रित करें और LAN के माध्यम से जुड़ें';

  @override
  String get howToFriendsBody => 'मित्र मोड — त्वरित चरण:\r\n1. यदि आवश्यक हो, तो अपने कंसोल या प्लेटफ़ॉर्म पर NetherLink friend account (relay friend) जोड़ें।\r\n2. ऐप में मित्र मोड सक्षम करें और रिले configuration भेजें (यदि लागू हो)।\r\n3. अपने कंसोल पर Minecraft → Friends खोलें और LAN Worlds खोजें — आपका सर्वर वहाँ LAN world के रूप में दिखाई देना चाहिए।\r\n4. मित्रों के साथ अपने सर्वर से जुड़ने के लिए उसे चुनें।\r\nनोट्स:\r\n- सुनिश्चित करें कि आप और आपके मित्र एक जैसे NAT/settings का उपयोग कर रहे हैं जो friend presence की अनुमति देते हैं।\r\n- मित्र मोड प्लेटफ़ॉर्म के friend features पर निर्भर करता है और friend requests स्वीकार करने की आवश्यकता हो सकती है।';

  @override
  String get helpNetherlinkTitle => 'NetherLink दिखाई नहीं दे रहा';

  @override
  String get helpNetherlinkSubtitle => 'LAN खोज संबंधी समस्याओं का समाधान';

  @override
  String get helpNetherlinkBody => 'यदि सर्वर आपके कंसोल पर दिखाई नहीं दे रहा है, तो ये चरण आज़माएँ:\r\n\r\n✅ बुनियादी जाँच:\r\n1. एक ही WiFi नेटवर्क - आपका फ़ोन/टैबलेट और कंसोल एक ही WiFi पर होना चाहिए\r\n2. सही सर्वर पता - IP और port दोबारा जाँचें (डिफ़ॉल्ट: 19132)\r\n3. ब्रॉडकास्टिंग सक्रिय - पुष्टि करें कि NetherLink \\\"Broadcasting\\\" स्थिति दिखा रहा है\r\n\r\n🔄 त्वरित समाधान:\r\n• ऐप को पुनः आरंभ करें: ब्रॉडकास्टिंग बंद करें, NetherLink को पूरी तरह बंद करें, फिर दोबारा खोलकर प्रयास करें\r\n• अपने कंसोल को पुनः आरंभ करें: कभी-कभी LAN games का पता लगाने के लिए कंसोल को रिफ्रेश की आवश्यकता होती है\r\n• Friends/LAN टैब जाँचें: सर्वर \\\"Friends\\\" या \\\"LAN Games\\\" के अंतर्गत दिखाई देता है, server list में नहीं\r\n• ब्रॉडकास्टिंग शुरू करने के बाद 10-15 सेकंड प्रतीक्षा करें\r\n• VPN अक्षम करें: VPN लोकल ब्रॉडकास्ट को ब्लॉक कर सकते हैं\r\n\r\n⚠️ सामान्य समस्याएँ:\r\n\\\"No route found for user\\\" → सुनिश्चित करें कि दोनों डिवाइस एक ही Wi‑Fi पर हैं (Guest networks से बचें)\r\n\\\"Unable to connect to NetherLink relay server\\\" → अपना इंटरनेट / relay status जाँचें\r\n\r\n📱 अभी भी समस्या है? NetherLink में Debug Mode सक्षम करें और logs जाँचें, या कोई दूसरा सर्वर आज़माएँ।';

  @override
  String get helpMultiplayerFailedTitle => 'मल्टीप्लेयर कनेक्शन विफल';

  @override
  String get helpMultiplayerFailedSubtitle => 'यह NetherLink त्रुटि क्यों नहीं है, इसका स्पष्टीकरण';

  @override
  String get helpMultiplayerFailedBody => '⚠️ यह NetherLink की समस्या नहीं है!\r\n\r\nNetherLink ने आपको सफलतापूर्वक अनुरोधित सर्वर पर रीडायरेक्ट कर दिया। \\\"Multiplayer Connection Failed\\\" संदेश का अर्थ है कि लक्ष्य सर्वर इस समय पहुँच से बाहर है। संभावित कारण:\r\n\r\n• लक्ष्य Minecraft सर्वर ऑफ़लाइन है या अत्यधिक लोड में है\r\n• सर्वर को अपडेटेड client version या किसी विशेष edition की आवश्यकता है\r\n• relay और लक्ष्य सर्वर के बीच नेटवर्क समस्याएँ हैं\r\n\r\nकिसी दूसरे सर्वर से कनेक्ट करने का प्रयास करें या सर्वर के support से संपर्क करें। यदि समस्या कई सर्वरों पर बनी रहती है, तो NetherLink में Debug Mode सक्षम करें और logs जाँचें।';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS काम नहीं कर रहा';

  @override
  String get helpNintendoDnsSubtitle => 'सामान्य DNS / relay समस्याएँ';

  @override
  String get helpNintendoDnsBody => 'यदि Nintendo DNS मोड काम नहीं कर रहा है, तो निम्नलिखित जाँचें:\r\n\r\n1. पुष्टि करें कि आपने ऐप से DNS config भेजा है (DNS Config भेजें)।\r\n2. पुष्टि करें कि आपने Switch पर relay IP को Primary DNS के रूप में लागू किया है।\r\n3. सुनिश्चित करें कि चुना गया relay server (EU/US) ऑनलाइन है और ओवरलोड नहीं है।\r\n4. कुछ नेटवर्क (जैसे captive portals) custom DNS को रोकते हैं — किसी दूसरे नेटवर्क पर परीक्षण करें।\r\n\r\nयदि समस्या बनी रहती है, तो Debug Mode सक्षम करें और logs जाँचें या Friends-mode विकल्प आज़माएँ।';

  @override
  String get helpFriendsModeTitle => 'मित्र मोड काम नहीं कर रहा';

  @override
  String get helpFriendsModeSubtitle => 'सामान्य मित्र समस्याएँ';

  @override
  String get helpFriendsModeBody => 'मित्र मोड के लिए समस्या-निवारण सुझाव:\r\n\r\n1. सुनिश्चित करें कि relay friend account कंसोल पर जोड़ा/स्वीकार किया गया है (यदि आवश्यक हो)।\r\n2. मित्र मोड सक्षम करने के बाद गेम को पुनः आरंभ करें और Friends/LAN टैब को रिफ्रेश करें।\r\n\r\nयदि सर्वर अब भी मित्रों को दिखाई नहीं देता, तो त्रुटियाँ पहचानने के लिए Debug Mode सक्षम करें और logs जाँचें।';

  @override
  String get changeLanguageTitle => 'भाषा बदलें';

  @override
  String get changeLanguage => 'भाषा';

  @override
  String get useSystemLanguage => 'सिस्टम भाषा का उपयोग करें';

  @override
  String get couldNotOpenUrl => 'URL खोला नहीं जा सका';
}

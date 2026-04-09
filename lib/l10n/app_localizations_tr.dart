// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Konsol';

  @override
  String get consoleOutput => 'Konsol Çıktısı';

  @override
  String get noLogsYet => 'Henüz kayıt yok';

  @override
  String get startBroadcastingToSeeOutput => 'Çıktıyı görmek için yayına başlayın';

  @override
  String get close => 'Kapat';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Bize Katılın';

  @override
  String get more => 'More';

  @override
  String get website => 'Websitesi';

  @override
  String get howToUseMenu => 'Nasıl kullanılır';

  @override
  String get support => 'Destek';

  @override
  String helpText(Object appCreator) {
    return 'Yapan: $appCreator\n\nKullanım Talimatları:\n1. Minecraft sunucu adresinizi ve portunuzu girin (varsayılan: 19132)\n   — veya daha önce kaydedilmiş bir sunucuyu açılır menüden seçin\n2. (İsteğe bağlı) Konumunuza en yakın aktarma sunucusunu (EU veya US) seçin\n3. Yayına başlamak için \"Yayına Başla\" düğmesine tıklayın\n4. Konsolunuz/cihazınızda: Minecraft > Oyna > Arkadaşlar\n5. \"NetherLink\" adlı bir LAN sunucusu görmelisiniz\n6. NetherLink üzerinden seçtiğiniz sunucunuya katılmak için üzerine tıklayın\n\nNintendo Switch (DNS modu):\n1. Bağlantı panelinde \"Nintendo Switch\"i etkinleştirin\n2. Bir  aktarma sunucusu  (EU veya US) seçin\n3. \"DNS Yapılandırmasını Gönder\" düğmesine tıklayın — bu yapılandırmanızı aktarıcıya gönderir\n   (LAN sunucusu yayınlamaz)\n4. Switch’inizde NetherLink DNS ayarlarınızı uygulayın ve NetherLink için kullandığınız sunucu girişini kullanarak katılın\n\nNotlar:\n- LAN yayını için NetherLink ve konsol aynı yerel ağda olmalıdır.\n- İpucu: En iyi performans için size en yakın aktarma sunucusunu seçin.';
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
  String get howToJavaBody => 'Java Mode — quick steps:\n1. In the app, select Java mode.\n2. Enter your Java Edition server address and port (default: 25565).\n3. Press \"Start Java Mode\" — NetherLink bridges the connection.\n4. Open Minecraft Bedrock and go to the Friends tab.\n5. Select the LAN server named \"NetherLink\" to join the Java server.\n\n⚠️ Important warnings:\n- A valid Java Edition account (Microsoft) is required.\n- Some servers use anti-cheat systems that may detect and ban your account.\n- Certain servers explicitly prohibit Bedrock clients — always check the server rules.\n- NetherLink is not responsible for any account bans, suspensions, or other account-related issues that may result from using this feature.\n- Use at your own risk.';

  @override
  String get language => 'Türkçe';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Hata ayıklamayı aç/kapat';

  @override
  String get copyLogs => 'Kayıtları kopyala';

  @override
  String get clear => 'Temizle';

  @override
  String get cancel => 'İptal';

  @override
  String get deleteServer => 'Sunucuyu sil';

  @override
  String get delete => 'Sil';

  @override
  String get myServers => 'Benim sunucularım';

  @override
  String get quickAccessServers => 'Sunuculara hızlı eriş';

  @override
  String get addServer => 'Sunucu Ekle';

  @override
  String get addServersHint => 'Daha sonra hızlıca bağlanmak için sunucu ekleyin';

  @override
  String get serverNameLabel => 'Sunucu Adı *';

  @override
  String get addressLabel => 'Adres *';

  @override
  String get portLabel => 'Port *';

  @override
  String get descriptionLabel => 'Açıklama (Opsiyonel)';

  @override
  String get save => 'Kaydet';

  @override
  String get initializing => 'Başlatılıyor...';

  @override
  String get createdBy => 'NetherDev tarafından yapıldı';

  @override
  String get bedrockBridge => 'Bedrock Köprüsü';

  @override
  String get clientDisconnected => 'İstemci bağlantısı kesildi — Yayın durduruldu';

  @override
  String get pleaseEnterServer => '⚠️ Lütfen bir sunucu adresi girin';

  @override
  String get invalidPort => '⚠️ Geçersiz port numarası (1-65535)';

  @override
  String get dnsConfigSent => '✅ DNS yapılandırması aktarıcıya gönderildi';

  @override
  String get broadcastingStarted => 'Yayın başladı';

  @override
  String get broadcastStopped => 'Yayın durdu';

  @override
  String selectedServer(Object name) {
    return '📋 Seçilen: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Seçilen: $name';
  }

  @override
  String get noLogsToCopy => 'Kopyalanacak kayıt yok';

  @override
  String copiedLogs(Object count) {
    return '$count kayıt panoya kopyalandı';
  }

  @override
  String get debugEnabled => 'Hata ayıklama kayıtları etkinleştirildi';

  @override
  String get debugDisabled => 'Hata ayıklama kayıtları devre dışı bırakıldı';

  @override
  String get howToUseTitle => 'NetherLink nasıl kullanılır';

  @override
  String get iUnderstand => 'Anlıyorum';

  @override
  String get playOnSwitchTitle => 'Nintendo Switch\'te oyna';

  @override
  String get playWithFriendsTitle => 'Arkadaşlar ile oyna';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Seçilen: $relayName\n\nBağlanma Adımları:\n1. Switch Ayarlarına gidin ve DNS’inizi bu ip ile değiştirin: $relayIp\n2. Minecraft’ı açın ve listeden bir sunucu seçin (örneğin Cubecraft veya Hive).\n3. Artık otomatik olarak kendi sunucunuza yönlendirileceksiniz.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Bağlanma Adımları:\n1. Konsolunuzda $friend’i arkadaş olarak ekleyin.\n2. Minecraft’ı açın ve Arkadaşlar sekmesine gidin.\n3. LAN Dünyaları altında sunucunuzu bulun ve katılmak için seçin.';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SUNUCUSU';

  @override
  String selectRelayLabel(Object name) {
    return 'Seçilen aktarıcı $name';
  }

  @override
  String get noSavedServers => 'Kaydedilen sunucu yok';

  @override
  String get savedServers => 'Kaydedilen sunucular';

  @override
  String get serverAddressHint => 'Sunucu Adresi';

  @override
  String get portHint => 'Port';

  @override
  String get manageServers => 'Sunucuları yönet';

  @override
  String get manageServersTooltip => 'Sunucuları yönet';

  @override
  String get stopBroadcasting => 'Yayını Durdur';

  @override
  String get startNintendoMode => 'Nintendo Modunu başlat';

  @override
  String get startFriendsMode => 'Arkadaş Modunu başlat';

  @override
  String get startBroadcasting => 'Yayına Başla';

  @override
  String get modeLabel => 'Mod';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Arkadaşlar';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS modu';

  @override
  String get nintendoInfoText => 'Nintendo modunu başlatın, DNS ayarlarınızı ayarlayın ve öne çıkan bir sunucuya bağlanın.';

  @override
  String get friendModeTitle => 'Arkadaş modu';

  @override
  String get friendModeText => 'NetherLink\'in arkadaş botlarını arkadaş olarak ekle. Arkadaş modunu başlat ve oyna';

  @override
  String get selectedRelayCheck => 'Seçilen';

  @override
  String relayFallbackWarning(Object name) {
    return 'Uyarı: Orijinal aktarıcı yanıt vermedi. Yedek aktarıcı kullanılıyor: $name';
  }

  @override
  String get relayUnableConnect => 'Hiçbir NetherLink aktarım sunucusuna bağlanılamıyor. Daha sonra tekrar deneyin veya internet bağlantınızı kontrol edin.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'LAN yayını veya proxy ile oyna';

  @override
  String get howToXboxBody => 'Xbox / PS4 / PS5 için bağlanma adımları:\n1. NetherLink çalıştıran cihazınızın ve konsolunuzun aynı yerel ağda olduğundan emin olun.\n2. Uygulamada Minecraft sunucu adresinizi ve portunuzu girin, ardından \"Yayına Başla\" düğmesine basın.\n3. Konsolda Minecraft → Oyna bölümünü açın, LAN Dünyaları veya Arkadaşlar sekmesini bulun ve listeyi yenileyin.\n4. Katılmak için \"NetherLink\" adlı LAN sunucusunu seçin.\nNotlar:\n- Sunucu görünmüyorsa, iki cihazın da aynı alt ağda olduğunu ve uygulamanın hâlâ yayın yaptığını doğrulayın.\n- Bazı konsol modelleri veya yönlendiriciler LAN keşfini engelleyebilir; gerekirse uygulama ya da yönlendirici ayarlarını değiştirerek tekrar deneyin.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS modu)';

  @override
  String get howToNintendoSubtitle => 'Switch için DNS aktarıcı talimatları';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS modu (adım adım):\n1. Uygulamada \"Nintendo\" modunu etkinleştirin ve bir Aktarım Sunucusu (EU veya US) seçin.\n2. DNS IP adresini aktarıcıya göndermek için \"DNS Yapılandırmasını Gönder\" düğmesine dokunun.\n3. Nintendo Switch\'inizde Sistem Ayarları → İnternet → İnternet Ayarları → (ağınız) → Ayarları Değiştir → DNS bölümüne gidin ve Birincil DNS\'i aktarıcı IP adresi olarak ayarlayın.\n4. Minecraft\'ı açın ve herkese açık bir sunucuya katılın; aktarıcı DNS\'i üzerinden kendi sunucunuza yönlendirileceksiniz.\nNotlar:\n- DNS modu bir LAN sunucusu yayınlamaz; oyun trafiğini aktarıcı üzerinden yönlendirir.\n- Normal ağ davranışına dönmek istediğinizde DNS ayarınızı eski haline getirin.';

  @override
  String get howToFriendsTitle => 'Arkadaş modu';

  @override
  String get howToFriendsSubtitle => 'Arkadaşlarını davet et ve LAN üzerinden katıl';

  @override
  String get howToFriendsBody => 'Arkadaş modu — hızlı adımlar:\n1. Gerekliyse NetherLink arkadaş hesabını (aktarıcı arkadaş) konsolunuza veya platformunuza ekleyin.\n2. Uygulamada Arkadaş modunu etkinleştirin ve aktarıcı yapılandırmasını gönderin (uygunsa).\n3. Konsolunuzda Minecraft → Arkadaşlar bölümünü açın ve LAN Dünyaları\'nı arayın; sunucunuz orada bir LAN dünyası olarak görünmelidir.\n4. Arkadaşlarınızla sunucunuza katılmak için onu seçin.\nNotlar:\n- Hem sizin hem de arkadaşlarınızın arkadaş görünürlüğüne izin veren aynı NAT/ayarlarına sahip olduğundan emin olun.\n- Arkadaş modu, platformun arkadaş özelliklerine dayanır ve arkadaşlık isteklerinin kabul edilmesini gerektirebilir.';

  @override
  String get helpNetherlinkTitle => 'NetherLink görünmüyor';

  @override
  String get helpNetherlinkSubtitle => 'LAN keşif sorunlarını giderme';

  @override
  String get helpNetherlinkBody => 'Sunucu konsolunuzda görünmüyorsa şu adımları deneyin:\n\n✅ Temel Kontroller:\n1. Aynı WiFi Ağı - Telefonunuz/tabletiniz ve konsolunuz AYNI WiFi ağına bağlı olmalıdır\n2. Doğru Sunucu Adresi - IP ve portu tekrar kontrol edin (varsayılan: 19132)\n3. Yayın Aktif - NetherLink\'in \"Yayın Yapılıyor\" durumunu gösterdiğini doğrulayın\n\n🔄 Hızlı Çözümler:\n• Uygulamayı yeniden başlatın: Yayını durdurun, NetherLink\'i tamamen kapatın, yeniden açın ve tekrar deneyin\n• Konsolunuzu yeniden başlatın: Bazen konsolun LAN oyunlarını algılaması için yenilenmesi gerekir\n• Arkadaşlar/LAN sekmesini kontrol edin: Sunucu, sunucu listesinde DEĞİL, \"Arkadaşlar\" veya \"LAN Oyunları\" altında görünür\n• Yayını başlattıktan sonra 10-15 saniye bekleyin\n• VPN\'leri devre dışı bırakın: VPN\'ler yerel yayınları engelleyebilir\n\n⚠️ Yaygın Sorunlar:\n\"Kullanıcı için rota bulunamadı\" → Her iki cihazın da aynı Wi‑Fi ağına bağlı olduğundan emin olun (Misafir ağlarından kaçının)\n\"NetherLink aktarıcı sunucusuna bağlanılamıyor\" → İnternet bağlantınızı / aktarıcı durumunu kontrol edin\n\n📱 Hâlâ sorun mu yaşıyorsunuz? NetherLink\'te Hata Ayıklama Modunu etkinleştirin ve kayıtları kontrol edin ya da farklı bir sunucu deneyin.';

  @override
  String get helpMultiplayerFailedTitle => 'Çok Oyunculu Bağlantı Başarısız';

  @override
  String get helpMultiplayerFailedSubtitle => 'Bunun neden bir NetherLink hatası olmadığının açıklaması';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Bu, NetherLink ile ilgili bir sorun değildir!\n\nNetherLink sizi istenen sunucuya başarıyla yönlendirdi. \"Çok Oyunculu Bağlantı Başarısız\" mesajı, hedef sunucunun şu anda erişilemez olduğunu gösterir. Olası nedenler:\n\n• Hedef Minecraft sunucusu çevrimdışı veya aşırı yüklü olabilir\n• Sunucu güncel bir istemci sürümü ya da belirli bir sürüm gerektiriyor olabilir\n• Aktarıcı ile hedef sunucu arasında ağ sorunları olabilir\n\nFarklı bir sunucuya bağlanmayı deneyin veya sunucunun destek ekibiyle iletişime geçin. Sorun birden fazla sunucuda sürerse, NetherLink\'te Hata Ayıklama Modunu etkinleştirip kayıtları kontrol edin.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS çalışmıyor';

  @override
  String get helpNintendoDnsSubtitle => 'Yaygın DNS / aktarıcı sorunları';

  @override
  String get helpNintendoDnsBody => 'Nintendo DNS modu çalışmıyorsa aşağıdakileri kontrol edin:\n\n1. Uygulamadan DNS yapılandırmasını gönderdiğinizi doğrulayın (DNS Yapılandırmasını Gönder).\n2. Aktarıcı IP adresini Switch\'te Birincil DNS olarak uyguladığınızı doğrulayın.\n3. Seçilen aktarıcı sunucusunun (EU/US) çevrimiçi ve aşırı yük altında olmadığından emin olun.\n4. Bazı ağlar (örneğin captive portal kullanılan ağlar) özel DNS kullanımını engeller; farklı bir ağda test edin.\n\nSorun devam ederse Hata Ayıklama Modunu etkinleştirip kayıtları kontrol edin veya Arkadaş modu alternatifini deneyin.';

  @override
  String get helpFriendsModeTitle => 'Arkadaş modu çalışmıyor';

  @override
  String get helpFriendsModeSubtitle => 'Yaygın arkadaş sorunları';

  @override
  String get helpFriendsModeBody => 'Arkadaş modu için sorun giderme ipuçları:\n\n1. Aktarıcı arkadaş hesabının konsolda eklendiğinden/kabul edildiğinden emin olun (gerekiyorsa).\n2. Arkadaş modunu etkinleştirdikten sonra oyunu yeniden başlatmayı ve Arkadaşlar/LAN sekmesini yenilemeyi deneyin.\n\nSunucu arkadaşlarınıza hâlâ görünmüyorsa hataları belirlemek için Hata Ayıklama Modunu etkinleştirin ve kayıtları kontrol edin.';

  @override
  String get changeLanguageTitle => 'Change language';

  @override
  String get changeLanguage => 'Language';

  @override
  String get useSystemLanguage => 'Use system language';

  @override
  String get couldNotOpenUrl => 'Could not open URL';
}

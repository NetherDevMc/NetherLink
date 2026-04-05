// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Konsol';

  @override
  String get consoleOutput => 'Output Konsol';

  @override
  String get noLogsYet => 'Belum ada log';

  @override
  String get startBroadcastingToSeeOutput => 'Mulai siaran untuk melihat output';

  @override
  String get close => 'Tutup';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Gabung dengan Kami';

  @override
  String get website => 'Situs Web';

  @override
  String get howToUseMenu => 'Cara menggunakan';

  @override
  String get support => 'Dukungan';

  @override
  String helpText(Object appCreator) {
    return 'Dibuat oleh $appCreator.\n\nCara menggunakan:\n1. Masukkan alamat dan port server Minecraft Anda (default: 19132)\n   — atau pilih server yang sebelumnya disimpan dari menu dropdown\n2. (Opsional) Pilih Server Relay (EU atau US) yang paling dekat dengan lokasi Anda\n3. Klik "Mulai Siaran" untuk memulai\n4. Di konsol/perangkat Anda: Minecraft > Play > Friends\n5. Anda akan melihat server LAN bernama "NetherLink"\n6. Klik server tersebut untuk bergabung ke server eksternal Anda melalui NetherLink\n\nNintendo Switch (mode DNS):\n1. Aktifkan "Nintendo Switch" di panel koneksi\n2. Pilih Server Relay (EU atau US)\n3. Klik "Send DNS Config" — ini mengirim konfigurasi Anda ke relay\n   (ini TIDAK menyiarkan server LAN)\n4. Di Switch Anda, terapkan pengaturan DNS NetherLink lalu bergabung\n   menggunakan entri server yang Anda pakai untuk NetherLink\n\nCatatan:\n- Untuk siaran LAN, NetherLink dan konsol harus berada di jaringan lokal yang sama.\n- Tips: Pilih server relay yang paling dekat dengan Anda untuk performa terbaik.';
  }

  @override
  String get language => 'Indonesia';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Alihkan debug';

  @override
  String get copyLogs => 'Salin log';

  @override
  String get clear => 'Bersihkan';

  @override
  String get cancel => 'Batal';

  @override
  String get deleteServer => 'Hapus Server';

  @override
  String get delete => 'Hapus';

  @override
  String get myServers => 'Server Saya';

  @override
  String get quickAccessServers => 'Server akses cepat';

  @override
  String get addServer => 'Tambah Server';

  @override
  String get addServersHint => 'Tambahkan server agar cepat terhubung nanti';

  @override
  String get serverNameLabel => 'Nama Server *';

  @override
  String get addressLabel => 'Alamat *';

  @override
  String get portLabel => 'Port *';

  @override
  String get descriptionLabel => 'Deskripsi (Opsional)';

  @override
  String get save => 'Simpan';

  @override
  String get initializing => 'Memulai...';

  @override
  String get createdBy => 'Dibuat oleh NetherDev';

  @override
  String get bedrockBridge => 'Jembatan Bedrock';

  @override
  String get clientDisconnected => 'Klien terputus — Siaran dihentikan';

  @override
  String get pleaseEnterServer => '⚠️ Harap masukkan alamat server';

  @override
  String get invalidPort => '⚠️ Nomor port tidak valid (1-65535)';

  @override
  String get dnsConfigSent => '✅ Konfigurasi DNS dikirim ke relay';

  @override
  String get broadcastingStarted => 'Siaran dimulai';

  @override
  String get broadcastStopped => 'Siaran dihentikan';

  @override
  String selectedServer(Object name) {
    return '📋 Dipilih: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Dipilih: $name';
  }

  @override
  String get noLogsToCopy => 'Tidak ada log untuk disalin';

  @override
  String copiedLogs(Object count) {
    return '$count entri log disalin ke clipboard';
  }

  @override
  String get debugEnabled => 'Log debug diaktifkan';

  @override
  String get debugDisabled => 'Log debug dinonaktifkan';

  @override
  String get howToUseTitle => 'Cara menggunakan NetherLink';

  @override
  String get iUnderstand => 'Saya mengerti';

  @override
  String get playOnSwitchTitle => 'Main di Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Main dengan Teman';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Dipilih: $relayName\n\nCara terhubung:\n1. Buka Pengaturan Switch Anda dan ubah DNS menjadi: $relayIp\n2. Buka Minecraft dan pilih server dari daftar (seperti Cubecraft atau Hive).\n3. Sekarang Anda akan otomatis dikirim ke server Anda sendiri.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Cara terhubung:\n1. Di konsol Anda, tambahkan $friend sebagai teman.\n2. Buka Minecraft dan masuk ke tab Friends.\n3. Cari server Anda di LAN Worlds lalu pilih untuk bergabung.';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'Pilih relay $name';
  }

  @override
  String get noSavedServers => 'Tidak ada server tersimpan';

  @override
  String get savedServers => 'Server tersimpan';

  @override
  String get serverAddressHint => 'Alamat Server';

  @override
  String get portHint => 'Port';

  @override
  String get manageServers => 'Kelola server';

  @override
  String get manageServersTooltip => 'Kelola server';

  @override
  String get stopBroadcasting => 'Hentikan Siaran';

  @override
  String get startNintendoMode => 'Mulai Mode Nintendo';

  @override
  String get startFriendsMode => 'Mulai Mode Teman';

  @override
  String get startBroadcasting => 'Mulai Siaran';

  @override
  String get modeLabel => 'Mode';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Teman';

  @override
  String get nintendoInfoTitle => 'Mode DNS Nintendo Switch';

  @override
  String get nintendoInfoText => 'Mulai dalam mode Nintendo, atur DNS Anda, dan gabung ke server unggulan.';

  @override
  String get friendModeTitle => 'Mode Teman';

  @override
  String get friendModeText => 'Tambahkan bot teman NetherLink sebagai teman. Mulai mode Teman dan bermain';

  @override
  String get selectedRelayCheck => 'Dipilih';

  @override
  String relayFallbackWarning(Object name) {
    return 'Peringatan: relay asli tidak merespons. Relay cadangan yang digunakan: $name';
  }

  @override
  String get relayUnableConnect => 'Tidak dapat terhubung ke server relay NetherLink mana pun. Coba lagi nanti atau periksa internet Anda.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Main melalui siaran LAN atau proxy';

  @override
  String get howToXboxBody => 'Cara terhubung (Xbox / PS4 / PS5):\n1. Pastikan perangkat yang menjalankan NetherLink dan konsol Anda berada di jaringan lokal yang sama.\n2. Di aplikasi, masukkan alamat dan port server Minecraft Anda lalu tekan "Mulai Siaran".\n3. Di konsol, buka Minecraft → Play → cari LAN Worlds atau tab Friends lalu segarkan daftar.\n4. Pilih server LAN bernama "NetherLink" untuk bergabung.\nCatatan:\n- Jika server tidak muncul, pastikan kedua perangkat berada di subnet yang sama dan aplikasi masih menyiarkan.\n- Beberapa model konsol atau router dapat memblokir penemuan LAN; coba ubah pengaturan aplikasi atau router jika perlu.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (mode DNS)';

  @override
  String get howToNintendoSubtitle => 'Petunjuk relay DNS untuk Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — mode DNS (langkah demi langkah):\n1. Di aplikasi, aktifkan mode "Nintendo" dan pilih Server Relay (EU atau US).\n2. Ketuk "Send DNS Config" untuk mengirim IP DNS ke relay.\n3. Di Nintendo Switch Anda buka System Settings → Internet → Internet Settings → (jaringan Anda) → Change Settings → DNS lalu atur Primary DNS ke IP relay.\n4. Buka Minecraft dan gabung ke server publik; Anda akan diarahkan ke server Anda menggunakan DNS relay.\nCatatan:\n- Mode DNS tidak menyiarkan server LAN; mode ini mengarahkan lalu lintas game melalui relay.\n- Kembalikan DNS Anda setelah selesai jika Anda memerlukan perilaku jaringan normal.';

  @override
  String get howToFriendsTitle => 'Mode Teman';

  @override
  String get howToFriendsSubtitle => 'Undang teman dan gabung melalui LAN';

  @override
  String get howToFriendsBody => 'Mode Teman — langkah cepat:\n1. Tambahkan akun teman NetherLink di konsol atau platform Anda jika diperlukan.\n2. Di aplikasi, aktifkan mode Teman dan kirim konfigurasi relay (jika berlaku).\n3. Di konsol, buka Minecraft → Friends dan cari LAN Worlds — server Anda seharusnya muncul di sana sebagai dunia LAN.\n4. Pilih server tersebut untuk bergabung ke server Anda bersama teman.\nCatatan:\n- Pastikan Anda dan teman Anda memiliki NAT/pengaturan yang sama yang memungkinkan kehadiran teman.\n- Mode Teman bergantung pada fitur pertemanan platform dan mungkin memerlukan penerimaan permintaan pertemanan.';

  @override
  String get helpNetherlinkTitle => 'NetherLink tidak muncul';

  @override
  String get helpNetherlinkSubtitle => 'Pemecahan masalah penemuan LAN';

  @override
  String get helpNetherlinkBody => 'Jika server tidak muncul di konsol Anda, coba langkah-langkah berikut:\n\n✅ Pemeriksaan Dasar:\n1. Jaringan WiFi yang Sama - Ponsel/tablet dan konsol Anda HARUS berada di WiFi yang sama\n2. Alamat Server yang Benar - Periksa kembali IP dan port (default: 19132)\n3. Siaran Aktif - Pastikan NetherLink menampilkan status "Menyiarkan"\n\n🔄 Perbaikan Cepat:\n• Mulai ulang aplikasi: hentikan siaran, tutup NetherLink sepenuhnya, buka lagi, lalu coba kembali\n• Mulai ulang konsol Anda: terkadang konsol perlu disegarkan untuk mendeteksi game LAN\n• Periksa tab Friends/LAN: server muncul di bawah "Friends" atau "LAN Games", BUKAN di daftar server\n• Tunggu 10-15 detik setelah memulai siaran\n• Nonaktifkan VPN: VPN dapat memblokir siaran lokal\n\n⚠️ Masalah Umum:\n"No route found for user" → Pastikan kedua perangkat berada di Wi‑Fi yang sama (hindari jaringan tamu)\n"Unable to connect to NetherLink relay server" → Periksa internet / status relay Anda\n\n📱 Masih bermasalah? Aktifkan Mode Debug di NetherLink dan periksa log, atau coba server lain.';

  @override
  String get helpMultiplayerFailedTitle => 'Koneksi Multiplayer Gagal';

  @override
  String get helpMultiplayerFailedSubtitle => 'Penjelasan mengapa ini bukan kesalahan NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Ini bukan masalah pada NetherLink!\n\nNetherLink berhasil mengarahkan Anda ke server yang diminta. Pesan "Multiplayer Connection Failed" menunjukkan bahwa server tujuan saat ini tidak dapat dijangkau. Kemungkinan alasan:\n\n• Server Minecraft tujuan sedang offline atau kelebihan beban\n• Server memerlukan versi klien yang diperbarui atau edisi tertentu\n• Masalah jaringan antara relay dan server tujuan\n\nCoba hubungkan ke server lain atau hubungi dukungan server tersebut. Jika masalah tetap terjadi pada beberapa server, aktifkan Mode Debug di NetherLink dan periksa log.';

  @override
  String get helpNintendoDnsTitle => 'DNS Nintendo tidak berfungsi';

  @override
  String get helpNintendoDnsSubtitle => 'Masalah DNS / relay umum';

  @override
  String get helpNintendoDnsBody => 'Jika mode DNS Nintendo tidak berfungsi, periksa hal berikut:\n\n1. Pastikan Anda mengirim konfigurasi DNS dari aplikasi (Send DNS Config).\n2. Pastikan Anda menerapkan IP relay sebagai DNS Utama di Switch.\n3. Pastikan server relay yang dipilih (EU/US) sedang online dan tidak kelebihan beban.\n4. Beberapa jaringan (misalnya captive portal) mencegah DNS kustom — uji di jaringan lain.\n\nJika masalah berlanjut, aktifkan Mode Debug dan periksa log atau coba alternatif mode Teman.';

  @override
  String get helpFriendsModeTitle => 'Mode Teman tidak berfungsi';

  @override
  String get helpFriendsModeSubtitle => 'Masalah pertemanan umum';

  @override
  String get helpFriendsModeBody => 'Tips pemecahan masalah mode Teman:\n\n1. Pastikan akun teman relay sudah ditambahkan/diterima di konsol (jika diperlukan).\n2. Coba mulai ulang game dan segarkan tab Friends/LAN setelah mengaktifkan mode Teman.\n\nJika server masih tidak muncul untuk teman, aktifkan Mode Debug dan periksa log untuk mengidentifikasi kesalahan.';

  @override
  String get changeLanguageTitle => 'Ganti bahasa';

  @override
  String get changeLanguage => 'Bahasa';

  @override
  String get useSystemLanguage => 'Gunakan bahasa sistem';

  @override
  String get couldNotOpenUrl => 'Tidak dapat membuka URL';
}
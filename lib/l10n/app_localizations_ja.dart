// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'コンソール';

  @override
  String get consoleOutput => 'コンソール出力';

  @override
  String get noLogsYet => 'まだログはありません';

  @override
  String get startBroadcastingToSeeOutput => '出力を見るにはブロードキャストを開始してください';

  @override
  String get close => '閉じる';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => '参加する';

  @override
  String get more => 'More';

  @override
  String get website => 'ウェブサイト';

  @override
  String get howToUseMenu => '使い方';

  @override
  String get support => 'サポート';

  @override
  String helpText(Object appCreator) {
    return '$appCreator によって作成されました。\r\n\r\n使い方:\r\n1. Minecraft サーバーのアドレスとポートを入力します（デフォルト: 19132）\r\n   — またはドロップダウンから以前保存したサーバーを選択します\r\n2. （任意）現在地に最も近い Relay Server（EU または US）を選択します\r\n3. \"ブロードキャスト開始\" をクリックして開始します\r\n4. コンソール/デバイスで: Minecraft > Play > Friends\r\n5. \"NetherLink\" という名前の LAN サーバーが表示されます\r\n6. それをクリックすると、NetherLink 経由で外部サーバーに参加できます\r\n\r\nNintendo Switch（DNS モード）:\r\n1. 接続パネルで \"Nintendo Switch\" を有効にします\r\n2. Relay Server（EU または US）を選択します\r\n3. \"Send DNS Config\" をクリックすると、設定が relay に送信されます\r\n   （これは LAN サーバーをブロードキャストしません）\r\n4. Switch で NetherLink の DNS 設定を適用し、\r\n   NetherLink 用に使っているサーバー項目から参加します\r\n\r\nメモ:\r\n- LAN ブロードキャストでは、NetherLink とコンソールが同じローカルネットワーク上にある必要があります。\r\n- ヒント: 最良のパフォーマンスを得るには、最も近い relay サーバーを選択してください。';
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
  String get language => '日本語';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'デバッグを切り替える';

  @override
  String get copyLogs => 'ログをコピー';

  @override
  String get clear => 'クリア';

  @override
  String get cancel => 'キャンセル';

  @override
  String get deleteServer => 'サーバーを削除';

  @override
  String get delete => '削除';

  @override
  String get myServers => 'マイサーバー';

  @override
  String get quickAccessServers => 'クイックアクセスサーバー';

  @override
  String get addServer => 'サーバーを追加';

  @override
  String get addServersHint => '後ですばやく接続できるようにサーバーを追加します';

  @override
  String get serverNameLabel => 'サーバー名 *';

  @override
  String get addressLabel => 'アドレス *';

  @override
  String get portLabel => 'ポート *';

  @override
  String get descriptionLabel => '説明（任意）';

  @override
  String get save => '保存';

  @override
  String get initializing => '初期化中...';

  @override
  String get createdBy => 'NetherDev によって作成';

  @override
  String get bedrockBridge => 'Bedrock Bridge';

  @override
  String get clientDisconnected => 'クライアントが切断されました — ブロードキャストを停止しました';

  @override
  String get pleaseEnterServer => '⚠️ サーバーアドレスを入力してください';

  @override
  String get invalidPort => '⚠️ 無効なポート番号です（1-65535）';

  @override
  String get dnsConfigSent => '✅ DNS 設定を relay に送信しました';

  @override
  String get broadcastingStarted => 'ブロードキャストを開始しました';

  @override
  String get broadcastStopped => 'ブロードキャストを停止しました';

  @override
  String selectedServer(Object name) {
    return '📋 選択中: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return '選択中: $name';
  }

  @override
  String get noLogsToCopy => 'コピーするログがありません';

  @override
  String copiedLogs(Object count) {
    return '$count 件のログをクリップボードにコピーしました';
  }

  @override
  String get debugEnabled => 'デバッグログを有効にしました';

  @override
  String get debugDisabled => 'デバッグログを無効にしました';

  @override
  String get howToUseTitle => 'NetherLink の使い方';

  @override
  String get iUnderstand => '理解しました';

  @override
  String get playOnSwitchTitle => 'Nintendo Switch で遊ぶ';

  @override
  String get playWithFriendsTitle => '友達と遊ぶ';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return '選択中: $relayName\r\n\r\n接続方法:\r\n1. Switch の設定を開き、DNS を次に変更します: $relayIp\r\n2. Minecraft を開き、リストからサーバーを選択します（Cubecraft や Hive など）。\r\n3. これで自動的に自分のサーバーへ送られます。';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return '接続方法:\r\n1. コンソールで $friend をフレンドとして追加します。\r\n2. Minecraft を開き、Friends タブに移動します。\r\n3. LAN Worlds の下にある自分のサーバーを探し、選択して参加します。';
  }

  @override
  String get nldServerLabel => 'NETHERLINK SERVER';

  @override
  String selectRelayLabel(Object name) {
    return 'relay を選択 $name';
  }

  @override
  String get noSavedServers => '保存されたサーバーはありません';

  @override
  String get savedServers => '保存されたサーバー';

  @override
  String get serverAddressHint => 'サーバーアドレス';

  @override
  String get portHint => 'ポート';

  @override
  String get manageServers => 'サーバーを管理';

  @override
  String get manageServersTooltip => 'サーバーを管理';

  @override
  String get stopBroadcasting => 'ブロードキャスト停止';

  @override
  String get startNintendoMode => 'Nintendo モード開始';

  @override
  String get startFriendsMode => 'Friends モード開始';

  @override
  String get startBroadcasting => 'ブロードキャスト開始';

  @override
  String get modeLabel => 'モード';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => '友達';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS モード';

  @override
  String get nintendoInfoText => 'Nintendo モードで開始し、DNS を設定して注目サーバーに参加します。';

  @override
  String get friendModeTitle => 'フレンドモード';

  @override
  String get friendModeText => 'NetherLink のフレンド bot をフレンドとして追加します。Friends モードを開始して遊びましょう';

  @override
  String get selectedRelayCheck => '選択済み';

  @override
  String relayFallbackWarning(Object name) {
    return '警告: 元の relay が応答しませんでした。代替 relay を使用中です: $name';
  }

  @override
  String get relayUnableConnect => 'どの NetherLink relay サーバーにも接続できません。後でもう一度試すか、インターネット接続を確認してください。';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'LAN ブロードキャストまたは proxy 経由でプレイ';

  @override
  String get howToXboxBody => '接続方法（Xbox / PS4 / PS5）:\r\n1. NetherLink を実行しているデバイスとコンソールが同じローカルネットワーク上にあることを確認してください。\r\n2. アプリで Minecraft サーバーのアドレスとポートを入力し、\"ブロードキャスト開始\" を押します。\r\n3. コンソールで Minecraft → Play を開き、LAN Worlds または Friends タブを探してリストを更新します。\r\n4. \"NetherLink\" という名前の LAN サーバーを選択して参加します。\r\nメモ:\r\n- サーバーが表示されない場合は、両方のデバイスが同じサブネット上にあり、アプリがまだブロードキャスト中であることを確認してください。\r\n- 一部のコンソールやルーターでは LAN 検出がブロックされる場合があります。必要に応じてアプリやルーターの設定を切り替えてみてください。';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (DNS モード)';

  @override
  String get howToNintendoSubtitle => 'Switch 用 DNS relay 手順';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS モード（手順）:\r\n1. アプリで \"Nintendo\" モードを有効にし、Relay Server（EU または US）を選択します。\r\n2. \"Send DNS Config\" をタップして DNS IP を relay に送信します。\r\n3. Nintendo Switch で System Settings → Internet → Internet Settings → （使用中のネットワーク）→ Change Settings → DNS に進み、Primary DNS を relay IP に設定します。\r\n4. Minecraft を開いて公開サーバーに参加すると、relay DNS を使って自分のサーバーへリダイレクトされます。\r\nメモ:\r\n- DNS モードは LAN サーバーをブロードキャストせず、ゲーム通信を relay 経由でルーティングします。\r\n- 通常のネットワーク動作が必要な場合は、完了後に DNS を元に戻してください。';

  @override
  String get howToFriendsTitle => 'Friends モード';

  @override
  String get howToFriendsSubtitle => '友達を招待して LAN 経由で参加';

  @override
  String get howToFriendsBody => 'フレンドモード — 簡単な手順:\r\n1. 必要に応じて、コンソールまたはプラットフォームで NetherLink のフレンドアカウントを追加します。\r\n2. アプリでフレンドモードを有効にし、relay 設定を送信します（該当する場合）。\r\n3. コンソールで Minecraft → Friends を開き、LAN Worlds を探します。そこに LAN ワールドとして自分のサーバーが表示されるはずです。\r\n4. それを選択して、友達と一緒に自分のサーバーへ参加します。\r\nメモ:\r\n- 自分と友達の両方が、フレンド表示を許可する同じ NAT/設定になっていることを確認してください。\r\n- フレンドモードはプラットフォームのフレンド機能に依存し、フレンド申請の承認が必要な場合があります。';

  @override
  String get helpNetherlinkTitle => 'NetherLink が表示されない';

  @override
  String get helpNetherlinkSubtitle => 'LAN 検出の問題をトラブルシューティング';

  @override
  String get helpNetherlinkBody => 'コンソールにサーバーが表示されない場合は、次の手順を試してください:\r\n\r\n✅ 基本チェック:\r\n1. 同じ WiFi ネットワーク - スマホ/タブレットとコンソールは必ず同じ WiFi 上にある必要があります\r\n2. 正しいサーバーアドレス - IP とポート（デフォルト: 19132）を再確認してください\r\n3. ブロードキャストが有効 - NetherLink に \"ブロードキャスト中\" ステータスが表示されていることを確認してください\r\n\r\n🔄 すぐできる対処:\r\n• アプリを再起動: ブロードキャストを停止し、NetherLink を完全に閉じてから再度開いて試してください\r\n• コンソールを再起動: LAN ゲームを検出するには、コンソールの更新が必要なことがあります\r\n• Friends/LAN タブを確認: サーバーはサーバー一覧ではなく、\"Friends\" または \"LAN Games\" の下に表示されます\r\n• ブロードキャスト開始後 10〜15 秒待つ\r\n• VPN を無効化: VPN はローカルブロードキャストを妨げることがあります\r\n\r\n⚠️ よくある問題:\r\n\"No route found for user\" → 両方のデバイスが同じ Wi‑Fi 上にあることを確認してください（ゲストネットワークは避けてください）\r\n\"Unable to connect to NetherLink relay server\" → インターネット接続 / relay の状態を確認してください\r\n\r\n📱 まだ問題がありますか？ NetherLink でデバッグモードを有効にしてログを確認するか、別のサーバーを試してください。';

  @override
  String get helpMultiplayerFailedTitle => 'マルチプレイヤー接続に失敗しました';

  @override
  String get helpMultiplayerFailedSubtitle => 'これが NetherLink のエラーではない理由';

  @override
  String get helpMultiplayerFailedBody => '⚠️ これは NetherLink の問題ではありません！\r\n\r\nNetherLink は正常に要求されたサーバーへリダイレクトしました。\"Multiplayer Connection Failed\" というメッセージは、対象サーバーに現在到達できないことを示しています。考えられる理由:\r\n\r\n• 対象の Minecraft サーバーがオフライン、または過負荷状態である\r\n• サーバーが更新されたクライアントバージョン、または特定のエディションを要求している\r\n• relay と対象サーバーの間にネットワークの問題がある\r\n\r\n別のサーバーに接続するか、そのサーバーのサポートに連絡してください。複数のサーバーで問題が続く場合は、NetherLink でデバッグモードを有効にしてログを確認してください。';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS が動作しない';

  @override
  String get helpNintendoDnsSubtitle => 'よくある DNS / relay の問題';

  @override
  String get helpNintendoDnsBody => 'Nintendo DNS モードが動作しない場合は、次を確認してください:\r\n\r\n1. アプリから DNS 設定を送信したことを確認します（Send DNS Config）。\r\n2. Switch に relay IP をプライマリ DNS として適用したことを確認します。\r\n3. 選択した relay サーバー（EU/US）がオンラインで、過負荷でないことを確認します。\r\n4. 一部のネットワーク（例: captive portal）はカスタム DNS を妨げます。別のネットワークで試してください。\r\n\r\n問題が続く場合は、デバッグモードを有効にしてログを確認するか、フレンドモードの代替手段を試してください。';

  @override
  String get helpFriendsModeTitle => 'Friends モードが動作しない';

  @override
  String get helpFriendsModeSubtitle => 'よくあるフレンド関連の問題';

  @override
  String get helpFriendsModeBody => 'フレンドモードのトラブルシューティング:\r\n\r\n1. relay フレンドアカウントがコンソールで追加/承認されていることを確認してください（必要な場合）。\r\n2. フレンドモードを有効にしたあと、ゲームを再起動して Friends/LAN タブを更新してみてください。\r\n\r\nそれでもサーバーが友達に表示されない場合は、デバッグモードを有効にしてログを確認し、エラーを特定してください。';

  @override
  String get changeLanguageTitle => '言語を変更';

  @override
  String get changeLanguage => '言語';

  @override
  String get useSystemLanguage => 'システム言語を使用';

  @override
  String get couldNotOpenUrl => 'URL を開けませんでした';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => '控制台';

  @override
  String get consoleOutput => '控制台输出';

  @override
  String get noLogsYet => '暂无日志';

  @override
  String get startBroadcastingToSeeOutput => '开始广播以查看输出';

  @override
  String get close => '关闭';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => '加入我们';

  @override
  String get website => '网站';

  @override
  String get howToUseMenu => '使用方法';

  @override
  String get support => '支持';

  @override
  String helpText(Object appCreator) {
    return '由 $appCreator 创建。\n\n使用方法：\n1. 输入你的 Minecraft 服务器地址和端口（默认：19132）\n   — 或从下拉菜单中选择之前保存的服务器\n2. （可选）选择离你位置最近的中继服务器（EU 或 US）\n3. 点击 \"开始广播\" 以开始\n4. 在你的主机/设备上：Minecraft > 游玩 > 好友\n5. 你应该会看到一个名为 \"NetherLink\" 的局域网服务器\n6. 点击它即可通过 NetherLink 加入你的外部服务器\n\nNintendo Switch（DNS 模式）：\n1. 在连接面板中启用 \"Nintendo Switch\"\n2. 选择一个中继服务器（EU 或 US）\n3. 点击 \"发送 DNS 配置\" — 这会将你的配置发送到中继服务器\n   （它不会广播局域网服务器）\n4. 在你的 Switch 上应用 NetherLink DNS 设置并加入\n   使用你为 NetherLink 所使用的服务器条目\n\n注意：\n- 进行局域网广播时，NetherLink 和主机必须位于同一局域网中。\n- 提示：选择离你最近的中继服务器以获得最佳性能。';
  }

  @override
  String get language => '简体中文';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => '切换调试';

  @override
  String get copyLogs => '复制日志';

  @override
  String get clear => '清除';

  @override
  String get cancel => '取消';

  @override
  String get deleteServer => '删除服务器';

  @override
  String get delete => '删除';

  @override
  String get myServers => '我的服务器';

  @override
  String get quickAccessServers => '快速访问服务器';

  @override
  String get addServer => '添加服务器';

  @override
  String get addServersHint => '添加服务器以便稍后快速连接';

  @override
  String get serverNameLabel => '服务器名称 *';

  @override
  String get addressLabel => '地址 *';

  @override
  String get portLabel => '端口 *';

  @override
  String get descriptionLabel => '描述（可选）';

  @override
  String get save => '保存';

  @override
  String get initializing => '正在初始化...';

  @override
  String get createdBy => '由 NetherDev 创建';

  @override
  String get bedrockBridge => '基岩桥';

  @override
  String get clientDisconnected => '客户端已断开连接 — 广播已停止';

  @override
  String get pleaseEnterServer => '⚠️ 请输入服务器地址';

  @override
  String get invalidPort => '⚠️ 无效的端口号（1-65535）';

  @override
  String get dnsConfigSent => '✅ DNS 配置已发送到中继服务器';

  @override
  String get broadcastingStarted => '广播已开始';

  @override
  String get broadcastStopped => '广播已停止';

  @override
  String selectedServer(Object name) {
    return '📋 已选择：$name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return '已选择：$name';
  }

  @override
  String get noLogsToCopy => '没有可复制的日志';

  @override
  String copiedLogs(Object count) {
    return '已将 $count 条日志复制到剪贴板';
  }

  @override
  String get debugEnabled => '调试日志已启用';

  @override
  String get debugDisabled => '调试日志已禁用';

  @override
  String get howToUseTitle => '如何使用 NetherLink';

  @override
  String get iUnderstand => '我明白了';

  @override
  String get playOnSwitchTitle => '在 Nintendo Switch 上游玩';

  @override
  String get playWithFriendsTitle => '与朋友一起游玩';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return '已选择：$relayName\n\n连接方法：\n1. 前往你的 Switch 设置，将 DNS 更改为：$relayIp\n2. 打开 Minecraft，并从列表中选择一个服务器（例如 Cubecraft 或 Hive）。\n3. 现在你将自动被发送到你自己的服务器。';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return '连接方法：\n1. 在你的主机上，将 $friend 添加为好友。\n2. 打开 Minecraft 并前往 Friends 标签页。\n3. 在 LAN Worlds 下找到你的服务器并选择加入。';
  }

  @override
  String get nldServerLabel => 'NETHERLINK 服务器';

  @override
  String selectRelayLabel(Object name) {
    return '选择中继服务器 $name';
  }

  @override
  String get noSavedServers => '没有已保存的服务器';

  @override
  String get savedServers => '已保存的服务器';

  @override
  String get serverAddressHint => '服务器地址';

  @override
  String get portHint => '端口';

  @override
  String get manageServers => '管理服务器';

  @override
  String get manageServersTooltip => '管理服务器';

  @override
  String get stopBroadcasting => '停止广播';

  @override
  String get startNintendoMode => '启动 Nintendo 模式';

  @override
  String get startFriendsMode => '启动好友模式';

  @override
  String get startBroadcasting => '开始广播';

  @override
  String get modeLabel => '模式';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => '好友';

  @override
  String get nintendoInfoTitle => 'Nintendo Switch DNS 模式';

  @override
  String get nintendoInfoText => '在 Nintendo 模式下开始，设置你的 DNS 并加入推荐服务器。';

  @override
  String get friendModeTitle => '好友模式';

  @override
  String get friendModeText => '将 NetherLink 的好友机器人添加为好友。启动好友模式并开始游玩';

  @override
  String get selectedRelayCheck => '已选择';

  @override
  String relayFallbackWarning(Object name) {
    return '警告：原始 Relay 未响应。正在使用备用 Relay：$name';
  }

  @override
  String get relayUnableConnect => '无法连接到任何 NetherLink Relay 服务器。请稍后再试或检查你的网络连接。';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => '通过局域网广播或代理游玩';

  @override
  String get howToXboxBody => '连接方法（Xbox / PS4 / PS5）：\n1. 确保运行 NetherLink 的设备和你的主机位于同一本地网络中。\n2. 在应用中输入你的 Minecraft 服务器地址和端口，然后按下 \"开始广播\"。\n3. 在主机上打开 Minecraft → Play → 查找 LAN Worlds 或 Friends 标签页，并刷新列表。\n4. 选择名为 \"NetherLink\" 的局域网服务器以加入。\n注意：\n- 如果服务器没有出现，请确认两台设备位于同一子网，并且应用仍在广播。\n- 某些主机型号或路由器可能会阻止局域网发现；如有需要，请尝试切换应用或路由器设置。';

  @override
  String get howToNintendoTitle => 'Nintendo Switch（DNS 模式）';

  @override
  String get howToNintendoSubtitle => '适用于 Switch 的 DNS 中继说明';

  @override
  String get howToNintendoBody => 'Nintendo Switch — DNS 模式（分步说明）：\n1. 在应用中启用 \"Nintendo\" 模式，并选择一个中继服务器（EU 或 US）。\n2. 点击 \"发送 DNS 配置\"，将 DNS IP 发送到中继服务器。\n3. 在你的 Nintendo Switch 上前往系统设置 → 网络 → 互联网设置 → （你的网络）→ 更改设置 → DNS，并将主 DNS 设置为中继服务器 IP。\n4. 打开 Minecraft 并加入一个公共服务器；你将通过中继 DNS 被重定向到你的服务器。\n注意：\n- DNS 模式不会广播局域网服务器；它会通过中继服务器路由游戏流量。\n- 使用结束后，如果你需要恢复正常网络行为，请将 DNS 改回原设置。';

  @override
  String get howToFriendsTitle => '好友模式';

  @override
  String get howToFriendsSubtitle => '邀请好友并通过局域网加入';

  @override
  String get howToFriendsBody => '好友模式 — 快速步骤：\n1. 如有需要，请在你的主机或平台上添加 NetherLink 好友账号（Relay 好友）。\n2. 在应用中启用好友模式并发送 Relay 配置（如果适用）。\n3. 在你的主机上打开 Minecraft → Friends，并搜索 LAN Worlds —— 你的服务器应当会显示为一个局域网世界。\n4. 选择它即可与你的好友一起加入服务器。\n注意：\n- 请确保你和你的好友拥有相同且允许好友在线显示的 NAT/设置。\n- 好友模式依赖平台的好友功能，可能需要接受好友请求。';

  @override
  String get helpNetherlinkTitle => 'NetherLink 未显示';

  @override
  String get helpNetherlinkSubtitle => '局域网发现问题排查';

  @override
  String get helpNetherlinkBody => '如果服务器没有出现在你的主机上，请尝试以下步骤：\n\n✅ 基本检查：\n1. 相同的 WiFi 网络 - 你的手机/平板和主机必须连接到同一个 WiFi\n2. 正确的服务器地址 - 再次检查 IP 和端口（默认：19132）\n3. 广播已激活 - 确认 NetherLink 显示 \"正在广播\" 状态\n\n🔄 快速修复：\n• 重启应用：停止广播，完全关闭 NetherLink，重新打开后再试一次\n• 重启主机：有时主机需要刷新才能检测到局域网游戏\n• 检查好友/LAN 标签页：服务器会显示在 \"好友\" 或 \"局域网游戏\" 下，而不是服务器列表中\n• 开始广播后等待 10-15 秒\n• 禁用 VPN：VPN 可能会阻止本地广播\n\n⚠️ 常见问题：\n\"No route found for user\" → 确保两台设备位于同一个 Wi‑Fi（避免使用访客网络）\n\"Unable to connect to NetherLink relay server\" → 检查你的网络 / 中继服务器状态\n\n📱 仍然有问题？请在 NetherLink 中启用调试模式并检查日志，或尝试其他服务器。';

  @override
  String get helpMultiplayerFailedTitle => '多人连接失败';

  @override
  String get helpMultiplayerFailedSubtitle => '说明这为什么不是 NetherLink 错误';

  @override
  String get helpMultiplayerFailedBody => '⚠️ 这不是 NetherLink 的问题！\n\nNetherLink 已成功将你重定向到请求的服务器。\"多人连接失败\" 这条消息表示目标服务器当前无法访问。可能原因包括：\n\n• 目标 Minecraft 服务器离线或负载过高\n• 服务器需要更新的客户端版本或特定版本\n• Relay 与目标服务器之间存在网络问题\n\n请尝试连接到其他服务器，或联系该服务器的支持团队。如果多个服务器都出现此问题，请在 NetherLink 中启用调试模式并检查日志。';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS 无法工作';

  @override
  String get helpNintendoDnsSubtitle => '常见 DNS / Relay 问题';

  @override
  String get helpNintendoDnsBody => '如果 Nintendo DNS 模式无法工作，请检查以下内容：\n\n1. 确认你已从应用中发送 DNS 配置（发送 DNS 配置）。\n2. 确认你已在 Switch 上将 Relay IP 设置为主 DNS。\n3. 确保所选的 Relay 服务器（EU/US）在线且未过载。\n4. 某些网络（例如强制门户网络）会阻止自定义 DNS —— 请在其他网络上测试。\n\n如果问题仍然存在，请启用调试模式并检查日志，或尝试好友模式这一替代方案。';

  @override
  String get helpFriendsModeTitle => '好友模式无法工作';

  @override
  String get helpFriendsModeSubtitle => '常见好友问题';

  @override
  String get helpFriendsModeBody => '好友模式故障排除提示：\n\n1. 确保 Relay 好友账号已在主机上添加/接受（如有需要）。\n2. 启用好友模式后，尝试重新启动游戏并刷新 Friends/LAN 标签页。\n\n如果服务器仍未显示给好友，请启用调试模式并检查日志以识别错误。';

  @override
  String get changeLanguageTitle => '更改语言';

  @override
  String get changeLanguage => '语言';

  @override
  String get useSystemLanguage => '使用系统语言';

  @override
  String get couldNotOpenUrl => '无法打开 URL';
}

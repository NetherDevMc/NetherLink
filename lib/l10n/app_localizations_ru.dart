// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Консоль';

  @override
  String get consoleOutput => 'Вывод консоли';

  @override
  String get noLogsYet => 'Пока нет журналов';

  @override
  String get startBroadcastingToSeeOutput => 'Начните трансляцию, чтобы увидеть вывод';

  @override
  String get close => 'Закрыть';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Присоединяйтесь';

  @override
  String get more => 'More';

  @override
  String get website => 'Сайт';

  @override
  String get howToUseMenu => 'Как использовать';

  @override
  String get support => 'Поддержка';

  @override
  String helpText(Object appCreator) {
    return 'Создано $appCreator.\r\n\r\nКак использовать:\r\n1. Введите адрес и порт вашего сервера Minecraft (по умолчанию: 19132)\r\n   — или выберите ранее сохраненный сервер из выпадающего списка\r\n2. (Необязательно) Выберите relay-сервер (EU или US), ближайший к вашему местоположению\r\n3. Нажмите \\\"Начать трансляцию\\\", чтобы начать\r\n4. На вашей консоли/устройстве: Minecraft > Играть > Друзья\r\n5. Вы должны увидеть LAN-сервер с названием \\\"NetherLink\\\"\r\n6. Нажмите на него, чтобы подключиться к вашему внешнему серверу через NetherLink\r\n\r\nNintendo Switch (режим DNS):\r\n1. Включите \\\"Nintendo Switch\\\" в панели подключения\r\n2. Выберите relay-сервер (EU или US)\r\n3. Нажмите \\\"Отправить конфигурацию DNS\\\" — это отправит вашу конфигурацию на relay\r\n   (это НЕ транслирует LAN-сервер)\r\n4. На вашей Switch примените настройки DNS NetherLink и подключитесь\r\n   используя запись сервера, которую вы используете для NetherLink\r\n\r\nПримечания:\r\n- Для LAN-трансляции NetherLink и консоль должны находиться в одной локальной сети.\r\n- Совет: выберите relay-сервер, который ближе всего к вам, для лучшей производительности.';
  }

  @override
  String get serverDetailsLabel => 'Данные сервера';

  @override
  String get start => 'Начать';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Запустить режим Java';

  @override
  String get javaInfoTitle => 'Режим Java';

  @override
  String get javaInfoText => 'Подключайтесь к серверам Java Edition';

  @override
  String get howToJavaTitle => 'Режим Java';

  @override
  String get howToJavaSubtitle => 'Подключайтесь к серверам Java Edition через NetherLink';

  @override
  String get howToJavaBody => 'Режим Java — быстрые шаги:\r\n1. В приложении выберите режим Java.\r\n2. Введите адрес и порт вашего сервера Java Edition (по умолчанию: 25565).\r\n3. Нажмите \"Запустить режим Java\" — NetherLink свяжет подключение.\r\n4. Откройте Minecraft Bedrock и перейдите на вкладку Friends.\r\n5. Выберите LAN-сервер с именем \"NetherLink\", чтобы подключиться к Java-серверу.\r\n\r\n⚠️ Важные предупреждения:\r\n- Требуется действующая учетная запись Java Edition (Microsoft).\r\n- Некоторые серверы используют античит-системы, которые могут обнаружить и заблокировать вашу учетную запись.\r\n- Некоторые серверы прямо запрещают клиентов Bedrock — всегда проверяйте правила сервера.\r\n- NetherLink не несет ответственности за блокировки, приостановки или другие проблемы с учетной записью, которые могут возникнуть при использовании этой функции.\r\n- Используйте на свой страх и риск.';

  @override
  String get language => 'Русский';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Переключить отладку';

  @override
  String get copyLogs => 'Копировать журналы';

  @override
  String get clear => 'Очистить';

  @override
  String get cancel => 'Отмена';

  @override
  String get deleteServer => 'Удалить сервер';

  @override
  String get delete => 'Удалить';

  @override
  String get myServers => 'Мои серверы';

  @override
  String get quickAccessServers => 'Серверы быстрого доступа';

  @override
  String get addServer => 'Добавить сервер';

  @override
  String get addServersHint => 'Добавьте серверы для быстрого подключения позже';

  @override
  String get serverNameLabel => 'Имя сервера *';

  @override
  String get addressLabel => 'Адрес *';

  @override
  String get portLabel => 'Порт *';

  @override
  String get descriptionLabel => 'Описание (необязательно)';

  @override
  String get save => 'Сохранить';

  @override
  String get initializing => 'Инициализация...';

  @override
  String get createdBy => 'Создано NetherDev';

  @override
  String get bedrockBridge => 'Мост Bedrock';

  @override
  String get clientDisconnected => 'Клиент отключен — трансляция остановлена';

  @override
  String get pleaseEnterServer => '⚠️ Пожалуйста, введите адрес сервера';

  @override
  String get invalidPort => '⚠️ Неверный номер порта (1-65535)';

  @override
  String get dnsConfigSent => '✅ Конфигурация DNS отправлена на relay-сервер';

  @override
  String get broadcastingStarted => 'Трансляция началась';

  @override
  String get broadcastStopped => 'Трансляция остановлена';

  @override
  String selectedServer(Object name) {
    return '📋 Выбрано: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Выбрано: $name';
  }

  @override
  String get noLogsToCopy => 'Нет журналов для копирования';

  @override
  String copiedLogs(Object count) {
    return 'Скопировано $count записей журнала в буфер обмена';
  }

  @override
  String get debugEnabled => 'Журналы отладки включены';

  @override
  String get debugDisabled => 'Журналы отладки отключены';

  @override
  String get howToUseTitle => 'Как использовать NetherLink';

  @override
  String get iUnderstand => 'Я понимаю';

  @override
  String get playOnSwitchTitle => 'Играть на Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Играть с друзьями';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Выбрано: $relayName\r\n\r\nКак подключиться:\r\n1. Перейдите в настройки вашей Switch и измените DNS на: $relayIp\r\n2. Откройте Minecraft и выберите сервер из списка (например, Cubecraft или Hive).\r\n3. Теперь вы будете автоматически отправлены на свой собственный сервер.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Как подключиться:\r\n1. На вашей консоли добавьте $friend в друзья.\r\n2. Откройте Minecraft и перейдите на вкладку Friends.\r\n3. Найдите ваш сервер в разделе LAN Worlds и выберите его для подключения.';
  }

  @override
  String get nldServerLabel => 'СЕРВЕР NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'Выбрать relay-сервер $name';
  }

  @override
  String get noSavedServers => 'Нет сохраненных серверов';

  @override
  String get savedServers => 'Сохраненные серверы';

  @override
  String get serverAddressHint => 'Адрес сервера';

  @override
  String get portHint => 'Порт';

  @override
  String get manageServers => 'Управление серверами';

  @override
  String get manageServersTooltip => 'Управление серверами';

  @override
  String get stopBroadcasting => 'Остановить трансляцию';

  @override
  String get startNintendoMode => 'Запустить режим Nintendo';

  @override
  String get startFriendsMode => 'Запустить режим друзей';

  @override
  String get startBroadcasting => 'Начать трансляцию';

  @override
  String get modeLabel => 'Режим';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Друзья';

  @override
  String get nintendoInfoTitle => 'Режим DNS Nintendo Switch';

  @override
  String get nintendoInfoText => 'Запуститесь в режиме Nintendo, настройте DNS и присоединитесь к избранному серверу.';

  @override
  String get friendModeTitle => 'Режим друзей';

  @override
  String get friendModeText => 'Добавьте friend bots NetherLink в друзья. Запустите режим друзей и играйте';

  @override
  String get selectedRelayCheck => 'Выбрано';

  @override
  String relayFallbackWarning(Object name) {
    return 'Предупреждение: исходный relay не ответил. Используется резервный relay: $name';
  }

  @override
  String get relayUnableConnect => 'Не удалось подключиться ни к одному relay-серверу NetherLink. Попробуйте позже или проверьте интернет.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / прокси)';

  @override
  String get howToXboxSubtitle => 'Играйте через LAN-трансляцию или прокси';

  @override
  String get howToXboxBody => 'Как подключиться (Xbox / PS4 / PS5):\r\n1. Убедитесь, что устройство с NetherLink и ваша консоль находятся в одной локальной сети.\r\n2. В приложении введите адрес и порт вашего сервера Minecraft и нажмите \\\"Начать трансляцию\\\".\r\n3. На консоли откройте Minecraft → Play → найдите LAN Worlds или вкладку Friends и обновите список.\r\n4. Выберите LAN-сервер с именем \\\"NetherLink\\\", чтобы подключиться.\r\nПримечания:\r\n- Если сервер не появляется, убедитесь, что оба устройства находятся в одной подсети и приложение все еще ведет трансляцию.\r\n- Некоторые модели консолей или роутеров могут блокировать обнаружение LAN; при необходимости попробуйте изменить настройки приложения или роутера.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (режим DNS)';

  @override
  String get howToNintendoSubtitle => 'Инструкции по DNS relay для Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — режим DNS (пошагово):\r\n1. В приложении включите режим \\\"Nintendo\\\" и выберите relay-сервер (EU или US).\r\n2. Нажмите \\\"Отправить конфигурацию DNS\\\", чтобы отправить DNS IP на relay.\r\n3. На вашей Nintendo Switch перейдите в настройки системы → интернет → настройки интернета → (ваша сеть) → изменить настройки → DNS и установите основной DNS на relay IP.\r\n4. Откройте Minecraft и присоединитесь к публичному серверу; вы будете перенаправлены на свой сервер с помощью relay DNS.\r\nПримечания:\r\n- Режим DNS не транслирует LAN-сервер; он направляет игровой трафик через relay.\r\n- Верните DNS обратно после завершения, если вам нужно обычное поведение сети.';

  @override
  String get howToFriendsTitle => 'Режим друзей';

  @override
  String get howToFriendsSubtitle => 'Приглашайте друзей и подключайтесь через LAN';

  @override
  String get howToFriendsBody => 'Режим друзей — быстрые шаги:\r\n1. При необходимости добавьте учетную запись друга NetherLink (relay friend) на вашей консоли или платформе.\r\n2. В приложении включите режим друзей и отправьте конфигурацию relay (если применимо).\r\n3. На вашей консоли откройте Minecraft → Friends и найдите LAN Worlds — ваш сервер должен появиться там как LAN-мир.\r\n4. Выберите его, чтобы присоединиться к вашему серверу вместе с друзьями.\r\nПримечания:\r\n- Убедитесь, что у вас и ваших друзей одинаковые NAT/settings, которые позволяют видеть друзей.\r\n- Режим друзей зависит от функций друзей платформы и может потребовать принятия запросов в друзья.';

  @override
  String get helpNetherlinkTitle => 'NetherLink не появляется';

  @override
  String get helpNetherlinkSubtitle => 'Устранение проблем с обнаружением LAN';

  @override
  String get helpNetherlinkBody => 'Если сервер не появляется на вашей консоли, попробуйте следующие шаги:\r\n\r\n✅ Базовые проверки:\r\n1. Одна и та же WiFi-сеть - Ваш телефон/планшет и консоль ДОЛЖНЫ быть в одной WiFi-сети\r\n2. Правильный адрес сервера - Еще раз проверьте IP и порт (по умолчанию: 19132)\r\n3. Трансляция активна - Убедитесь, что NetherLink показывает статус \\\"Broadcasting\\\"\r\n\r\n🔄 Быстрые исправления:\r\n• Перезапустите приложение: остановите трансляцию, полностью закройте NetherLink, снова откройте его и попробуйте еще раз\r\n• Перезапустите консоль: иногда консоли требуется обновление, чтобы обнаружить LAN-игры\r\n• Проверьте вкладку Friends/LAN: сервер появляется в разделе \\\"Friends\\\" или \\\"LAN Games\\\", а НЕ в списке серверов\r\n• Подождите 10-15 секунд после начала трансляции\r\n• Отключите VPN: VPN может блокировать локальные трансляции\r\n\r\n⚠️ Частые проблемы:\r\n\\\"No route found for user\\\" → Убедитесь, что оба устройства находятся в одной Wi‑Fi сети (избегайте гостевых сетей)\r\n\\\"Unable to connect to NetherLink relay server\\\" → Проверьте ваш интернет / статус relay\r\n\r\n📱 Все еще есть проблемы? Включите Debug Mode в NetherLink и проверьте журналы или попробуйте другой сервер.';

  @override
  String get helpMultiplayerFailedTitle => 'Сбой многопользовательского подключения';

  @override
  String get helpMultiplayerFailedSubtitle => 'Объяснение, почему это не ошибка NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Это не проблема NetherLink!\r\n\r\nNetherLink успешно перенаправил вас на запрошенный сервер. Сообщение \\\"Сбой многопользовательского подключения\\\" означает, что целевой сервер в данный момент недоступен. Возможные причины:\r\n\r\n• Целевой сервер Minecraft отключен или перегружен\r\n• Сервер требует обновленную версию клиента или определенное издание\r\n• Проблемы сети между relay и целевым сервером\r\n\r\nПопробуйте подключиться к другому серверу или обратитесь в поддержку сервера. Если проблема сохраняется на нескольких серверах, включите Debug Mode в NetherLink и проверьте журналы.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS не работает';

  @override
  String get helpNintendoDnsSubtitle => 'Частые проблемы DNS / relay';

  @override
  String get helpNintendoDnsBody => 'Если режим Nintendo DNS не работает, проверьте следующее:\r\n\r\n1. Убедитесь, что вы отправили DNS config из приложения (Send DNS Config).\r\n2. Убедитесь, что вы применили relay IP как Primary DNS на Switch.\r\n3. Убедитесь, что выбранный relay server (EU/US) находится в сети и не перегружен.\r\n4. Некоторые сети (например, captive portals) не позволяют использовать пользовательский DNS — протестируйте в другой сети.\r\n\r\nЕсли проблемы сохраняются, включите Debug Mode и проверьте журналы или попробуйте альтернативу Friends-mode.';

  @override
  String get helpFriendsModeTitle => 'Режим друзей не работает';

  @override
  String get helpFriendsModeSubtitle => 'Частые проблемы с друзьями';

  @override
  String get helpFriendsModeBody => 'Советы по устранению неполадок режима друзей:\r\n\r\n1. Убедитесь, что учетная запись relay friend добавлена/принята на консоли (если требуется).\r\n2. Попробуйте перезапустить игру и обновить вкладку Friends/LAN после включения режима друзей.\r\n\r\nЕсли сервер по-прежнему не виден друзьям, включите Debug Mode и проверьте журналы, чтобы выявить ошибки.';

  @override
  String get changeLanguageTitle => 'Изменить язык';

  @override
  String get changeLanguage => 'Язык';

  @override
  String get useSystemLanguage => 'Использовать язык системы';

  @override
  String get couldNotOpenUrl => 'Не удалось открыть URL';
}

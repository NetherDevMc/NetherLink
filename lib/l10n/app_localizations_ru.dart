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
  String get website => 'Сайт';

  @override
  String get howToUseMenu => 'Как использовать';

  @override
  String get support => 'Поддержка';

  @override
  String helpText(Object appCreator) {
    return 'Создано $appCreator.\n\nКак использовать:\n1. Введите адрес и порт вашего сервера Minecraft (по умолчанию: 19132)\n   — или выберите ранее сохраненный сервер из выпадающего списка\n2. (Необязательно) Выберите relay-сервер (EU или US), ближайший к вашему местоположению\n3. Нажмите \"Начать трансляцию\", чтобы начать\n4. На вашей консоли/устройстве: Minecraft > Играть > Друзья\n5. Вы должны увидеть LAN-сервер с названием \"NetherLink\"\n6. Нажмите на него, чтобы подключиться к вашему внешнему серверу через NetherLink\n\nNintendo Switch (режим DNS):\n1. Включите \"Nintendo Switch\" в панели подключения\n2. Выберите relay-сервер (EU или US)\n3. Нажмите \"Отправить конфигурацию DNS\" — это отправит вашу конфигурацию на relay\n   (это НЕ транслирует LAN-сервер)\n4. На вашей Switch примените настройки DNS NetherLink и подключитесь\n   используя запись сервера, которую вы используете для NetherLink\n\nПримечания:\n- Для LAN-трансляции NetherLink и консоль должны находиться в одной локальной сети.\n- Совет: выберите relay-сервер, который ближе всего к вам, для лучшей производительности.';
  }

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
    return 'Выбрано: $relayName\n\nКак подключиться:\n1. Перейдите в настройки вашей Switch и измените DNS на: $relayIp\n2. Откройте Minecraft и выберите сервер из списка (например, Cubecraft или Hive).\n3. Теперь вы будете автоматически отправлены на свой собственный сервер.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Как подключиться:\n1. На вашей консоли добавьте $friend в друзья.\n2. Откройте Minecraft и перейдите на вкладку Friends.\n3. Найдите ваш сервер в разделе LAN Worlds и выберите его для подключения.';
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
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Играйте через LAN-трансляцию или прокси';

  @override
  String get howToXboxBody => 'Как подключиться (Xbox / PS4 / PS5):\n1. Убедитесь, что устройство с NetherLink и ваша консоль находятся в одной локальной сети.\n2. В приложении введите адрес и порт вашего сервера Minecraft и нажмите \"Начать трансляцию\".\n3. На консоли откройте Minecraft → Play → найдите LAN Worlds или вкладку Friends и обновите список.\n4. Выберите LAN-сервер с именем \"NetherLink\", чтобы подключиться.\nПримечания:\n- Если сервер не появляется, убедитесь, что оба устройства находятся в одной подсети и приложение все еще ведет трансляцию.\n- Некоторые модели консолей или роутеров могут блокировать обнаружение LAN; при необходимости попробуйте изменить настройки приложения или роутера.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (режим DNS)';

  @override
  String get howToNintendoSubtitle => 'Инструкции по DNS relay для Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — режим DNS (пошагово):\n1. В приложении включите режим \"Nintendo\" и выберите relay-сервер (EU или US).\n2. Нажмите \"Отправить конфигурацию DNS\", чтобы отправить DNS IP на relay.\n3. На вашей Nintendo Switch перейдите в настройки системы → интернет → настройки интернета → (ваша сеть) → изменить настройки → DNS и установите основной DNS на relay IP.\n4. Откройте Minecraft и присоединитесь к публичному серверу; вы будете перенаправлены на свой сервер с помощью relay DNS.\nПримечания:\n- Режим DNS не транслирует LAN-сервер; он направляет игровой трафик через relay.\n- Верните DNS обратно после завершения, если вам нужно обычное поведение сети.';

  @override
  String get howToFriendsTitle => 'Режим друзей';

  @override
  String get howToFriendsSubtitle => 'Приглашайте друзей и подключайтесь через LAN';

  @override
  String get howToFriendsBody => 'Режим друзей — быстрые шаги:\n1. При необходимости добавьте учетную запись друга NetherLink (relay friend) на вашей консоли или платформе.\n2. В приложении включите режим друзей и отправьте конфигурацию relay (если применимо).\n3. На вашей консоли откройте Minecraft → Friends и найдите LAN Worlds — ваш сервер должен появиться там как LAN-мир.\n4. Выберите его, чтобы присоединиться к вашему серверу вместе с друзьями.\nПримечания:\n- Убедитесь, что у вас и ваших друзей одинаковые NAT/settings, которые позволяют видеть друзей.\n- Режим друзей зависит от функций друзей платформы и может потребовать принятия запросов в друзья.';

  @override
  String get helpNetherlinkTitle => 'NetherLink не появляется';

  @override
  String get helpNetherlinkSubtitle => 'Устранение проблем с обнаружением LAN';

  @override
  String get helpNetherlinkBody => 'Если сервер не появляется на вашей консоли, попробуйте следующие шаги:\n\n✅ Базовые проверки:\n1. Одна и та же WiFi-сеть - Ваш телефон/планшет и консоль ДОЛЖНЫ быть в одной WiFi-сети\n2. Правильный адрес сервера - Еще раз проверьте IP и порт (по умолчанию: 19132)\n3. Трансляция активна - Убедитесь, что NetherLink показывает статус \"Broadcasting\"\n\n🔄 Быстрые исправления:\n• Перезапустите приложение: остановите трансляцию, полностью закройте NetherLink, снова откройте его и попробуйте еще раз\n• Перезапустите консоль: иногда консоли требуется обновление, чтобы обнаружить LAN-игры\n• Проверьте вкладку Friends/LAN: сервер появляется в разделе \"Friends\" или \"LAN Games\", а НЕ в списке серверов\n• Подождите 10-15 секунд после начала трансляции\n• Отключите VPN: VPN может блокировать локальные трансляции\n\n⚠️ Частые проблемы:\n\"No route found for user\" → Убедитесь, что оба устройства находятся в одной Wi‑Fi сети (избегайте гостевых сетей)\n\"Unable to connect to NetherLink relay server\" → Проверьте ваш интернет / статус relay\n\n📱 Все еще есть проблемы? Включите Debug Mode в NetherLink и проверьте журналы или попробуйте другой сервер.';

  @override
  String get helpMultiplayerFailedTitle => 'Сбой многопользовательского подключения';

  @override
  String get helpMultiplayerFailedSubtitle => 'Объяснение, почему это не ошибка NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Это не проблема NetherLink!\n\nNetherLink успешно перенаправил вас на запрошенный сервер. Сообщение \"Сбой многопользовательского подключения\" означает, что целевой сервер в данный момент недоступен. Возможные причины:\n\n• Целевой сервер Minecraft отключен или перегружен\n• Сервер требует обновленную версию клиента или определенное издание\n• Проблемы сети между relay и целевым сервером\n\nПопробуйте подключиться к другому серверу или обратитесь в поддержку сервера. Если проблема сохраняется на нескольких серверах, включите Debug Mode в NetherLink и проверьте журналы.';

  @override
  String get helpNintendoDnsTitle => 'Nintendo DNS не работает';

  @override
  String get helpNintendoDnsSubtitle => 'Частые проблемы DNS / relay';

  @override
  String get helpNintendoDnsBody => 'Если режим Nintendo DNS не работает, проверьте следующее:\n\n1. Убедитесь, что вы отправили DNS config из приложения (Send DNS Config).\n2. Убедитесь, что вы применили relay IP как Primary DNS на Switch.\n3. Убедитесь, что выбранный relay server (EU/US) находится в сети и не перегружен.\n4. Некоторые сети (например, captive portals) не позволяют использовать пользовательский DNS — протестируйте в другой сети.\n\nЕсли проблемы сохраняются, включите Debug Mode и проверьте журналы или попробуйте альтернативу Friends-mode.';

  @override
  String get helpFriendsModeTitle => 'Режим друзей не работает';

  @override
  String get helpFriendsModeSubtitle => 'Частые проблемы с друзьями';

  @override
  String get helpFriendsModeBody => 'Советы по устранению неполадок режима друзей:\n\n1. Убедитесь, что учетная запись relay friend добавлена/принята на консоли (если требуется).\n2. Попробуйте перезапустить игру и обновить вкладку Friends/LAN после включения режима друзей.\n\nЕсли сервер по-прежнему не виден друзьям, включите Debug Mode и проверьте журналы, чтобы выявить ошибки.';

  @override
  String get changeLanguageTitle => 'Изменить язык';

  @override
  String get changeLanguage => 'Язык';

  @override
  String get useSystemLanguage => 'Использовать язык системы';

  @override
  String get couldNotOpenUrl => 'Не удалось открыть URL';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Console';

  @override
  String get consoleOutput => 'Saída do console';

  @override
  String get noLogsYet => 'Ainda não há logs';

  @override
  String get startBroadcastingToSeeOutput => 'Inicie a transmissão para ver a saída';

  @override
  String get close => 'Fechar';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Junte-se a nós';

  @override
  String get more => 'Mais';

  @override
  String get website => 'Site';

  @override
  String get howToUseMenu => 'Como usar';

  @override
  String get support => 'Suporte';

  @override
  String helpText(Object appCreator) {
    return 'Criado por $appCreator.\r\n\r\nComo usar:\r\n1. Digite o endereço e a porta do seu servidor de Minecraft (padrão: 19132)\r\n   — ou selecione um servidor salvo anteriormente no menu suspenso\r\n2. (Opcional) Escolha um Servidor Relay (EU ou US) mais próximo da sua localização\r\n3. Clique em \\\"Iniciar Transmissão\\\" para começar\r\n4. No seu console/dispositivo: Minecraft > Jogar > Amigos\r\n5. Você deverá ver um servidor LAN chamado \\\"NetherLink\\\"\r\n6. Clique nele para entrar no seu servidor externo via NetherLink\r\n\r\nNintendo Switch (modo DNS):\r\n1. Ative \\\"Nintendo Switch\\\" no painel de conexão\r\n2. Selecione um Servidor Relay (EU ou US)\r\n3. Clique em \\\"Enviar Configuração DNS\\\" — isso envia sua configuração ao relay\r\n   (isso NÃO transmite um servidor LAN)\r\n4. No seu Switch, aplique a configuração DNS do NetherLink e entre\r\n   usando a entrada de servidor que você usa para o NetherLink\r\n\r\nNotas:\r\n- Para transmissão LAN, o NetherLink e o console devem estar na mesma rede local.\r\n- Dica: escolha o servidor relay mais próximo de você para obter o melhor desempenho.';
  }

  @override
  String get serverDetailsLabel => 'Detalhes do servidor';

  @override
  String get start => 'Iniciar';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Iniciar modo Java';

  @override
  String get javaInfoTitle => 'Modo Java';

  @override
  String get javaInfoText => 'Conecte-se a servidores Java Edition';

  @override
  String get howToJavaTitle => 'Modo Java';

  @override
  String get howToJavaSubtitle => 'Conecte-se a servidores Java Edition via NetherLink';

  @override
  String get aternosSubtext => 'Crie o seu próprio servidor Minecraft gratuito';

  @override
  String get howToJavaBody => 'Modo Java — etapas rápidas:\n1. No aplicativo, selecione o modo Java.\n2. Digite o endereço e a porta do seu servidor Java Edition (padrão: 25565).\n3. Toque em \"Iniciar modo Java\" — o NetherLink fará a ponte da conexão.\n4. Abra o Minecraft Bedrock e vá para a aba Amigos.\n5. Selecione o servidor LAN chamado \"NetherLink\" para entrar no servidor Java.\n\n⚠️ Avisos importantes:\n- É necessária uma conta válida do Java Edition (Microsoft).\n- Alguns servidores usam sistemas anti-cheat que podem detectar e banir sua conta.\n- Alguns servidores proíbem explicitamente clientes Bedrock — sempre verifique as regras do servidor.\n- O NetherLink não se responsabiliza por banimentos, suspensões ou outros problemas relacionados à conta que possam resultar do uso deste recurso.\n- Use por sua conta e risco.';

  @override
  String get language => 'Português';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Alternar depuração';

  @override
  String get copyLogs => 'Copiar logs';

  @override
  String get clear => 'Limpar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteServer => 'Excluir servidor';

  @override
  String get delete => 'Excluir';

  @override
  String get myServers => 'Meus servidores';

  @override
  String get quickAccessServers => 'Servidores de acesso rápido';

  @override
  String get addServer => 'Adicionar servidor';

  @override
  String get addServersHint => 'Adicione servidores para se conectar rapidamente depois';

  @override
  String get serverNameLabel => 'Nome do servidor *';

  @override
  String get addressLabel => 'Endereço *';

  @override
  String get portLabel => 'Porta *';

  @override
  String get descriptionLabel => 'Descrição (Opcional)';

  @override
  String get save => 'Salvar';

  @override
  String get initializing => 'Inicializando...';

  @override
  String get createdBy => 'Criado por NetherDev';

  @override
  String get bedrockBridge => 'Ponte Bedrock';

  @override
  String get clientDisconnected => 'Cliente desconectado — transmissão interrompida';

  @override
  String get pleaseEnterServer => '⚠️ Por favor, insira um endereço de servidor';

  @override
  String get invalidPort => '⚠️ Número de porta inválido (1-65535)';

  @override
  String get dnsConfigSent => '✅ Configuração DNS enviada ao relay';

  @override
  String get broadcastingStarted => 'Transmissão iniciada';

  @override
  String get broadcastStopped => 'Transmissão interrompida';

  @override
  String selectedServer(Object name) {
    return '📋 Selecionado: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Selecionado: $name';
  }

  @override
  String get noLogsToCopy => 'Não há logs para copiar';

  @override
  String copiedLogs(Object count) {
    return '$count entradas de log copiadas para a área de transferência';
  }

  @override
  String get debugEnabled => 'Logs de depuração ativados';

  @override
  String get debugDisabled => 'Logs de depuração desativados';

  @override
  String get howToUseTitle => 'Como usar o NetherLink';

  @override
  String get iUnderstand => 'Entendi';

  @override
  String get playOnSwitchTitle => 'Jogar no Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Jogar com amigos';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Selecionado: $relayName\r\n\r\nComo se conectar:\r\n1. Vá para as configurações do seu Switch e altere o DNS para: $relayIp\r\n2. Abra o Minecraft e selecione um servidor da lista (como Cubecraft ou Hive).\r\n3. Agora você será enviado automaticamente para o seu próprio servidor.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Como se conectar:\r\n1. No seu console, adicione $friend como amigo.\r\n2. Abra o Minecraft e vá para a aba Amigos.\r\n3. Procure seu servidor em Mundos LAN e selecione-o para entrar.';
  }

  @override
  String get nldServerLabel => 'SERVIDOR NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'Selecionar relay $name';
  }

  @override
  String get noSavedServers => 'Nenhum servidor salvo';

  @override
  String get savedServers => 'Servidores salvos';

  @override
  String get serverAddressHint => 'Endereço do servidor';

  @override
  String get portHint => 'Porta';

  @override
  String get manageServers => 'Gerenciar servidores';

  @override
  String get manageServersTooltip => 'Gerenciar servidores';

  @override
  String get stopBroadcasting => 'Parar transmissão';

  @override
  String get startNintendoMode => 'Iniciar modo Nintendo';

  @override
  String get startFriendsMode => 'Iniciar modo Amigos';

  @override
  String get startBroadcasting => 'Iniciar transmissão';

  @override
  String get modeLabel => 'Modo';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Amigos';

  @override
  String get nintendoInfoTitle => 'Modo DNS do Nintendo Switch';

  @override
  String get nintendoInfoText => 'Comece no modo Nintendo, configure seu DNS e entre em um servidor em destaque.';

  @override
  String get friendModeTitle => 'Modo Amigos';

  @override
  String get friendModeText => 'Adicione os bots de amigos do NetherLink como amigos. Inicie o modo Amigos e jogue';

  @override
  String get selectedRelayCheck => 'Selecionado';

  @override
  String relayFallbackWarning(Object name) {
    return 'Aviso: o relay original não respondeu. Relay alternativo em uso: $name';
  }

  @override
  String get relayUnableConnect => 'Não foi possível conectar a NENHUM servidor relay do NetherLink. Tente novamente mais tarde ou verifique sua internet.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / conexão proxy)';

  @override
  String get howToXboxSubtitle => 'Jogue via transmissão LAN ou proxy';

  @override
  String get howToXboxBody => 'Como se conectar (Xbox / PS4 / PS5):\r\n1. Certifique-se de que o dispositivo que está executando o NetherLink e o seu console estejam na mesma rede local.\r\n2. No aplicativo, informe o endereço e a porta do seu servidor de Minecraft e pressione \\\"Iniciar transmissão\\\".\r\n3. No console, abra Minecraft → Jogar → procure por Mundos LAN ou pela aba Amigos e atualize a lista.\r\n4. Selecione o servidor LAN chamado \\\"NetherLink\\\" para entrar.\r\nNotas:\r\n- Se o servidor não aparecer, confirme que ambos os dispositivos estão na mesma sub-rede e que o aplicativo ainda está transmitindo.\r\n- Alguns modelos de console ou roteadores podem bloquear a descoberta LAN; tente ajustar as configurações do aplicativo ou do roteador, se necessário.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (modo DNS)';

  @override
  String get howToNintendoSubtitle => 'Instruções de relay DNS para Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — modo DNS (passo a passo):\r\n1. No aplicativo, ative o modo \\\"Nintendo\\\" e selecione um Servidor Relay (EU ou US).\r\n2. Toque em \\\"Enviar Configuração DNS\\\" para enviar o IP DNS ao relay.\r\n3. No seu Nintendo Switch, vá para Configurações do sistema → Internet → Configurações de Internet → (sua rede) → Alterar configurações → DNS e defina o DNS primário como o IP do relay.\r\n4. Abra o Minecraft e entre em um servidor público; você será redirecionado ao seu servidor usando o DNS do relay.\r\nNotas:\r\n- O modo DNS não transmite um servidor LAN; ele roteia o tráfego do jogo pelo relay.\r\n- Reverta seu DNS quando terminar se precisar do comportamento normal da rede.';

  @override
  String get howToFriendsTitle => 'Modo Amigos';

  @override
  String get howToFriendsSubtitle => 'Convide amigos e entre via LAN';

  @override
  String get howToFriendsBody => 'Modo Amigos — passos rápidos:\r\n1. Adicione a conta de amigo do NetherLink no seu console ou plataforma, se necessário.\r\n2. No aplicativo, ative o modo Amigos e envie a configuração do relay (se aplicável).\r\n3. No seu console, abra Minecraft → Amigos e procure por Mundos LAN — seu servidor deve aparecer lá como um mundo LAN.\r\n4. Selecione-o para entrar no seu servidor com amigos.\r\nNotas:\r\n- Certifique-se de que você e seus amigos tenham as mesmas configurações de NAT/configurações que permitem presença de amigos.\r\n- O modo Amigos depende dos recursos de amizade da plataforma e pode exigir aceitar solicitações de amizade.';

  @override
  String get helpNetherlinkTitle => 'NetherLink não aparece';

  @override
  String get helpNetherlinkSubtitle => 'Solução de problemas de descoberta LAN';

  @override
  String get helpNetherlinkBody => 'Se o servidor não estiver aparecendo no seu console, tente estas etapas:\r\n\r\n✅ Verificações básicas:\r\n1. Mesma rede WiFi - Seu telefone/tablet e o console DEVEM estar na mesma rede WiFi\r\n2. Endereço correto do servidor - Verifique novamente o IP e a porta (padrão: 19132)\r\n3. Transmissão ativa - Verifique se o NetherLink mostra o status \"Transmitindo\"\r\n\r\n🔄 Correções rápidas:\r\n• Reinicie o aplicativo: pare a transmissão, feche o NetherLink completamente, abra-o novamente e tente de novo\r\n• Reinicie seu console: às vezes o console precisa ser atualizado para detectar jogos LAN\r\n• Verifique a aba Amigos/LAN: o servidor aparece em \"Amigos\" ou \"Jogos LAN\", e NÃO na lista de servidores\r\n• Aguarde de 10 a 15 segundos após iniciar a transmissão\r\n• Desative VPNs: VPNs podem bloquear transmissões locais\r\n\r\n⚠️ Problemas comuns:\r\n\"No route found for user\" → Certifique-se de que ambos os dispositivos estejam na mesma rede Wi‑Fi (evite redes de convidados)\r\n\"Unable to connect to NetherLink relay server\" → Verifique sua internet / status do relay\r\n\r\n📱 Ainda está com problemas? Ative o Modo de depuração no NetherLink e verifique os logs, ou tente um servidor diferente.';

  @override
  String get helpMultiplayerFailedTitle => 'Falha na conexão multijogador';

  @override
  String get helpMultiplayerFailedSubtitle => 'Explicação de por que isso não é um erro do NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Isso não é um problema do NetherLink!\r\n\r\nO NetherLink redirecionou você com sucesso para o servidor solicitado. A mensagem \\\"Falha na conexão multijogador\\\" indica que o servidor de destino está inacessível no momento. Motivos possíveis:\r\n\r\n• O servidor de Minecraft de destino está offline ou sobrecarregado\r\n• O servidor exige uma versão atualizada do cliente ou uma edição específica\r\n• Problemas de rede entre o relay e o servidor de destino\r\n\r\nTente se conectar a outro servidor ou entre em contato com o suporte do servidor. Se o problema persistir em vários servidores, ative o Modo de depuração no NetherLink e verifique os logs.';

  @override
  String get helpNintendoDnsTitle => 'O DNS do Nintendo não funciona';

  @override
  String get helpNintendoDnsSubtitle => 'Problemas comuns de DNS / relay';

  @override
  String get helpNintendoDnsBody => 'Se o modo DNS do Nintendo não estiver funcionando, verifique o seguinte:\r\n\r\n1. Confirme que você enviou a configuração DNS pelo aplicativo (Enviar Configuração DNS).\r\n2. Verifique se você aplicou o IP do relay como DNS Primário no Switch.\r\n3. Certifique-se de que o servidor relay selecionado (EU/US) está online e não está sobrecarregado.\r\n4. Algumas redes (por exemplo, captive portals) impedem DNS personalizado — teste em outra rede.\r\n\r\nSe os problemas persistirem, ative o Modo de depuração e verifique os logs, ou tente a alternativa do modo Amigos.';

  @override
  String get helpFriendsModeTitle => 'O modo Amigos não funciona';

  @override
  String get helpFriendsModeSubtitle => 'Problemas comuns com amigos';

  @override
  String get helpFriendsModeBody => 'Dicas de solução de problemas para o modo Amigos:\r\n\r\n1. Certifique-se de que a conta de amigo do relay foi adicionada/aceita no console (se necessário).\r\n2. Tente reiniciar o jogo e atualizar a aba Amigos/LAN depois de ativar o modo Amigos.\r\n\r\nSe o servidor ainda não aparecer para os amigos, ative o Modo de depuração e verifique os logs para identificar erros.';

  @override
  String get changeLanguageTitle => 'Alterar idioma';

  @override
  String get changeLanguage => 'Idioma';

  @override
  String get useSystemLanguage => 'Usar idioma do sistema';

  @override
  String get couldNotOpenUrl => 'Não foi possível abrir a URL';
}

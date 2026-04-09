// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Consola';

  @override
  String get consoleOutput => 'Salida de la consola';

  @override
  String get noLogsYet => 'Aún no hay registros';

  @override
  String get startBroadcastingToSeeOutput => 'Inicia la transmisión para ver la salida';

  @override
  String get close => 'Cerrar';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Únete';

  @override
  String get more => 'More';

  @override
  String get website => 'Sitio web';

  @override
  String get howToUseMenu => 'Cómo usar';

  @override
  String get support => 'Soporte';

  @override
  String helpText(Object appCreator) {
    return 'Creado por $appCreator.\r\n\r\nCómo usar:\r\n1. Introduce la dirección y el puerto de tu servidor de Minecraft (predeterminado: 19132)\r\n   — o selecciona un servidor guardado previamente en el menú desplegable\r\n2. (Opcional) Elige un servidor relay (EU o US) cercano a tu ubicación\r\n3. Haz clic en \\\"Iniciar transmisión\\\" para comenzar\r\n4. En tu consola/dispositivo: Minecraft > Jugar > Amigos\r\n5. Deberías ver un servidor LAN llamado \\\"NetherLink\\\"\r\n6. Haz clic en él para unirte a tu servidor externo mediante NetherLink\r\n\r\nNintendo Switch (modo DNS):\r\n1. Activa \\\"Nintendo Switch\\\" en el panel de conexión\r\n2. Selecciona un servidor relay (EU o US)\r\n3. Haz clic en \\\"Enviar configuración DNS\\\" — esto envía tu configuración al relay\r\n   (NO transmite un servidor LAN)\r\n4. En tu Switch, aplica la configuración DNS de NetherLink y únete\r\n   usando la entrada de servidor que utilizas para NetherLink\r\n\r\nNotas:\r\n- Para la transmisión LAN, NetherLink y la consola deben estar en la misma red local.\r\n- Consejo: Elige el servidor relay más cercano para obtener el mejor rendimiento.';
  }

  @override
  String get serverDetailsLabel => 'Detalles del servidor';

  @override
  String get start => 'Iniciar';

  @override
  String get labelJava => 'Java';

  @override
  String get startJavaMode => 'Iniciar modo Java';

  @override
  String get javaInfoTitle => 'Modo Java';

  @override
  String get javaInfoText => 'Conéctate a servidores de Java Edition';

  @override
  String get howToJavaTitle => 'Modo Java';

  @override
  String get howToJavaSubtitle => 'Conéctate a servidores de Java Edition mediante NetherLink';

  @override
  String get howToJavaBody => 'Modo Java — pasos rápidos:\r\n1. En la aplicación, selecciona el modo Java.\r\n2. Introduce la dirección y el puerto de tu servidor de Java Edition (predeterminado: 25565).\r\n3. Pulsa \"Iniciar modo Java\" — NetherLink enlazará la conexión.\r\n4. Abre Minecraft Bedrock y ve a la pestaña Amigos.\r\n5. Selecciona el servidor LAN llamado \"NetherLink\" para unirte al servidor Java.\r\n\r\n⚠️ Advertencias importantes:\r\n- Se requiere una cuenta válida de Java Edition (Microsoft).\r\n- Algunos servidores usan sistemas antitrampas que pueden detectar y bloquear tu cuenta.\r\n- Algunos servidores prohíben explícitamente a los clientes de Bedrock; revisa siempre las reglas del servidor.\r\n- NetherLink no se hace responsable de bloqueos, suspensiones u otros problemas relacionados con la cuenta que puedan derivarse del uso de esta función.\r\n- Úsalo bajo tu propia responsabilidad.';

  @override
  String get language => 'Español';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Activar/desactivar depuración';

  @override
  String get copyLogs => 'Copiar registros';

  @override
  String get clear => 'Limpiar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteServer => 'Eliminar servidor';

  @override
  String get delete => 'Eliminar';

  @override
  String get myServers => 'Mis servidores';

  @override
  String get quickAccessServers => 'Servidores de acceso rápido';

  @override
  String get addServer => 'Agregar servidor';

  @override
  String get addServersHint => 'Agrega servidores para conectarte rápidamente más tarde';

  @override
  String get serverNameLabel => 'Nombre del servidor *';

  @override
  String get addressLabel => 'Dirección *';

  @override
  String get portLabel => 'Puerto *';

  @override
  String get descriptionLabel => 'Descripción (opcional)';

  @override
  String get save => 'Guardar';

  @override
  String get initializing => 'Inicializando...';

  @override
  String get createdBy => 'Creado por NetherDev';

  @override
  String get bedrockBridge => 'Puente Bedrock';

  @override
  String get clientDisconnected => 'Cliente desconectado — transmisión detenida';

  @override
  String get pleaseEnterServer => '⚠️ Por favor, introduce una dirección de servidor';

  @override
  String get invalidPort => '⚠️ Número de puerto no válido (1-65535)';

  @override
  String get dnsConfigSent => '✅ Configuración DNS enviada al relay';

  @override
  String get broadcastingStarted => 'Transmisión iniciada';

  @override
  String get broadcastStopped => 'Transmisión detenida';

  @override
  String selectedServer(Object name) {
    return '📋 Seleccionado: $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Seleccionado: $name';
  }

  @override
  String get noLogsToCopy => 'No hay registros para copiar';

  @override
  String copiedLogs(Object count) {
    return 'Se copiaron $count entradas de registro al portapapeles';
  }

  @override
  String get debugEnabled => 'Registros de depuración activados';

  @override
  String get debugDisabled => 'Registros de depuración desactivados';

  @override
  String get howToUseTitle => 'Cómo usar NetherLink';

  @override
  String get iUnderstand => 'Entiendo';

  @override
  String get playOnSwitchTitle => 'Jugar en Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Jugar con amigos';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Seleccionado: $relayName\r\n\r\nCómo conectarte:\r\n1. Ve a la configuración de tu Switch y cambia el DNS a: $relayIp\r\n2. Abre Minecraft y selecciona un servidor de la lista (como Cubecraft o Hive).\r\n3. Ahora serás enviado automáticamente a tu propio servidor.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Cómo conectarte:\r\n1. En tu consola, agrega a $friend como amigo.\r\n2. Abre Minecraft y ve a la pestaña Amigos.\r\n3. Busca tu servidor en Mundos LAN y selecciónalo para unirte.';
  }

  @override
  String get nldServerLabel => 'SERVIDOR NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'Seleccionar relay $name';
  }

  @override
  String get noSavedServers => 'No hay servidores guardados';

  @override
  String get savedServers => 'Servidores guardados';

  @override
  String get serverAddressHint => 'Dirección del servidor';

  @override
  String get portHint => 'Puerto';

  @override
  String get manageServers => 'Administrar servidores';

  @override
  String get manageServersTooltip => 'Administrar servidores';

  @override
  String get stopBroadcasting => 'Detener transmisión';

  @override
  String get startNintendoMode => 'Iniciar modo Nintendo';

  @override
  String get startFriendsMode => 'Iniciar modo Amigos';

  @override
  String get startBroadcasting => 'Iniciar transmisión';

  @override
  String get modeLabel => 'Modo';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Amigos';

  @override
  String get nintendoInfoTitle => 'Modo DNS de Nintendo Switch';

  @override
  String get nintendoInfoText => 'Inicia en modo Nintendo, configura tu DNS y únete a un servidor destacado.';

  @override
  String get friendModeTitle => 'Modo Amigos';

  @override
  String get friendModeText => 'Agrega los bots de amigos de NetherLink como amigos. Inicia el modo Amigos y juega';

  @override
  String get selectedRelayCheck => 'Seleccionado';

  @override
  String relayFallbackWarning(Object name) {
    return 'Advertencia: el relay original no respondió. Relay de respaldo en uso: $name';
  }

  @override
  String get relayUnableConnect => 'No se pudo conectar a NINGÚN servidor relay de NetherLink. Inténtalo más tarde o revisa tu conexión a internet.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / proxy)';

  @override
  String get howToXboxSubtitle => 'Juega mediante transmisión LAN o proxy';

  @override
  String get howToXboxBody => 'Cómo conectarte (Xbox / PS4 / PS5):\r\n1. Asegúrate de que el dispositivo que ejecuta NetherLink y tu consola estén en la misma red local.\r\n2. En la aplicación, introduce la dirección y el puerto de tu servidor de Minecraft y pulsa \\\"Iniciar transmisión\\\".\r\n3. En la consola, abre Minecraft → Jugar → busca Mundos LAN o la pestaña Amigos y actualiza la lista.\r\n4. Selecciona el servidor LAN llamado \\\"NetherLink\\\" para unirte.\r\nNotas:\r\n- Si el servidor no aparece, confirma que ambos dispositivos están en la misma subred y que la aplicación sigue transmitiendo.\r\n- Algunos modelos de consola o routers pueden bloquear el descubrimiento LAN; prueba cambiando la aplicación o la configuración del router si es necesario.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (modo DNS)';

  @override
  String get howToNintendoSubtitle => 'Instrucciones de relay DNS para Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — modo DNS (paso a paso):\r\n1. En la aplicación, activa el modo \\\"Nintendo\\\" y selecciona un servidor relay (EU o US).\r\n2. Toca \\\"Enviar configuración DNS\\\" para enviar la IP DNS al relay.\r\n3. En tu Nintendo Switch, ve a Configuración del sistema → Internet → Configuración de Internet → (tu red) → Cambiar configuración → DNS y establece el DNS primario en la IP del relay.\r\n4. Abre Minecraft y únete a un servidor público; serás redirigido a tu servidor usando el DNS del relay.\r\nNotas:\r\n- El modo DNS no transmite un servidor LAN; enruta el tráfico del juego a través del relay.\r\n- Restablece tu DNS cuando termines si necesitas un comportamiento normal de la red.';

  @override
  String get howToFriendsTitle => 'Modo Amigos';

  @override
  String get howToFriendsSubtitle => 'Invita a amigos y únete mediante LAN';

  @override
  String get howToFriendsBody => 'Modo Amigos — pasos rápidos:\r\n1. Agrega la cuenta amiga de NetherLink (relay friend) en tu consola o plataforma si es necesario.\r\n2. En la aplicación, activa el modo Amigos y envía la configuración del relay (si corresponde).\r\n3. En tu consola, abre Minecraft → Amigos y busca Mundos LAN — tu servidor debería aparecer allí como un mundo LAN.\r\n4. Selecciónalo para unirte a tu servidor con amigos.\r\nNotas:\r\n- Asegúrate de que tú y tus amigos tengan la misma configuración NAT/ajustes que permitan la presencia de amigos.\r\n- El modo Amigos depende de las funciones de amigos de la plataforma y puede requerir aceptar solicitudes de amistad.';

  @override
  String get helpNetherlinkTitle => 'NetherLink no aparece';

  @override
  String get helpNetherlinkSubtitle => 'Solución de problemas de detección LAN';

  @override
  String get helpNetherlinkBody => 'Si el servidor no aparece en tu consola, prueba estos pasos:\r\n\r\n✅ Comprobaciones básicas:\r\n1. Misma red WiFi - Tu teléfono/tableta y tu consola DEBEN estar en la misma WiFi\r\n2. Dirección de servidor correcta - Verifica de nuevo la IP y el puerto (predeterminado: 19132)\r\n3. Transmisión activa - Verifica que NetherLink muestre el estado \\\"Transmitiendo\\\"\r\n\r\n🔄 Soluciones rápidas:\r\n• Reinicia la aplicación: detén la transmisión, cierra NetherLink por completo, vuelve a abrirla e inténtalo de nuevo\r\n• Reinicia tu consola: a veces la consola necesita actualizarse para detectar juegos LAN\r\n• Revisa la pestaña Amigos/LAN: el servidor aparece en \\\"Amigos\\\" o \\\"Juegos LAN\\\", NO en la lista de servidores\r\n• Espera 10-15 segundos después de iniciar la transmisión\r\n• Desactiva las VPN: las VPN pueden bloquear las transmisiones locales\r\n\r\n⚠️ Problemas comunes:\r\n\\\"No route found for user\\\" → Asegúrate de que ambos dispositivos estén en la misma Wi‑Fi (evita redes de invitados)\r\n\\\"Unable to connect to NetherLink relay server\\\" → Revisa tu internet / estado del relay\r\n\r\n📱 ¿Sigues teniendo problemas? Activa el modo de depuración en NetherLink y revisa los registros, o prueba con otro servidor.';

  @override
  String get helpMultiplayerFailedTitle => 'Conexión multijugador fallida';

  @override
  String get helpMultiplayerFailedSubtitle => 'Explicación de por qué esto no es un error de NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ ¡Esto no es un problema de NetherLink!\r\n\r\nNetherLink te redirigió correctamente al servidor solicitado. El mensaje \\\"Conexión multijugador fallida\\\" indica que el servidor de destino no está disponible en este momento. Posibles razones:\r\n\r\n• El servidor de Minecraft de destino está desconectado o sobrecargado\r\n• El servidor requiere una versión actualizada del cliente o una edición específica\r\n• Problemas de red entre el relay y el servidor de destino\r\n\r\nIntenta conectarte a otro servidor o contacta con el soporte del servidor. Si el problema persiste en varios servidores, activa el modo de depuración en NetherLink y revisa los registros.';

  @override
  String get helpNintendoDnsTitle => 'El DNS de Nintendo no funciona';

  @override
  String get helpNintendoDnsSubtitle => 'Problemas comunes de DNS / relay';

  @override
  String get helpNintendoDnsBody => 'Si el modo DNS de Nintendo no funciona, revisa lo siguiente:\r\n\r\n1. Confirma que enviaste la configuración DNS desde la aplicación (Enviar configuración DNS).\r\n2. Verifica que aplicaste la IP del relay como DNS primario en la Switch.\r\n3. Asegúrate de que el servidor relay seleccionado (EU/US) esté en línea y no sobrecargado.\r\n4. Algunas redes (por ejemplo, portales cautivos) impiden el uso de DNS personalizado — prueba en otra red.\r\n\r\nSi los problemas persisten, activa el modo de depuración y revisa los registros o prueba la alternativa del modo Amigos.';

  @override
  String get helpFriendsModeTitle => 'El modo Amigos no funciona';

  @override
  String get helpFriendsModeSubtitle => 'Problemas comunes con amigos';

  @override
  String get helpFriendsModeBody => 'Consejos para solucionar problemas del modo Amigos:\r\n\r\n1. Asegúrate de que la cuenta amiga del relay esté agregada/aceptada en la consola (si es necesario).\r\n2. Intenta reiniciar el juego y actualizar la pestaña Amigos/LAN después de activar el modo Amigos.\r\n\r\nSi el servidor sigue sin aparecer para tus amigos, activa el modo de depuración y revisa los registros para identificar errores.';

  @override
  String get changeLanguageTitle => 'Cambiar idioma';

  @override
  String get changeLanguage => 'Idioma';

  @override
  String get useSystemLanguage => 'Usar idioma del sistema';

  @override
  String get couldNotOpenUrl => 'No se pudo abrir la URL';
}

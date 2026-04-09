// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'NetherLink';

  @override
  String get console => 'Console';

  @override
  String get consoleOutput => 'Sortie de la console';

  @override
  String get noLogsYet => 'Aucun journal pour le moment';

  @override
  String get startBroadcastingToSeeOutput => 'Démarrez la diffusion pour voir la sortie';

  @override
  String get close => 'Fermer';

  @override
  String get ok => 'OK';

  @override
  String get joinUs => 'Rejoignez-nous';

  @override
  String get more => 'More';

  @override
  String get website => 'Site web';

  @override
  String get howToUseMenu => 'Comment utiliser';

  @override
  String get support => 'Assistance';

  @override
  String helpText(Object appCreator) {
    return 'Créé par $appCreator.\r\n\r\nComment utiliser :\r\n1. Saisissez l\'adresse et le port de votre serveur Minecraft (par défaut : 19132)\r\n   — ou sélectionnez un serveur précédemment enregistré dans la liste déroulante\r\n2. (Optionnel) Choisissez un serveur relais (EU ou US) proche de votre position\r\n3. Cliquez sur \\\"Démarrer la diffusion\\\" pour commencer\r\n4. Sur votre console/appareil : Minecraft > Jouer > Amis\r\n5. Vous devriez voir un serveur LAN appelé \\\"NetherLink\\\"\r\n6. Cliquez dessus pour rejoindre votre serveur externe via NetherLink\r\n\r\nNintendo Switch (mode DNS) :\r\n1. Activez \\\"Nintendo Switch\\\" dans le panneau de connexion\r\n2. Sélectionnez un serveur relais (EU ou US)\r\n3. Cliquez sur \\\"Envoyer la configuration DNS\\\" — cela envoie votre configuration au relais\r\n   (cela ne diffuse PAS de serveur LAN)\r\n4. Sur votre Switch, appliquez votre configuration DNS NetherLink et rejoignez\r\n   en utilisant l\'entrée de serveur que vous utilisez pour NetherLink\r\n\r\nNotes :\r\n- Pour la diffusion LAN, NetherLink et la console doivent être sur le même réseau local.\r\n- Astuce : choisissez le serveur relais le plus proche de vous pour obtenir les meilleures performances.';
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
  String get language => 'Français';

  @override
  String get discord => 'Discord';

  @override
  String get toggleDebug => 'Activer/désactiver le débogage';

  @override
  String get copyLogs => 'Copier les journaux';

  @override
  String get clear => 'Effacer';

  @override
  String get cancel => 'Annuler';

  @override
  String get deleteServer => 'Supprimer le serveur';

  @override
  String get delete => 'Supprimer';

  @override
  String get myServers => 'Mes serveurs';

  @override
  String get quickAccessServers => 'Serveurs d\'accès rapide';

  @override
  String get addServer => 'Ajouter un serveur';

  @override
  String get addServersHint => 'Ajoutez des serveurs pour vous connecter rapidement plus tard';

  @override
  String get serverNameLabel => 'Nom du serveur *';

  @override
  String get addressLabel => 'Adresse *';

  @override
  String get portLabel => 'Port *';

  @override
  String get descriptionLabel => 'Description (optionnelle)';

  @override
  String get save => 'Enregistrer';

  @override
  String get initializing => 'Initialisation...';

  @override
  String get createdBy => 'Créé par NetherDev';

  @override
  String get bedrockBridge => 'Pont Bedrock';

  @override
  String get clientDisconnected => 'Client déconnecté — diffusion arrêtée';

  @override
  String get pleaseEnterServer => '⚠️ Veuillez saisir une adresse de serveur';

  @override
  String get invalidPort => '⚠️ Numéro de port invalide (1-65535)';

  @override
  String get dnsConfigSent => '✅ Configuration DNS envoyée au relais';

  @override
  String get broadcastingStarted => 'Diffusion démarrée';

  @override
  String get broadcastStopped => 'Diffusion arrêtée';

  @override
  String selectedServer(Object name) {
    return '📋 Sélectionné : $name';
  }

  @override
  String selectedFeaturedServer(Object name) {
    return 'Sélectionné : $name';
  }

  @override
  String get noLogsToCopy => 'Aucun journal à copier';

  @override
  String copiedLogs(Object count) {
    return '$count entrées de journal copiées dans le presse-papiers';
  }

  @override
  String get debugEnabled => 'Journaux de débogage activés';

  @override
  String get debugDisabled => 'Journaux de débogage désactivés';

  @override
  String get howToUseTitle => 'Comment utiliser NetherLink';

  @override
  String get iUnderstand => 'Je comprends';

  @override
  String get playOnSwitchTitle => 'Jouer sur Nintendo Switch';

  @override
  String get playWithFriendsTitle => 'Jouer avec des amis';

  @override
  String playInstructionsSwitch(Object relayName, Object relayIp) {
    return 'Sélectionné : $relayName\r\n\r\nComment se connecter :\r\n1. Allez dans les paramètres de votre Switch et changez le DNS en : $relayIp\r\n2. Ouvrez Minecraft et sélectionnez un serveur dans la liste (comme Cubecraft ou Hive).\r\n3. Vous serez maintenant redirigé automatiquement vers votre propre serveur.';
  }

  @override
  String playInstructionsFriends(Object friend) {
    return 'Comment se connecter :\r\n1. Sur votre console, ajoutez $friend comme ami.\r\n2. Ouvrez Minecraft et allez dans l\'onglet Amis.\r\n3. Recherchez votre serveur dans Mondes LAN et sélectionnez-le pour le rejoindre.';
  }

  @override
  String get nldServerLabel => 'SERVEUR NETHERLINK';

  @override
  String selectRelayLabel(Object name) {
    return 'Sélectionner le relais $name';
  }

  @override
  String get noSavedServers => 'Aucun serveur enregistré';

  @override
  String get savedServers => 'Serveurs enregistrés';

  @override
  String get serverAddressHint => 'Adresse du serveur';

  @override
  String get portHint => 'Port';

  @override
  String get manageServers => 'Gérer les serveurs';

  @override
  String get manageServersTooltip => 'Gérer les serveurs';

  @override
  String get stopBroadcasting => 'Arrêter la diffusion';

  @override
  String get startNintendoMode => 'Démarrer le mode Nintendo';

  @override
  String get startFriendsMode => 'Démarrer le mode Amis';

  @override
  String get startBroadcasting => 'Démarrer la diffusion';

  @override
  String get modeLabel => 'Mode';

  @override
  String get labelXbox => 'Xbox/PS4-5';

  @override
  String get labelNintendo => 'Nintendo';

  @override
  String get labelFriends => 'Amis';

  @override
  String get nintendoInfoTitle => 'Mode DNS Nintendo Switch';

  @override
  String get nintendoInfoText => 'Démarrez en mode Nintendo, configurez votre DNS et rejoignez un serveur mis en avant.';

  @override
  String get friendModeTitle => 'Mode Amis';

  @override
  String get friendModeText => 'Ajoutez les bots amis de NetherLink comme amis. Démarrez le mode Amis et jouez';

  @override
  String get selectedRelayCheck => 'Sélectionné';

  @override
  String relayFallbackWarning(Object name) {
    return 'Avertissement : le relais d\'origine n\'a pas répondu. Relais de secours utilisé : $name';
  }

  @override
  String get relayUnableConnect => 'Impossible de se connecter à un serveur relais NetherLink. Réessayez plus tard ou vérifiez votre connexion internet.';

  @override
  String get howToXboxTitle => 'Xbox / PS4-5 (LAN / Proxy)';

  @override
  String get howToXboxSubtitle => 'Jouez via diffusion LAN ou proxy';

  @override
  String get howToXboxBody => 'Comment se connecter (Xbox / PS4 / PS5) :\r\n1. Assurez-vous que l\'appareil exécutant NetherLink et votre console sont sur le même réseau local.\r\n2. Dans l\'application, saisissez l\'adresse et le port de votre serveur Minecraft puis appuyez sur \\\"Démarrer la diffusion\\\".\r\n3. Sur la console, ouvrez Minecraft → Jouer → recherchez Mondes LAN ou l\'onglet Amis puis actualisez la liste.\r\n4. Sélectionnez le serveur LAN nommé \\\"NetherLink\\\" pour rejoindre.\r\nNotes :\r\n- Si le serveur n\'apparaît pas, vérifiez que les deux appareils sont sur le même sous-réseau et que l\'application diffuse toujours.\r\n- Certains modèles de console ou routeurs peuvent bloquer la détection LAN ; essayez de modifier les paramètres de l\'application ou du routeur si nécessaire.';

  @override
  String get howToNintendoTitle => 'Nintendo Switch (mode DNS)';

  @override
  String get howToNintendoSubtitle => 'Instructions du relais DNS pour Switch';

  @override
  String get howToNintendoBody => 'Nintendo Switch — mode DNS (étape par étape) :\r\n1. Dans l\'application, activez le mode \\\"Nintendo\\\" et sélectionnez un serveur relais (EU ou US).\r\n2. Appuyez sur \\\"Envoyer la configuration DNS\\\" pour envoyer l\'IP DNS au relais.\r\n3. Sur votre Nintendo Switch, allez dans Paramètres de la console → Internet → Paramètres Internet → (votre réseau) → Modifier les paramètres → DNS et définissez le DNS primaire sur l\'IP du relais.\r\n4. Ouvrez Minecraft et rejoignez un serveur public ; vous serez redirigé vers votre serveur en utilisant le DNS du relais.\r\nNotes :\r\n- Le mode DNS ne diffuse pas de serveur LAN ; il achemine le trafic du jeu via le relais.\r\n- Réinitialisez votre DNS lorsque vous avez terminé si vous avez besoin d\'un comportement réseau normal.';

  @override
  String get howToFriendsTitle => 'Mode Amis';

  @override
  String get howToFriendsSubtitle => 'Invitez des amis et rejoignez via LAN';

  @override
  String get howToFriendsBody => 'Mode Amis — étapes rapides :\r\n1. Ajoutez le compte ami NetherLink (relay friend) sur votre console ou votre plateforme si nécessaire.\r\n2. Dans l\'application, activez le mode Amis et envoyez la configuration du relais (si applicable).\r\n3. Sur votre console, ouvrez Minecraft → Amis et recherchez Mondes LAN — votre serveur devrait y apparaître comme un monde LAN.\r\n4. Sélectionnez-le pour rejoindre votre serveur avec des amis.\r\nNotes :\r\n- Assurez-vous que vous et vos amis avez les mêmes paramètres NAT/réglages autorisant la présence des amis.\r\n- Le mode Amis dépend des fonctionnalités d\'amis de la plateforme et peut nécessiter l\'acceptation des demandes d\'ami.';

  @override
  String get helpNetherlinkTitle => 'NetherLink n\'apparaît pas';

  @override
  String get helpNetherlinkSubtitle => 'Résolution des problèmes de détection LAN';

  @override
  String get helpNetherlinkBody => 'Si le serveur n\'apparaît pas sur votre console, essayez ces étapes :\r\n\r\n✅ Vérifications de base :\r\n1. Même réseau WiFi - Votre téléphone/tablette et votre console DOIVENT être sur le même WiFi\r\n2. Adresse du serveur correcte - Vérifiez à nouveau l\'IP et le port (par défaut : 19132)\r\n3. Diffusion active - Vérifiez que NetherLink affiche l\'état \\\"En cours de diffusion\\\"\r\n\r\n🔄 Correctifs rapides :\r\n• Redémarrez l\'application : arrêtez la diffusion, fermez complètement NetherLink, rouvrez-le et réessayez\r\n• Redémarrez votre console : parfois la console a besoin d\'un rafraîchissement pour détecter les jeux LAN\r\n• Vérifiez l\'onglet Amis/LAN : le serveur apparaît sous \\\"Amis\\\" ou \\\"Jeux LAN\\\", PAS dans la liste des serveurs\r\n• Attendez 10 à 15 secondes après avoir démarré la diffusion\r\n• Désactivez les VPN : les VPN peuvent bloquer les diffusions locales\r\n\r\n⚠️ Problèmes courants :\r\n\\\"No route found for user\\\" → Assurez-vous que les deux appareils sont sur le même Wi‑Fi (évitez les réseaux invités)\r\n\\\"Unable to connect to NetherLink relay server\\\" → Vérifiez votre connexion internet / l\'état du relais\r\n\r\n📱 Vous avez toujours des problèmes ? Activez le mode débogage dans NetherLink et consultez les journaux, ou essayez un autre serveur.';

  @override
  String get helpMultiplayerFailedTitle => 'Échec de la connexion multijoueur';

  @override
  String get helpMultiplayerFailedSubtitle => 'Explication de pourquoi ce n\'est pas une erreur NetherLink';

  @override
  String get helpMultiplayerFailedBody => '⚠️ Ce n\'est pas un problème de NetherLink !\r\n\r\nNetherLink vous a redirigé avec succès vers le serveur demandé. Le message \\\"Échec de la connexion multijoueur\\\" indique que le serveur cible est actuellement inaccessible. Raisons possibles :\r\n\r\n• Le serveur Minecraft cible est hors ligne ou surchargé\r\n• Le serveur nécessite une version de client mise à jour ou une édition spécifique\r\n• Problèmes réseau entre le relais et le serveur cible\r\n\r\nEssayez de vous connecter à un autre serveur ou contactez le support du serveur. Si le problème persiste sur plusieurs serveurs, activez le mode débogage dans NetherLink et consultez les journaux.';

  @override
  String get helpNintendoDnsTitle => 'Le DNS Nintendo ne fonctionne pas';

  @override
  String get helpNintendoDnsSubtitle => 'Problèmes courants de DNS / relais';

  @override
  String get helpNintendoDnsBody => 'Si le mode DNS Nintendo ne fonctionne pas, vérifiez les points suivants :\r\n\r\n1. Confirmez que vous avez envoyé la configuration DNS depuis l\'application (Envoyer la configuration DNS).\r\n2. Vérifiez que vous avez appliqué l\'IP du relais comme DNS primaire sur la Switch.\r\n3. Assurez-vous que le serveur relais sélectionné (EU/US) est en ligne et non surchargé.\r\n4. Certains réseaux (par exemple, les portails captifs) empêchent l\'utilisation d\'un DNS personnalisé — testez sur un autre réseau.\r\n\r\nSi les problèmes persistent, activez le mode débogage et consultez les journaux ou essayez l\'alternative du mode Amis.';

  @override
  String get helpFriendsModeTitle => 'Le mode Amis ne fonctionne pas';

  @override
  String get helpFriendsModeSubtitle => 'Problèmes courants liés aux amis';

  @override
  String get helpFriendsModeBody => 'Conseils de dépannage pour le mode Amis :\r\n\r\n1. Assurez-vous que le compte ami du relais est ajouté/accepté sur la console (si nécessaire).\r\n2. Essayez de redémarrer le jeu et d\'actualiser l\'onglet Amis/LAN après avoir activé le mode Amis.\r\n\r\nSi le serveur n\'apparaît toujours pas pour vos amis, activez le mode débogage et consultez les journaux pour identifier les erreurs.';

  @override
  String get changeLanguageTitle => 'Changer la langue';

  @override
  String get changeLanguage => 'Langue';

  @override
  String get useSystemLanguage => 'Utiliser la langue du système';

  @override
  String get couldNotOpenUrl => 'Impossible d\'ouvrir l\'URL';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl'),
    Locale('tr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'NetherLink'**
  String get appName;

  /// No description provided for @console.
  ///
  /// In en, this message translates to:
  /// **'Console'**
  String get console;

  /// No description provided for @consoleOutput.
  ///
  /// In en, this message translates to:
  /// **'Console Output'**
  String get consoleOutput;

  /// No description provided for @noLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No logs yet'**
  String get noLogsYet;

  /// No description provided for @startBroadcastingToSeeOutput.
  ///
  /// In en, this message translates to:
  /// **'Start broadcasting to see output'**
  String get startBroadcastingToSeeOutput;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @joinUs.
  ///
  /// In en, this message translates to:
  /// **'Join Us'**
  String get joinUs;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @howToUseMenu.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUseMenu;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Detailed help / instructions shown in the help dialog
  ///
  /// In en, this message translates to:
  /// **'Created by {appCreator}.\n\nHow to use:\n1. Enter your Minecraft server address and port (default: 19132)\n   — or select a previously saved server from the dropdown\n2. (Optional) Choose a Relay Server (EU or US) closest to your location\n3. Click \"Start Broadcasting\" to begin\n4. On your console/device: Minecraft > Play > Friends\n5. You should see a LAN server called \"NetherLink\"\n6. Click it to join your external server via NetherLink\n\nNintendo Switch (DNS mode):\n1. Enable \"Nintendo Switch\" in the connection panel\n2. Select a Relay Server (EU or US)\n3. Click \"Send DNS Config\" — this sends your config to the relay\n   (it does NOT broadcast a LAN server)\n4. On your Switch, apply your NetherLink DNS setup and join\n   using the server entry you use for NetherLink\n\nNotes:\n- For LAN broadcasting, NetherLink and console must be on the same local network.\n- Tip: Choose the relay server closest to you for the best performance.'**
  String helpText(Object appCreator);

  /// Name of the Discord community / link label
  ///
  /// In en, this message translates to:
  /// **'Discord'**
  String get discord;

  /// Tooltip for toggling debug logging in console
  ///
  /// In en, this message translates to:
  /// **'Toggle debug'**
  String get toggleDebug;

  /// Tooltip / button text to copy console logs
  ///
  /// In en, this message translates to:
  /// **'Copy logs'**
  String get copyLogs;

  /// Button text to clear console logs or fields
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Generic cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Title for delete server confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Server'**
  String get deleteServer;

  /// Delete action label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for manage servers dialog
  ///
  /// In en, this message translates to:
  /// **'My Servers'**
  String get myServers;

  /// Subtitle for manage servers dialog
  ///
  /// In en, this message translates to:
  /// **'Quick access servers'**
  String get quickAccessServers;

  /// Add server button label / dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Server'**
  String get addServer;

  /// Hint text shown when there are no saved servers
  ///
  /// In en, this message translates to:
  /// **'Add servers to quickly connect later'**
  String get addServersHint;

  /// Form label for server name
  ///
  /// In en, this message translates to:
  /// **'Server Name *'**
  String get serverNameLabel;

  /// Form label for server address
  ///
  /// In en, this message translates to:
  /// **'Address *'**
  String get addressLabel;

  /// Form label for server port
  ///
  /// In en, this message translates to:
  /// **'Port *'**
  String get portLabel;

  /// Form label for server description
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionLabel;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Shown on splash while app initializes
  ///
  /// In en, this message translates to:
  /// **'Initializing...'**
  String get initializing;

  /// Badge text on splash screen
  ///
  /// In en, this message translates to:
  /// **'Created by NetherDev'**
  String get createdBy;

  /// Subtitle on splash screen
  ///
  /// In en, this message translates to:
  /// **'Bedrock Bridge'**
  String get bedrockBridge;

  /// Snackbar shown when clients disconnect automatically
  ///
  /// In en, this message translates to:
  /// **'Client disconnected — Broadcast stopped'**
  String get clientDisconnected;

  /// Validation message when server address field is empty
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter a server address'**
  String get pleaseEnterServer;

  /// Validation message when port is invalid
  ///
  /// In en, this message translates to:
  /// **'⚠️ Invalid port number (1-65535)'**
  String get invalidPort;

  /// Confirmation after sending DNS config to relay
  ///
  /// In en, this message translates to:
  /// **'✅ DNS config sent to relay'**
  String get dnsConfigSent;

  /// Snackbar shown when broadcasting starts
  ///
  /// In en, this message translates to:
  /// **'Broadcasting started'**
  String get broadcastingStarted;

  /// Snackbar shown when broadcasting stops
  ///
  /// In en, this message translates to:
  /// **'Broadcast stopped'**
  String get broadcastStopped;

  /// Shown when a saved server is selected
  ///
  /// In en, this message translates to:
  /// **'📋 Selected: {name}'**
  String selectedServer(Object name);

  /// Shown when a featured server is selected
  ///
  /// In en, this message translates to:
  /// **'Selected: {name}'**
  String selectedFeaturedServer(Object name);

  /// Shown when user tries to copy logs but none exist
  ///
  /// In en, this message translates to:
  /// **'No logs to copy'**
  String get noLogsToCopy;

  /// Shown after copying logs to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copied {count} log entries to clipboard'**
  String copiedLogs(Object count);

  /// Shown when debug logging is enabled/disabled
  ///
  /// In en, this message translates to:
  /// **'Debug logs enabled'**
  String get debugEnabled;

  /// No description provided for @debugDisabled.
  ///
  /// In en, this message translates to:
  /// **'Debug logs disabled'**
  String get debugDisabled;

  /// No description provided for @howToUseTitle.
  ///
  /// In en, this message translates to:
  /// **'How to use NetherLink'**
  String get howToUseTitle;

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get iUnderstand;

  /// No description provided for @playOnSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Play on Nintendo Switch'**
  String get playOnSwitchTitle;

  /// No description provided for @playWithFriendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Play with Friends'**
  String get playWithFriendsTitle;

  /// DNS instructions shown for Nintendo Switch mode
  ///
  /// In en, this message translates to:
  /// **'Selected: {relayName}\n\nHow to connect:\n1. Go to your Switch Settings and change the DNS to: {relayIp}\n2. Open Minecraft and select a server from the list (like Cubecraft or Hive).\n3. You will now be sent to your own server automatically.'**
  String playInstructionsSwitch(Object relayName, Object relayIp);

  /// Instructions shown for Friends mode
  ///
  /// In en, this message translates to:
  /// **'How to connect:\n1. On your console, add {friend} as a friend.\n2. Open Minecraft and go to the Friends tab.\n3. Look for your server under LAN Worlds and select it to join.'**
  String playInstructionsFriends(Object friend);

  /// Label text above the relay selector
  ///
  /// In en, this message translates to:
  /// **'NETHERLINK SERVER'**
  String get nldServerLabel;

  /// Accessibility label for relay selection button
  ///
  /// In en, this message translates to:
  /// **'Select relay {name}'**
  String selectRelayLabel(Object name);

  /// No description provided for @noSavedServers.
  ///
  /// In en, this message translates to:
  /// **'No saved servers'**
  String get noSavedServers;

  /// No description provided for @savedServers.
  ///
  /// In en, this message translates to:
  /// **'Saved servers'**
  String get savedServers;

  /// No description provided for @serverAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Server Address'**
  String get serverAddressHint;

  /// No description provided for @portHint.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get portHint;

  /// No description provided for @manageServers.
  ///
  /// In en, this message translates to:
  /// **'Manage servers'**
  String get manageServers;

  /// No description provided for @manageServersTooltip.
  ///
  /// In en, this message translates to:
  /// **'Manage servers'**
  String get manageServersTooltip;

  /// No description provided for @stopBroadcasting.
  ///
  /// In en, this message translates to:
  /// **'Stop Broadcasting'**
  String get stopBroadcasting;

  /// No description provided for @startNintendoMode.
  ///
  /// In en, this message translates to:
  /// **'Start Nintendo Mode'**
  String get startNintendoMode;

  /// No description provided for @startFriendsMode.
  ///
  /// In en, this message translates to:
  /// **'Start Friends Mode'**
  String get startFriendsMode;

  /// No description provided for @startBroadcasting.
  ///
  /// In en, this message translates to:
  /// **'Start Broadcasting'**
  String get startBroadcasting;

  /// No description provided for @modeLabel.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get modeLabel;

  /// No description provided for @labelXbox.
  ///
  /// In en, this message translates to:
  /// **'Xbox/PS4-5'**
  String get labelXbox;

  /// No description provided for @labelNintendo.
  ///
  /// In en, this message translates to:
  /// **'Nintendo'**
  String get labelNintendo;

  /// No description provided for @labelFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get labelFriends;

  /// No description provided for @nintendoInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Nintendo Switch DNS mode'**
  String get nintendoInfoTitle;

  /// No description provided for @nintendoInfoText.
  ///
  /// In en, this message translates to:
  /// **'Start in Nintendo mode, set your DNS and join a featured server.'**
  String get nintendoInfoText;

  /// No description provided for @friendModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Friend mode'**
  String get friendModeTitle;

  /// No description provided for @friendModeText.
  ///
  /// In en, this message translates to:
  /// **'Add NetherLink\'s friends bots as a friend. Start Friends mode and play'**
  String get friendModeText;

  /// Small label used when a relay is selected
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selectedRelayCheck;

  /// No description provided for @relayFallbackWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: original relay did not respond. Fallback relay in use: {name}'**
  String relayFallbackWarning(Object name);

  /// No description provided for @relayUnableConnect.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to ANY NetherLink relay server. Try again later or check your internet.'**
  String get relayUnableConnect;

  /// Title for the Xbox / PS4-5 how-to modal
  ///
  /// In en, this message translates to:
  /// **'Xbox / PS4-5 (LAN / Proxy)'**
  String get howToXboxTitle;

  /// Short subtitle for Xbox / PS4-5 menu tile
  ///
  /// In en, this message translates to:
  /// **'Play via LAN broadcast or proxy'**
  String get howToXboxSubtitle;

  /// Detailed steps for Xbox/PS4-5 how-to modal
  ///
  /// In en, this message translates to:
  /// **'How to connect (Xbox / PS4 / PS5):\n1. Ensure your device running NetherLink and your console are on the same local network.\n2. In the app, enter your Minecraft server address and port and press \"Start Broadcasting\".\n3. On the console open Minecraft → Play → look for LAN Worlds or the Friends tab and refresh the list.\n4. Select the LAN server named \"NetherLink\" to join.\nNotes:\n- If the server does not appear, confirm both devices are on the same subnet and that the app is still broadcasting.\n- Some console models or routers may block LAN discovery; try toggling the app or router settings if needed.'**
  String get howToXboxBody;

  /// Title for the Nintendo how-to modal
  ///
  /// In en, this message translates to:
  /// **'Nintendo Switch (DNS mode)'**
  String get howToNintendoTitle;

  /// Short subtitle for Nintendo menu tile
  ///
  /// In en, this message translates to:
  /// **'DNS relay instructions for Switch'**
  String get howToNintendoSubtitle;

  /// Detailed steps for Nintendo Switch DNS setup
  ///
  /// In en, this message translates to:
  /// **'Nintendo Switch — DNS mode (step-by-step):\n1. In the app enable \"Nintendo\" mode and select a Relay Server (EU or US).\n2. Tap \"Send DNS Config\" to push the DNS IP to the relay.\n3. On your Nintendo Switch go to System Settings → Internet → Internet Settings → (your network) → Change Settings → DNS and set the Primary DNS to the relay IP.\n4. Open Minecraft and join a public server; you will be redirected to your server using the relay DNS.\nNotes:\n- DNS mode does not broadcast a LAN server; it routes game traffic through the relay.\n- Revert your DNS after you are done if you need normal network behavior.'**
  String get howToNintendoBody;

  /// Title for the Friends-mode how-to modal
  ///
  /// In en, this message translates to:
  /// **'Friends mode'**
  String get howToFriendsTitle;

  /// Short subtitle for Friends menu tile
  ///
  /// In en, this message translates to:
  /// **'Invite friends and join via LAN'**
  String get howToFriendsSubtitle;

  /// Detailed steps for Friends mode
  ///
  /// In en, this message translates to:
  /// **'Friends mode — quick steps:\n1. Add the NetherLink friend account (relay friend) on your console or platform if required.\n2. In the app enable Friends mode and send the relay configuration (if applicable).\n3. On your console open Minecraft → Friends and search for LAN Worlds — your server should appear there as a LAN world.\n4. Select it to join your server with friends.\nNotes:\n- Make sure both you and your friends have the same NAT/settings that allow friend presence.\n- Friend-mode relies on platform friend features and may require accepting friend requests.'**
  String get howToFriendsBody;

  /// Title for help topic when NetherLink isn't visible on console
  ///
  /// In en, this message translates to:
  /// **'NetherLink does not appear'**
  String get helpNetherlinkTitle;

  /// Short subtitle for NetherLink does not appear tile
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting LAN discovery issues'**
  String get helpNetherlinkSubtitle;

  /// Detailed troubleshooting text for NetherLink not appearing
  ///
  /// In en, this message translates to:
  /// **'If the server isn\'t appearing on your console, try these steps:\n\n✅ Basic Checks:\n1. Same WiFi Network - Your phone/tablet and console MUST be on the same WiFi\n2. Correct Server Address - Double-check the IP and port (default: 19132)\n3. Broadcasting Active - Verify NetherLink shows \"Broadcasting\" status\n\n🔄 Quick Fixes:\n• Restart the app: Stop broadcasting, close NetherLink completely, reopen and try again\n• Restart your console: Sometimes the console needs a refresh to detect LAN games\n• Check Friends/LAN tab: The server appears under \"Friends\" or \"LAN Games\", NOT in server list\n• Wait 10-15 seconds after starting broadcasting\n• Disable VPNs: VPNs can block local broadcasts\n\n⚠️ Common Issues:\n\"No route found for user\" → Ensure both devices are on the same Wi‑Fi (avoid Guest networks)\n\"Unable to connect to NetherLink relay server\" → Check your internet / relay status\n\n📱 Still having issues? Enable Debug Mode in NetherLink and check logs, or try a different server.'**
  String get helpNetherlinkBody;

  /// Title for help topic when multiplayer connection fails
  ///
  /// In en, this message translates to:
  /// **'Multiplayer Connection Failed'**
  String get helpMultiplayerFailedTitle;

  /// Short subtitle for multiplayer failed tile
  ///
  /// In en, this message translates to:
  /// **'Explanation why this is not a NetherLink error'**
  String get helpMultiplayerFailedSubtitle;

  /// Explanation shown when multiplayer connection failed appears
  ///
  /// In en, this message translates to:
  /// **'⚠️ This is not an issue with NetherLink!\n\nNetherLink successfully redirected you to the requested server. The message \"Multiplayer Connection Failed\" indicates that the target server is currently unreachable. Possible reasons:\n\n• The target Minecraft server is offline or overloaded\n• The server requires an updated client version or specific edition\n• Network issues between the relay and the target server\n\nTry connecting to a different server or contact the server\'s support. If the problem persists for multiple servers, enable Debug Mode in NetherLink and check logs.'**
  String get helpMultiplayerFailedBody;

  /// Title for Nintendo DNS troubleshooting
  ///
  /// In en, this message translates to:
  /// **'Nintendo DNS does not work'**
  String get helpNintendoDnsTitle;

  /// Short subtitle for Nintendo DNS troubleshooting tile
  ///
  /// In en, this message translates to:
  /// **'Common DNS / relay issues'**
  String get helpNintendoDnsSubtitle;

  /// Detailed placeholder for Nintendo DNS troubleshooting
  ///
  /// In en, this message translates to:
  /// **'If Nintendo DNS mode isn\'t working, check the following:\n\n1. Confirm you pushed DNS config from the app (Send DNS Config).\n2. Verify you applied the relay IP as Primary DNS on the Switch.\n3. Ensure the relay server selected (EU/US) is online and not overloaded.\n4. Some networks (e.g., captive portals) prevent custom DNS — test on a different network.\n\nIf issues persist, enable Debug Mode and check logs or try the Friends-mode alternative.'**
  String get helpNintendoDnsBody;

  /// Title for Friends mode troubleshooting
  ///
  /// In en, this message translates to:
  /// **'Friends mode does not work'**
  String get helpFriendsModeTitle;

  /// Short subtitle for Friends-mode troubleshooting tile
  ///
  /// In en, this message translates to:
  /// **'Common friend issues'**
  String get helpFriendsModeSubtitle;

  /// Detailed placeholder for Friends mode troubleshooting
  ///
  /// In en, this message translates to:
  /// **'Friends mode troubleshooting tips:\n\n1. Make sure the relay friend account is added/accepted on the console (if required).\n2. Try restarting the game and refreshing the Friends/LAN tab after enabling Friends mode.\n\nIf the server still doesn\'t appear to friends, enable Debug Mode and check logs to identify errors.'**
  String get helpFriendsModeBody;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'nl', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'nl': return AppLocalizationsNl();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

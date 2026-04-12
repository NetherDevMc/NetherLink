import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../widgets/console/console_widget.dart';
import '../widgets/dialogs/language_dialog.dart';

class NavigationController {
  final String websiteUrl;
  final String discordUrl;

  final ValueNotifier<Locale?> appLocaleNotifier;

  final ValueNotifier<List<String>> logsNotifier;
  final ScrollController logsScrollController;
  final ValueNotifier<bool> debugEnabledNotifier;

  final VoidCallback? toggleDebugCallback;
  final Future<void> Function()? copyLogsCallback;
  final VoidCallback? clearLogsCallback;

  final ValueNotifier<bool> consoleOpen = ValueNotifier<bool>(false);

  final Future<void> Function(
    BuildContext context, {
    required bool isFriendsMode,
  })?
  showDnsInfoModalCallback;
  final VoidCallback? showXboxHelpCallback;
  final void Function(BuildContext context)? showHowToMenuCallback;
  final void Function(BuildContext context)? showHelpMenuCallback;

  NavigationController({
    required this.websiteUrl,
    required this.discordUrl,
    required this.appLocaleNotifier,
    required this.logsNotifier,
    required this.logsScrollController,
    required this.debugEnabledNotifier,
    this.toggleDebugCallback,
    this.copyLogsCallback,
    this.clearLogsCallback,
    this.showDnsInfoModalCallback,
    this.showXboxHelpCallback,
    this.showHowToMenuCallback,
    this.showHelpMenuCallback,
  });

  Future<void> openWebsite(BuildContext context) async {
    final loc = AppLocalizations.of(context);
    final url = websiteUrl;
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
      return;
    }
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
    }
  }

  Future<void> openWebsiteWithCustomUrl(
    BuildContext context,
    String url,
  ) async {
    final loc = AppLocalizations.of(context);
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
      return;
    }
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc?.couldNotOpenUrl ?? 'Could not open website'),
        ),
      );
    }
  }

  Future<void> openDiscord(BuildContext context) async {
    final uri = Uri.tryParse(discordUrl);
    final loc = AppLocalizations.of(context);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc?.couldNotOpenUrl ?? 'Could not open url')),
      );
      return;
    }
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc?.couldNotOpenUrl ?? 'Could not open url')),
      );
    }
  }

  Future<void> showLanguageDialog(BuildContext context) async {
    await LanguageDialog.show(context, appLocaleNotifier: appLocaleNotifier);
  }

  Future<void> showConsole(BuildContext context) async {
    if (consoleOpen.value) return;
    consoleOpen.value = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConsoleDialog(
        logsNotifier: logsNotifier,
        scrollController: logsScrollController,
        debugEnabled: debugEnabledNotifier.value,
        onToggleDebug: () {
          if (toggleDebugCallback != null) {
            toggleDebugCallback!();
          }
        },
        onClearLogs: () {
          if (clearLogsCallback != null) {
            clearLogsCallback!();
          }
        },
        onCopyLogs: () {
          if (copyLogsCallback != null) {
            copyLogsCallback!();
          }
        },
      ),
    );
    consoleOpen.value = false;
  }

  void showHowToMenu(BuildContext context) {
    if (showHowToMenuCallback != null) {
      showHowToMenuCallback!(context);
      return;
    }
  }

  void showHelpMenu(BuildContext context) {
    if (showHelpMenuCallback != null) {
      showHelpMenuCallback!(context);
      return;
    }
  }

  Future<void> showDnsInfoModal(
    BuildContext context, {
    required bool isFriendsMode,
  }) async {
    if (showDnsInfoModalCallback != null) {
      await showDnsInfoModalCallback!(context, isFriendsMode: isFriendsMode);
    }
  }

  void showXboxHelp() {
    if (showXboxHelpCallback != null) showXboxHelpCallback!();
  }
}

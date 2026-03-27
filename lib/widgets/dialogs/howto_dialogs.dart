import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'info_dialog.dart';
import '../buttons/themed_button.dart';

class HowToDialogs {
  static Future<void> showXboxInstructions(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.howToXboxTitle,
      content: loc.howToXboxBody,
      actions: [
        ThemedButton(
          onPressed: () => Navigator.of(context).pop(),
          variant: ThemedButtonVariant.primary,
          child: Text(
            loc.ok,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  static Future<void> showNintendoInstructions(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.howToNintendoTitle,
      content: loc.howToNintendoBody,
      actions: [
        ThemedButton(
          onPressed: () => Navigator.of(context).pop(),
          variant: ThemedButtonVariant.primary,
          child: Text(
            loc.ok,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  static Future<void> showFriendsInstructions(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.howToFriendsTitle,
      content: loc.howToFriendsBody,
      actions: [
        ThemedButton(
          onPressed: () => Navigator.of(context).pop(),
          variant: ThemedButtonVariant.primary,
          child: Text(
            loc.ok,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

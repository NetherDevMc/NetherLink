import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'info_dialog.dart';
import '../buttons/themed_button.dart';

class HelpDialogs {
  static Future<void> showNetherlinkNotAppearing(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.helpNetherlinkTitle,
      content: loc.helpNetherlinkBody,
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

  static Future<void> showMultiplayerConnectionFailed(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.helpMultiplayerFailedTitle,
      content: loc.helpMultiplayerFailedBody,
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

  static Future<void> showNintendoDns(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.helpNintendoDnsTitle,
      content: loc.helpNintendoDnsBody,
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

  static Future<void> showFriendsMode(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return InfoDialog.show(
      context,
      title: loc.helpFriendsModeTitle,
      content: loc.helpFriendsModeBody,
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

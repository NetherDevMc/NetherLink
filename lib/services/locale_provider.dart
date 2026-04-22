import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import '../l10n/app_localizations.dart';

final ValueNotifier<Locale?> appLocale = ValueNotifier<Locale?>(null);

const String _fileName = 'locale.json';

Future<File> _getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/$_fileName');
}

Future<void> loadSavedLocale() async {
  try {
    final file = await _getFile();
    if (!await file.exists()) return;

    final String contents = await file.readAsString();
    final Map<String, dynamic> decoded = jsonDecode(contents);
    final String? languageCode = decoded['languageCode'];
    if (languageCode != null && languageCode.isNotEmpty) {
      final supported = AppLocalizations.supportedLocales.any(
        (l) => l.languageCode == languageCode,
      );
      if (supported) {
        appLocale.value = Locale(languageCode);
      } else {
        appLocale.value = const Locale('en');
      }
    }
  } catch (e) {
    return;
  }
}

Future<void> setLocale(Locale locale) async {
  appLocale.value = locale;
  final file = await _getFile();
  await file.writeAsString(jsonEncode({'languageCode': locale.languageCode}));
}

Future<void> clearSavedLocale() async {
  try {
    final file = await _getFile();
    if (await file.exists()) await file.delete();
  } catch (e) {
    return;
  }
}

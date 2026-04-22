import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'services/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadSavedLocale();
  runApp(const NetherLinkApp());
}

class NetherLinkApp extends StatelessWidget {
  const NetherLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'NetherLink',
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback:
              (Locale? platformLocale, Iterable<Locale> supportedLocales) {
                if (locale != null) return locale;

                if (platformLocale != null) {
                  for (final supported in supportedLocales) {
                    if (supported.languageCode == platformLocale.languageCode) {
                      return supported;
                    }
                  }
                }

                return const Locale('en');
              },
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
          theme: AppTheme.darkTheme,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

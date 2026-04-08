import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/locale_provider.dart';
import '../buttons/themed_button.dart';

class LanguageDialog {
  static Future<void> show(
    BuildContext context, {
    required ValueNotifier<Locale?> appLocaleNotifier,
    bool barrierDismissible = true,
  }) {
    final loc = AppLocalizations.of(context)!;

    const Color dialogPurple = Color.fromARGB(255, 20, 13, 32);
    const Color dialogPurpleDark = Color.fromARGB(255, 19, 14, 38);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: _LanguageDialogContent(
              title: loc.changeLanguageTitle,
              supportedLocales: AppLocalizations.supportedLocales,
              appLocaleNotifier: appLocaleNotifier,
              dialogPurple: dialogPurple,
              dialogPurpleDark: dialogPurpleDark,
              loc: loc,
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageDialogContent extends StatefulWidget {
  final String title;
  final List<Locale> supportedLocales;
  final ValueNotifier<Locale?> appLocaleNotifier;
  final Color dialogPurple;
  final Color dialogPurpleDark;
  final AppLocalizations loc;

  const _LanguageDialogContent({
    Key? key,
    required this.title,
    required this.supportedLocales,
    required this.appLocaleNotifier,
    required this.dialogPurple,
    required this.dialogPurpleDark,
    required this.loc,
  }) : super(key: key);

  @override
  State<_LanguageDialogContent> createState() => _LanguageDialogContentState();
}

class _LanguageDialogContentState extends State<_LanguageDialogContent> {
  static const double _horizontalPadding = 18.0;
  static const double _headerBottomGap = 12.0;
  static const double _actionsTopGap = 14.0;
  static const double _titleFontSize = 18.5;
  static const double _bodyFontSize = 15.0;

  static final Map<String, String> _globalLanguageNameCache = {};

  final Map<String, String> _names = {};
  bool _loading = true;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _loadAllNames();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _loadAllNames() async {
    final locales = widget.supportedLocales;
    final futures = locales.map((locale) => _loadNameForLocale(locale)).toList();
    final results = await Future.wait(futures);
    if (_disposed) return;
    for (var i = 0; i < locales.length; i++) {
      _names[_localeTag(locales[i])] = results[i];
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  String _localeTag(Locale locale) => locale.toLanguageTag();

  Future<String> _loadNameForLocale(Locale locale) async {
    final tag = _localeTag(locale);

    if (_globalLanguageNameCache.containsKey(tag)) {
      return _globalLanguageNameCache[tag]!;
    }

    try {
      final locFor = await AppLocalizations.delegate.load(locale);
      final dynamic dyn = locFor.language;
      final name = (dyn is String && dyn.trim().isNotEmpty) ? dyn : tag;
      _globalLanguageNameCache[tag] = name;
      return name;
    } catch (e) {
      _globalLanguageNameCache[tag] = tag;
      return tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final maxDialogWidth = math.min(760.0, screenW - 40.0);
    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    return Container(
      padding: const EdgeInsets.all(_horizontalPadding),
      constraints: BoxConstraints(
        maxWidth: maxDialogWidth,
        maxHeight: maxHeight,
        minWidth: 220.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.dialogPurple.withOpacity(0.98),
            widget.dialogPurpleDark.withOpacity(0.98),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.dialogPurpleDark.withOpacity(0.24)),
        boxShadow: [
          BoxShadow(
            color: widget.dialogPurpleDark.withOpacity(0.20),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: _titleFontSize,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ),
              Material(
                color: Colors.white12,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.95),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: _headerBottomGap),

          if (_loading)
            const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                ),
              ),
            )
          else
            Flexible(
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: _bodyFontSize,
                  height: 1.6,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.48,
                    minHeight: 0,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.supportedLocales.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: Colors.white12),
                    itemBuilder: (context, idx) {
                      final locale = widget.supportedLocales[idx];
                      final tag = _localeTag(locale);
                      final displayName =
                          _names[tag] ?? _globalLanguageNameCache[tag] ?? tag;

                      final currentCode =
                          widget.appLocaleNotifier.value?.languageCode ??
                          WidgetsBinding.instance.window.locale.languageCode;

                      final isSelected = currentCode == locale.languageCode;

                      return RadioListTile<Locale>(
                        value: locale,
                        groupValue: widget.appLocaleNotifier.value,
                        activeColor: Colors.white,
                        onChanged: (chosen) async {
                          if (chosen != null) {
                            await setLocale(chosen);
                          }
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        title: Text(
                          displayName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        secondary: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      );
                    },
                  ),
                ),
              ),
            ),

          const SizedBox(height: _actionsTopGap),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ThemedButton(
                onPressed: () async {
                  await clearSavedLocale();
                  widget.appLocaleNotifier.value = null;
                  if (context.mounted) Navigator.of(context).pop();
                },
                variant: ThemedButtonVariant.subtle,
                child: Text(
                  widget.loc.useSystemLanguage,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 8),
              ThemedButton(
                onPressed: () => Navigator.of(context).pop(),
                variant: ThemedButtonVariant.primary,
                child: Text(
                  widget.loc.cancel,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../services/locale_provider.dart';

class LanguageDialog {
  static Future<void> show(
    BuildContext context, {
    required ValueNotifier<Locale?> appLocaleNotifier,
    bool barrierDismissible = true,
  }) {
    final loc = AppLocalizations.of(context)!;

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
  final AppLocalizations loc;

  const _LanguageDialogContent({
    required this.title,
    required this.supportedLocales,
    required this.appLocaleNotifier,
    required this.loc,
  });

  @override
  State<_LanguageDialogContent> createState() => _LanguageDialogContentState();
}

class _LanguageDialogContentState extends State<_LanguageDialogContent> {
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
    final results = await Future.wait(
      locales.map((l) => _loadNameForLocale(l)),
    );
    if (_disposed) return;
    for (var i = 0; i < locales.length; i++) {
      _names[_tag(locales[i])] = results[i];
    }
    if (mounted) setState(() => _loading = false);
  }

  String _tag(Locale locale) => locale.toLanguageTag();

  Future<String> _loadNameForLocale(Locale locale) async {
    final tag = _tag(locale);
    if (_globalLanguageNameCache.containsKey(tag)) {
      return _globalLanguageNameCache[tag]!;
    }
    try {
      final locFor = await AppLocalizations.delegate.load(locale);
      final dynamic dyn = locFor.language;
      final name = (dyn is String && dyn.trim().isNotEmpty) ? dyn : tag;
      _globalLanguageNameCache[tag] = name;
      return name;
    } catch (_) {
      _globalLanguageNameCache[tag] = tag;
      return tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final maxWidth = math.min(480.0, screenW - 40.0);
    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        minWidth: 220,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF13102A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          Container(height: 1, color: Colors.white.withOpacity(0.08)),
          if (_loading)
            const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white38),
                  strokeWidth: 2,
                ),
              ),
            )
          else
            Flexible(child: _buildList(context)),
          Container(height: 1, color: Colors.white.withOpacity(0.08)),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.language,
                color: Colors.white.withOpacity(0.8),
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close_rounded,
              color: Colors.white.withOpacity(0.4),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 6),
      itemCount: widget.supportedLocales.length,
      itemBuilder: (context, idx) {
        final locale = widget.supportedLocales[idx];
        final tag = _tag(locale);
        final displayName = _names[tag] ?? _globalLanguageNameCache[tag] ?? tag;

        final currentCode =
            widget.appLocaleNotifier.value?.languageCode ??
            WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        final isSelected = currentCode == locale.languageCode;

        return _LanguageTile(
          displayName: displayName,
          isSelected: isSelected,
          onTap: () async {
            await setLocale(locale);
            if (context.mounted) Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: _footerButton(
              context,
              icon: FontAwesomeIcons.xmark,
              label: widget.loc.cancel,
              color: Colors.white,
              filled: true,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerButton(
    BuildContext context, {
    required FaIconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: filled
                ? Colors.white.withOpacity(0.10)
                : Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withOpacity(filled ? 0.18 : 0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, size: 12, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String displayName;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.displayName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSelected ? null : onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: Colors.white.withOpacity(0.15))
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayName,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

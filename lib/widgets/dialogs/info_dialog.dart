import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../buttons/themed_button.dart';

class InfoDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    final loc = AppLocalizations.of(context)!;

    const Color dialogPurple = Color.fromARGB(255, 20, 13, 32);
    const Color dialogPurpleDark = Color.fromARGB(255, 19, 14, 38);

    final defaultActions = [
      ThemedButton(
        onPressed: () => Navigator.of(context).pop(),
        variant: ThemedButtonVariant.primary,
        child: Text(
          loc.ok,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    ];

    List<Widget> buildActions() {
      final raw = actions ?? defaultActions;
      return raw.map((w) => _convertAction(w)).toList();
    }

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
            child: _InfoDialogContent(
              title: title,
              content: content,
              actions: buildActions(),
              dialogPurple: dialogPurple,
              dialogPurpleDark: dialogPurpleDark,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _convertAction(Widget w) {
    if (w is ThemedButton) return w;

    if (w is ElevatedButton) return w;

    if (w is OutlinedButton) return w;

    if (w is TextButton) {
      final child = w.child;
      String label = '';
      if (child is Text) label = child.data ?? '';
      final onPressed = w.onPressed;
      return ThemedButton(
        onPressed: onPressed,
        variant: ThemedButtonVariant.subtle,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      );
    }

    if (w is Text) {
      return ThemedButton(
        onPressed: null,
        variant: ThemedButtonVariant.subtle,
        child: w,
      );
    }

    return w;
  }
}

class _InfoDialogContent extends StatefulWidget {
  final String title;
  final String content;
  final List<Widget> actions;
  final Color dialogPurple;
  final Color dialogPurpleDark;

  const _InfoDialogContent({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
    required this.dialogPurple,
    required this.dialogPurpleDark,
  }) : super(key: key);

  @override
  State<_InfoDialogContent> createState() => _InfoDialogContentState();
}

class _InfoDialogContentState extends State<_InfoDialogContent> {
  late final ScrollController _scrollController;

  static const double _horizontalPadding = 18.0;
  static const double _verticalPadding = 18.0;
  static const double _headerBottomGap = 12.0;
  static const double _actionsTopGap = 14.0;
  static const double _titleFontSize = 18.5;
  static const double _bodyFontSize = 15.0;

  static const double _actionsHeightEstimate = 56.0;

  static const double _heightBuffer = 6.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _measureTextHeight(String text, TextStyle style, double maxWidth) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: null,
    );
    tp.layout(maxWidth: maxWidth);
    return tp.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final maxDialogWidth = math.min(760.0, screenW - 40.0);
    final contentMaxWidth = maxDialogWidth - (_horizontalPadding * 2);

    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    final titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: _titleFontSize,
      fontWeight: FontWeight.w800,
      height: 1.1,
    );
    final bodyStyle = const TextStyle(
      color: Colors.white,
      fontSize: _bodyFontSize,
      height: 1.6,
    );

    final titleHeight = _measureTextHeight(
      widget.title,
      titleStyle,
      contentMaxWidth,
    );
    final bodyHeight = _measureTextHeight(
      widget.content,
      bodyStyle,
      contentMaxWidth,
    );

    final estimatedTotalHeight =
        _verticalPadding * 2 +
        titleHeight +
        _headerBottomGap +
        bodyHeight +
        _actionsTopGap +
        _actionsHeightEstimate;

    final useScroll = estimatedTotalHeight + _heightBuffer > maxHeight;

    final containerMaxWidth = maxDialogWidth;
    final calculatedHeight = useScroll
        ? maxHeight
        : (estimatedTotalHeight + _heightBuffer);

    final containerMaxHeightClamped = math.min(calculatedHeight, maxHeight);
    final containerMinHeight = useScroll
        ? 0.0
        : math.max(120.0, calculatedHeight);

    return Container(
      padding: const EdgeInsets.all(_horizontalPadding),
      constraints: BoxConstraints(
        maxWidth: containerMaxWidth,
        minHeight: containerMinHeight,
        maxHeight: containerMaxHeightClamped,
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
              Expanded(child: Text(widget.title, style: titleStyle)),
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
          if (!useScroll) ...[
            DefaultTextStyle(
              style: bodyStyle,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(widget.content),
              ),
            ),
          ] else ...[
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                radius: const Radius.circular(6),
                thickness: 6,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: DefaultTextStyle(
                    style: bodyStyle,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(widget.content),
                    ),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: _actionsTopGap),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: w,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

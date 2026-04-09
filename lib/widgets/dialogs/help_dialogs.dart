import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../l10n/app_localizations.dart';

class HelpDialogs {
  static Future<void> showNetherlinkNotAppearing(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return _showDialog(
      context,
      icon: FontAwesomeIcons.wifi,
      color: const Color(0xFF3B82F6),
      title: loc.helpNetherlinkTitle,
      steps: [loc.helpNetherlinkBody],
    );
  }

  static Future<void> showMultiplayerConnectionFailed(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return _showDialog(
      context,
      icon: FontAwesomeIcons.triangleExclamation,
      color: const Color(0xFFF59E0B),
      title: loc.helpMultiplayerFailedTitle,
      steps: [loc.helpMultiplayerFailedBody],
    );
  }

  static Future<void> showNintendoDns(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return _showDialog(
      context,
      icon: FontAwesomeIcons.gamepad,
      color: const Color(0xFFE4000F),
      title: loc.helpNintendoDnsTitle,
      steps: [loc.helpNintendoDnsBody],
    );
  }

  static Future<void> showFriendsMode(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return _showDialog(
      context,
      icon: FontAwesomeIcons.userGroup,
      color: const Color(0xFF7C3AED),
      title: loc.helpFriendsModeTitle,
      steps: [loc.helpFriendsModeBody],
    );
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required FaIconData icon,
    required Color color,
    required String title,
    required List<String> steps,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF13102A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Center(child: FaIcon(icon, color: color, size: 18)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(height: 1, color: Colors.white.withOpacity(0.08)),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 360),
                child: SingleChildScrollView(child: _buildSteps(steps, color)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color.withOpacity(0.15),
                    foregroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: color.withOpacity(0.4)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    AppLocalizations.of(context)?.iUnderstand ?? 'Got it',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSteps(List<String> steps, Color accentColor) {
    final lines = steps.expand((s) => s.split('\n')).toList();
    final widgets = <Widget>[];

    for (final raw in lines) {
      final line = raw.trim();
      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 6));
        continue;
      }

      final stepMatch = RegExp(r'^(\d+)\.\s+(.+)$').firstMatch(line);
      if (stepMatch != null) {
        widgets.add(
          _StepRow(
            number: int.parse(stepMatch.group(1)!),
            text: stepMatch.group(2)!,
            color: accentColor,
          ),
        );
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      if (line.startsWith('- ') || line.startsWith('– ')) {
        widgets.add(_NoteRow(text: line.substring(2)));
        widgets.add(const SizedBox(height: 6));
        continue;
      }

      if (line.endsWith(':') || line == line.toUpperCase()) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 6),
            child: Text(
              line,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        );
        continue;
      }

      widgets.add(
        Text(
          line,
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 13,
            height: 1.5,
          ),
        ),
      );
      widgets.add(const SizedBox(height: 4));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;
  final Color color;

  const _StepRow({
    required this.number,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _NoteRow extends StatelessWidget {
  final String text;
  const _NoteRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

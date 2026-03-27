import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum ThemedButtonVariant { primary, subtle, outline }

class ThemedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ThemedButtonVariant variant;

  const ThemedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.variant = ThemedButtonVariant.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ThemedButtonVariant.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        );
      case ThemedButtonVariant.subtle:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white24,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        );
      case ThemedButtonVariant.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white24),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: child,
        );
    }
  }
}

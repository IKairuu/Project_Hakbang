import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';

class AuthGradientBg extends StatelessWidget {
  const AuthGradientBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.0, -1.2),
              radius: 1.2,
              colors: [
                AppColors.accent.withValues(alpha: 0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

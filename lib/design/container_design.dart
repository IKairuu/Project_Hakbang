import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';

class ContainerDesign {
  static final BoxDecoration startImage = BoxDecoration(
    color: AppColors.accent,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.accent.withValues(alpha: 153),
        blurRadius: 10,
        spreadRadius: 1,
      ),
    ],
  );

  static final BoxDecoration schoolDiscovery = BoxDecoration(
    color: Color(0xFF152034),
    borderRadius: BorderRadius.circular(30),
  );

  static final BoxDecoration scholarshipAiDesign = BoxDecoration(
    color: Color(0xFF2a1b34),
    borderRadius: BorderRadius.circular(30),
  );

  static final BoxDecoration universitySections = BoxDecoration(
    color: Color(0xFF1c1e27),
    borderRadius: BorderRadius.circular(20),
  );

  static final BoxDecoration homeAvatar = BoxDecoration(
    color: Color(0xFF232a17),
    borderRadius: BorderRadius.circular(20),
    border: BoxBorder.all(color: AppColors.accent),
  );

  static final BoxDecoration reviewUpg = BoxDecoration(
    boxShadow: [
      BoxShadow(color: Color(0xFF21375d)),
      BoxShadow(color: Colors.black.withOpacity(0.5)),
    ],
    borderRadius: BorderRadius.circular(20),
    gradient: RadialGradient(
      center: Alignment(0.2, -0.5),
      colors: [
        Color(0xFF1E3A8A), // glow color
        Color(0xFF0B1A2B),
      ],
    ),
  );

  static final BoxDecoration activityContainers = BoxDecoration(
    color: Color(0xFF1c1e27),
    borderRadius: BorderRadius.circular(20),
  );

  static final BoxDecoration activityIconContainer = BoxDecoration(
    color: Color(0xFF232f47),
    borderRadius: BorderRadius.circular(20),
  );

  static final BoxDecoration signupSelectionOption = BoxDecoration(
    color: Color(0xFF2a2d38),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Color.fromARGB(255, 60, 61, 67), width: 1),
    boxShadow: [
      BoxShadow(
        color: AppColors.accent.withValues(alpha: 0.15),
        blurRadius: 15,
        spreadRadius: 3,
      ),
    ],
  );

  static final BoxDecoration signupSelectionOptionSelected = BoxDecoration(
    color: AppColors.accent.withAlpha(105),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: AppColors.accent, width: 2),
    boxShadow: [
      BoxShadow(
        color: AppColors.accent.withValues(alpha: 0.15),
        blurRadius: 15,
        spreadRadius: 3,
      ),
    ],
  );

  static final BoxDecoration signupOccupationOptionUnselected = BoxDecoration(
    color: Color(0xFF2a2d38),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Color.fromARGB(255, 60, 61, 67), width: 1),
  );

  static final BoxDecoration universityLocation = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Color(0xFF0c1621),
  );

  static final BoxDecoration pillTagOccupation = BoxDecoration(
    color: AppColors.accent.withAlpha(69),
    borderRadius: BorderRadius.circular(20),
  );

  static final BoxDecoration pillTagGrade = BoxDecoration(
    color: Color.fromARGB(69, 0, 83, 151),
    borderRadius: BorderRadius.circular(20),
  );

  static final BoxDecoration scholarCards = BoxDecoration(
    color: Color(0xFF1a0f2e),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Color(0xFF7C3AED).withOpacity(0.35), width: 1.2),
  );

  static final BoxDecoration homeButton = BoxDecoration(
    color: AppColors.surface4,
    borderRadius: BorderRadius.circular(20),
    border: BoxBorder.all(color: AppColors.border2),
  );
}

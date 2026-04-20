import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ContainerDesign {
  static final BoxDecoration startImage = BoxDecoration(
    color: Color(0xFFC8FF4D),
    borderRadius: BorderRadius.circular(35),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFC8FF4D).withValues(alpha: 153),
        blurRadius: 25,
        spreadRadius: 2,
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
    border: BoxBorder.all(color: Color(0xFFc8ff4d)),
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
        color: Color(0xFFC8FF4D).withValues(alpha: 0.15),
        blurRadius: 15,
        spreadRadius: 3,
      ),
    ],
  );

  static final BoxDecoration signupSelectionOptionSelected = BoxDecoration(
    color: Color.fromARGB(105, 198, 255, 75),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Color(0xFFC8FF4D), width: 2),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFC8FF4D).withValues(alpha: 0.15),
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
    color: Color.fromARGB(69, 199, 255, 77),
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
}

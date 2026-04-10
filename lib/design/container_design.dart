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
    borderRadius: BorderRadius.circular(20),
    gradient: RadialGradient(
      center: Alignment(0.8, -0.6),
      colors: [
        Color(0xFF1E3A8A), // glow color
        Color(0xFF0B1A2B),
      ],
    ),
  );
}

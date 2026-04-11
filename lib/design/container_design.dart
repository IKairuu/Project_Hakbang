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

  static final BoxDecoration signupSelectionOption = BoxDecoration(
    color: Color(0xFF2a2d38),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Color.fromARGB(255, 60, 61, 67),
      width: 1,
    ),
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
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Color(0xFFC8FF4D),
      width: 2,
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFC8FF4D).withValues(alpha: 0.15),
        blurRadius: 15,
        spreadRadius: 3,
      ),
    ],
  );

  static final BoxDecoration signupIdentityOptionUnselected = BoxDecoration(
    color: Color(0xFF2a2d38),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Color.fromARGB(255, 60, 61, 67),
      width: 1,
    ),
  );
}

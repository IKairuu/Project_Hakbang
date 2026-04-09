import 'package:flutter/material.dart';

class ButtonDesign {
  static final ButtonStyle getStarted = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFC8FF4D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // Sign Up button - lime green
  static final ButtonStyle signUpButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFC8FF4D),
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  // Sign Up button - disabled/loading state (grayed out)
  static final ButtonStyle signUpButtonDisabled = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF68703d),
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  // Sign Up button - pressed state (darker shade)
  static final ButtonStyle signUpButtonPressed = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFB0D235),
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 8,
    shadowColor: const Color(0xFFC8FF4D),
  );
}

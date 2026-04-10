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
}

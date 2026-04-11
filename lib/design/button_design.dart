import 'package:flutter/material.dart';

class ButtonDesign {
  static final ButtonStyle getStarted = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFC8FF4D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // Sign Up button 
  static final ButtonStyle signUpButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFC8FF4D),
    minimumSize: const Size(double.infinity, 52),
    padding: const EdgeInsets.symmetric(vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );

  // Back Button
  static final ButtonStyle backButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF0c0d10),

    minimumSize: const Size(double.infinity, 52),

    elevation: 0,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Color.fromARGB(255, 104, 104, 104),
        width: 1,
      ),
    ),
  );
}

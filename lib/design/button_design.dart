import 'package:flutter/material.dart';

class ButtonDesign {
  static final ButtonStyle mainButton = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFC8FF4D),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Sign Up button - lime green
  static final ButtonStyle signUpButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFC8FF4D),
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
  );

  static final ButtonStyle findSchoolsContainer = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF152034),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(15),
  );
  static final ButtonStyle scholarhipContainer = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF231833),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(15),
  );
  static final ButtonStyle examHubContainer = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF301b19),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(15),
  );
  static final ButtonStyle askgabayContainer = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF232a17),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(15),
  );
}

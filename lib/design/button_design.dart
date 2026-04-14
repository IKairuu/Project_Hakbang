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

  static final ButtonStyle filterUniversitySelected = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    backgroundColor: Color(0xFF232a17),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xFFc6fd4c)),
      borderRadius: BorderRadiusGeometry.circular(20),
    ),
  );

  static final ButtonStyle filterUniversityUnselected =
      ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        backgroundColor: Color(0xFF1c1e27),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF2a2c35)),
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
      );

  static final ButtonStyle collegeSection = ElevatedButton.styleFrom();

  // Checkbox design - lime green when checked
  static final CheckboxThemeData checkboxDesign = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFC8FF4D); // Lime green when checked
      }
      return const Color(0xFF343943); // Dark gray when unchecked
    }),
    checkColor: WidgetStateProperty.all(Colors.black),
    side: const BorderSide(color: Color(0xFF343943), width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  static final ButtonStyle alertDialog = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFC8FF4D),
    padding: EdgeInsets.all(5),
  );
}

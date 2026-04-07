import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  static final TextStyle mainHeadingLeft = GoogleFonts.unbounded(
    color: Colors.white,
    fontSize: 35,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle mainHeadingRight = GoogleFonts.unbounded(
    color: Color(0xFFC8FF4D),
    fontSize: 35,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
  );
  static final TextStyle appDetails = TextStyle(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle getStarted = GoogleFonts.dmSans(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle memberSignIn = TextStyle(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle signIntext = GoogleFonts.dmSans(
    color: Color(0xFFC8FF4D),
    fontWeight: FontWeight.w700,
  );
}

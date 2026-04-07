import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  static final TextStyle mainHeadingLeft = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 50,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle mainHeadingRight = GoogleFonts.dmSans(
    color: Color(0xFFC8FF4D),
    fontSize: 50,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
  );
  static final TextStyle app_details = TextStyle(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );
}

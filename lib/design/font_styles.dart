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
  static final TextStyle appDetails = GoogleFonts.inter(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle getStarted = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle memberSignIn = GoogleFonts.inter(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle textButtonStyle = GoogleFonts.inter(
    color: Color(0xFFC8FF4D),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle schoolDiscovery = TextStyle(
    fontWeight: FontWeight.w800,
    color: Color(0xFF447cdc),
  );

  static final TextStyle header = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 35,
  );

  static final TextStyle scholarshipAiText = TextStyle(
    fontWeight: FontWeight.w800,
    color: Color(0xFFa755f6),
  );

  static final TextStyle schoolNames = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle schoolLocation = GoogleFonts.inter(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );

  static final TextStyle mainPageheader = GoogleFonts.inter(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );
  static final TextStyle mainPageUnderName = GoogleFonts.inter(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  static final TextStyle upgNumber = TextStyle(
    color: Color(0xFF4d8fff),
    fontSize: 35,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle savedSchoolNumber = TextStyle(
    color: Color(0xFFc8ff4d),
    fontSize: 35,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle labelMainPage = TextStyle(
    color: Color(0xFF4e5565),
    fontSize: 10,
  );

  static final TextStyle reviewUpg = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static final mainPageButtonLabels = TextStyle(
    color: Color(0xFF74757a),
    fontSize: 10,
  );
}

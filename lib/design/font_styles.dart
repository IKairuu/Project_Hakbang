import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class FontStyles {
  // HEADING
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
  static final TextStyle obSlideDesc = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xF0F1F5).withOpacity(0.65),
  );

  static final TextStyle homeGreeting = GoogleFonts.dmSans(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static final TextStyle appDetails = GoogleFonts.dmSans(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle getStarted = GoogleFonts.dmSans(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle memberSignIn = GoogleFonts.dmSans(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle textButtonStyle = GoogleFonts.dmSans(
    color: Color(0xFFC8FF4D),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle schoolDiscovery = TextStyle(
    fontWeight: FontWeight.w800,
    color: Color(0xFF447cdc),
  );

  static final TextStyle header = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 35,
  );

  static final TextStyle scholarshipAiText = TextStyle(
    fontWeight: FontWeight.w800,
    color: Color(0xFFa755f6),
  );

  static final TextStyle schoolNames = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle schoolLocation = GoogleFonts.dmSans(
    color: Color(0xFF828a8a),
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );

  static final TextStyle mainPageheader = GoogleFonts.dmSans(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );
  static final TextStyle mainPageUnderName = GoogleFonts.dmSans(
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

  static final recentActivityLabel = TextStyle(
    color: Colors.white,
    fontSize: 20,
    letterSpacing: -0.3,
    fontWeight: FontWeight.w800,
  );

  static final activityDescriptionStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static final activityDateStyle = TextStyle(
    color: Color(0xFF7e7f87),
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle signIntext = GoogleFonts.inter(
    color: Color(0xFFC8FF4D),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle discoveryHeader = GoogleFonts.dmSans(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 27,
  );

  static final TextStyle filterLabel = TextStyle(
    color: Color(0xFFc6fd4c),
    fontWeight: FontWeight.w700,
  );
}

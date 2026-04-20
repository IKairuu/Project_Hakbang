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
    fontSize: 30,
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
    color: Colors.white,
    fontSize: 10,
  );

  static final TextStyle reviewUpg = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle availScholars = TextStyle(
    color: Color(0xFFA855F7),
    fontSize: 35,
    fontWeight: FontWeight.w500,
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
  static final TextStyle highlightText = GoogleFonts.dmSans(
    color: Color(0xFFC8FF4D),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle discoveryHeader = GoogleFonts.dmSans(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 27,
  );

  static final TextStyle filterLabelSelected = TextStyle(
    color: Color(0xFFc6fd4c),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle filterLabelUnselected = TextStyle(
    color: Color(0xFF7d7e86),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle availSchoolsLabel = GoogleFonts.inter(
    fontSize: 15,
    color: Color(0xFF7d7e81),
    fontWeight: FontWeight.w700,
  );

  static final TextStyle mapLabel = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle inputLabel = GoogleFonts.dmSans(
    color: Color.fromARGB(255, 97, 105, 109),
    fontSize: 10,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle stepSubtitle = GoogleFonts.dmSans(
    color: Color.fromARGB(255, 97, 105, 109),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle inputText = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle occupationTitle = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle occupationSubtitle = GoogleFonts.dmSans(
    color: Color.fromARGB(255, 150, 150, 150),
    fontSize: 10,
  );

  static final TextStyle avatarText = GoogleFonts.dmSans(fontSize: 24);

  static final TextStyle previewName = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle previewEmail = GoogleFonts.dmSans(
    color: const Color(0xFF9FA1A8),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle previewPillText = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle collegeLabel = GoogleFonts.dmSans(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static final TextStyle addressLabel = GoogleFonts.dmSans(
    color: Color(0xFF7d7e86),
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  static final TextStyle continueButton = GoogleFonts.dmSans(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle backButton = GoogleFonts.dmSans(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle scholarshipTitle = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static final TextStyle scholarShipSubtitle = GoogleFonts.inter(
    fontSize: 13,
    color: Colors.white54,
  );

  static final TextStyle noInternetConnection = GoogleFonts.inter(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle profileAboutTitle = GoogleFonts.dmSans(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle profileAboutBody = GoogleFonts.dmSans(
    color: AppColors.textMuted,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle profileSectionTitle = GoogleFonts.dmSans(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle profileEmptySavedSchools = GoogleFonts.dmSans(
    color: AppColors.textMuted,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle logoutDialogTitle = GoogleFonts.dmSans(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
}

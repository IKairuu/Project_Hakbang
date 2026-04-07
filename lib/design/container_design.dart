import 'package:flutter/painting.dart';

class ContainerDesign {
  static final BoxDecoration start_image = BoxDecoration(
    color: Color(0xFFC8FF4D),
    borderRadius: BorderRadius.circular(35),
    boxShadow: [
      BoxShadow(
        color: Color(0xFFC8FF4D).withOpacity(0.6),
        blurRadius: 25,
        spreadRadius: 2,
      ),
    ],
  );

  static final BoxDecoration schoolDiscovery = BoxDecoration(
    color: Color(0xFF152034),
    borderRadius: BorderRadius.circular(30),
  );

  static final BoxDecoration scholarshipAiDesign = BoxDecoration(
    color: Color(0xFF2a1b34),
    borderRadius: BorderRadius.circular(30),
  );
}

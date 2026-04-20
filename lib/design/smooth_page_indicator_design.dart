import 'dart:ui';

import 'package:hakbang/design/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorDesign {
  static final ExpandingDotsEffect startPageIndicator = ExpandingDotsEffect(
    dotColor: AppColors.surface3,
    dotHeight: 10,
    dotWidth: 10,
    activeDotColor: AppColors.accent,
  );
}

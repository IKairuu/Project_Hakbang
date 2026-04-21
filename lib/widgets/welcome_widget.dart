import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/smooth_page_indicator_design.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/login_page.dart';
import 'package:hakbang/pages/signup_page.dart';
import 'package:hakbang/widgets/about_app.dart';
import 'package:hakbang/widgets/explore_container.dart';
import 'package:hakbang/widgets/gabay_ai_slide.dart';
import 'package:hakbang/widgets/review_center_slide.dart';
import 'package:hakbang/widgets/scholarship_ai.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final scrollIndicator = PageController();
  final List<Widget> indicatorPages = [AboutApp(), ExploreContainer()];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      await Locations.initializeLocationServices();
      final position = await Locations.getUserLocation();
      debugPrint('Location: $position');
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 8,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: PageView(
              controller: scrollIndicator,
              children: [
                AboutApp(),
                ExploreContainer(),
                ScholarshipAi(),
                GabayAiSlide(),
                ReviewCenterSlide(),
              ],
            ),
          ),
        ),
        // Bottom controls — solid bg matching HTML .ob-controls
        Container(
          color: AppColors.bg,
          padding: const EdgeInsets.fromLTRB(28, 14, 28, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dots
              SmoothPageIndicator(
                onDotClicked: (index) {
                  scrollIndicator.animateToPage(
                    index,
                    duration: Duration(milliseconds: 450),
                    curve: Curves.easeInOut,
                  );
                },
                controller: scrollIndicator,
                count: 5,
                effect: SmoothPageIndicatorDesign.startPageIndicator,
                axisDirection: Axis.horizontal,
              ),
              const SizedBox(height: 14),
              // Get Started button
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text("Get Started →", style: FontStyles.getStarted),
                ),
              ),
              const SizedBox(height: 4),
              // Already a member row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?", style: FontStyles.memberSignIn),
                  TextButton(
                    onPressed: () async {
                      try {
                        await Locations.initializeLocationServices();
                        userPosition.value = await Locations.getUserLocation();
                        if (!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Location permission required to sign in',
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Sign In", style: FontStyles.textButtonStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

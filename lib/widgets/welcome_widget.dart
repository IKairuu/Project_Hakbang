import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/smooth_page_indicator_design.dart';
import 'package:hakbang/pages/main_page.dart';
import 'package:hakbang/pages/signup_page.dart';
import 'package:hakbang/widgets/about_app.dart';
import 'package:hakbang/widgets/explore_container.dart';
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: PageView(
                controller: scrollIndicator,
                children: [AboutApp(), ExploreContainer(), ScholarshipAi()],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  onDotClicked: (index) {
                    scrollIndicator.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                  controller: scrollIndicator,
                  count: 3,
                  effect: SmoothPageIndicatorDesign.startPageIndicator,
                  axisDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: SizedBox(
                    height: 65,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      style: ButtonDesign.mainButton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Get Started", style: FontStyles.getStarted),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?", style: FontStyles.memberSignIn),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Text("Sign In", style: FontStyles.textButtonStyle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

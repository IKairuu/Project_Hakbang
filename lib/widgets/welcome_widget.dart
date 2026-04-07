import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/smooth_page_indicator_design.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final scrollIndicator = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: ContainerDesign.start_image,
            child: Icon(Icons.image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("HAK", style: FontStyles.mainHeadingLeft),
                Text("BANG", style: FontStyles.mainHeadingRight),
              ],
            ),
          ),
          Text(
            "Your intelligent guide to college in the",
            style: FontStyles.appDetails,
          ),
          Text(
            "Philippines. Explore schools, find",
            style: FontStyles.appDetails,
          ),
          Text(
            "scholarships, and plan your path — all in",
            style: FontStyles.appDetails,
          ),
          Text("one place.", style: FontStyles.appDetails),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 80),
            child: SmoothPageIndicator(
              controller: scrollIndicator,
              count: 3,
              effect: SmoothPageIndicatorDesign.startPageIndicator,
              axisDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: SizedBox(
              height: 65,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonDesign.getStarted,
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
                onPressed: () {},
                child: Text("Sign In", style: FontStyles.signIntext),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

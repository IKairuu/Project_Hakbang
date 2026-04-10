import 'package:flutter/material.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/heights_values.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: SizedBox(
        height: HeightsValues.startPageHeight,
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: ContainerDesign.startImage,
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
          ],
        ),
      ),
    );
  }
}

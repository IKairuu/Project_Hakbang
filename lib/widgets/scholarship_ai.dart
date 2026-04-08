import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/heights_values.dart';

class ScholarshipAi extends StatefulWidget {
  const ScholarshipAi({super.key});

  @override
  State<ScholarshipAi> createState() => _ScholarshipAiState();
}

class _ScholarshipAiState extends State<ScholarshipAi> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightsValues.startPageHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/scholarship.png", fit: BoxFit.fill),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: ContainerDesign.scholarshipAiDesign,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        "assets/graduation-hat.svg",
                        height: 20,
                      ),
                    ),
                    Text(
                      "Scholarship + AI",
                      style: FontStyles.scholarshipAiText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Find Funding", style: FontStyles.exploreSchools),
                Text("Get AI guidance.", style: FontStyles.exploreSchools),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover scholarships matched to your profile and",
                  style: FontStyles.appDetails,
                ),
                Text(
                  "chat with Gabay AI — your 24/7 college advisor.",
                  style: FontStyles.appDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

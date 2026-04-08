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
          Container(
            height: HeightsValues.startPageImage,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("assets/scholarship.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.all(10),
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
                  Text("Scholarship + AI", style: FontStyles.scholarshipAiText),
                ],
              ),
            ),
          ),
          Text("Find Funding", style: FontStyles.exploreSchools),
          Text("Get AI guidance.", style: FontStyles.exploreSchools),
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
    );
  }
}

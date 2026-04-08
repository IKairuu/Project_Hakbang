import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/heights_values.dart';

class ExploreContainer extends StatelessWidget {
  const ExploreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SizedBox(
        height: HeightsValues.startPageHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: ContainerDesign.schoolDiscovery,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset("assets/map.svg", height: 20),
                    ),
                    Text("School Discovery", style: FontStyles.schoolDiscovery),
                  ],
                ),
              ),
            ),
            Text("Explore schools", style: FontStyles.exploreSchools),
            Text("near you.", style: FontStyles.exploreSchools),
            Text(
              "Browse 500+ colleges and universities across the",
              style: FontStyles.appDetails,
            ),
            Text(
              "Philippines. Filter by course, location, and entrance exam",
              style: FontStyles.appDetails,
            ),
          ],
        ),
      ),
    );
  }
}

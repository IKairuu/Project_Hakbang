import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/heights_values.dart';
import 'package:hakbang/design/padding_design.dart';
import 'package:hakbang/design/width_values.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Hello, NAME",
                              style: FontStyles.mainPageheader,
                            ),
                          ),
                          Text("👋", style: TextStyle(fontSize: 35)),
                        ],
                      ),
                      Text(
                        "Where would you like to go?",
                        style: FontStyles.mainPageUnderName,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  decoration: ContainerDesign.homeAvatar,
                  child: Text("🦁", style: TextStyle(fontSize: 40)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: ContainerDesign.reviewUpg,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("1.87", style: FontStyles.upgNumber),
                                Text(
                                  "Current UPG",
                                  style: FontStyles.labelMainPage,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("3", style: FontStyles.savedSchoolNumber),
                              Text(
                                "Saved Schools",
                                style: FontStyles.labelMainPage,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          child: ElevatedButton(
                            style: ButtonDesign.mainButton,
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Review UPG", style: FontStyles.reviewUpg),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: WidthValues.mainPageButtonWidth,
                          height: HeightsValues.mainPageButtonHeight,
                          child: ElevatedButton(
                            style: ButtonDesign.findSchoolsContainer,
                            onPressed: () {},
                            child: SvgPicture.asset("assets/university.svg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: PaddingDesign.mainPageButtonLabel,
                          ),
                          child: Text(
                            "Find Schools",
                            style: FontStyles.mainPageButtonLabels,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: WidthValues.mainPageButtonWidth,
                          height: HeightsValues.mainPageButtonHeight,
                          child: ElevatedButton(
                            style: ButtonDesign.scholarhipContainer,
                            onPressed: () {},
                            child: SvgPicture.asset(
                              "assets/graduation-hat.svg",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: PaddingDesign.mainPageButtonLabel,
                          ),
                          child: Text(
                            "Scholarhips",
                            style: FontStyles.mainPageButtonLabels,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: WidthValues.mainPageButtonWidth,
                          height: HeightsValues.mainPageButtonHeight,
                          child: ElevatedButton(
                            style: ButtonDesign.examHubContainer,
                            onPressed: () {},
                            child: SvgPicture.asset("assets/exam.svg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: PaddingDesign.mainPageButtonLabel,
                          ),
                          child: Text(
                            "Exam Hub",
                            style: FontStyles.mainPageButtonLabels,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          width: WidthValues.mainPageButtonWidth,
                          height: HeightsValues.mainPageButtonHeight,
                          child: ElevatedButton(
                            style: ButtonDesign.askgabayContainer,
                            onPressed: () {},
                            child: SvgPicture.asset("assets/robot.svg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: PaddingDesign.mainPageButtonLabel,
                          ),
                          child: Text(
                            "Ask Gabay",
                            style: FontStyles.mainPageButtonLabels,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("Recent Activity")),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          textStyle: FontStyles.textButtonStyle,
                        ),
                        child: Text("Clear"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/heights_values.dart';
import 'package:hakbang/design/padding_design.dart';
import 'package:hakbang/design/width_values.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/profile_page.dart';
import 'package:marquee/marquee.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController cardPage = PageController();
  int index = 0;
  bool reverse = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      switch (reverse) {
        case true:
          index--;
          break;
        case false:
          index++;
          break;
      }

      if (index == availableScholarships.value.length - 1) reverse = true;

      if (index == 0) reverse = false;

      cardPage.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: ValueListenableBuilder(
        valueListenable: userCredentials,
        builder: (context, userData, child) {
          return Column(
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
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Hello, ${userData!.name.split(" ")[0]}!",
                              style: FontStyles.header,
                            ),
                          ),
                          Text(
                            "Where would you like to go?",
                            style: FontStyles.obSlideDesc,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        decoration: ContainerDesign.homeAvatar,
                        child: Text(
                          "${userData.avatar}",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
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
                                    ValueListenableBuilder(
                                      valueListenable: activityList,
                                      builder: (context, acts, child) {
                                        return Text(
                                          "${acts.length}",
                                          style: FontStyles.upgNumber,
                                        );
                                      },
                                    ),
                                    Text(
                                      "Total of Activities",
                                      style: FontStyles.labelMainPage,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: savedSchools,
                                      builder: (context, saved, child) {
                                        return Text(
                                          "${saved.length}",
                                          style: FontStyles.savedSchoolNumber,
                                        );
                                      },
                                    ),
                                    Text(
                                      "Saved Schools",
                                      style: FontStyles.labelMainPage,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: availableScholarships,
                                    builder: (context, scholars, child) {
                                      return Text(
                                        "${scholars.length}",
                                        style: FontStyles.availScholars,
                                      );
                                    },
                                  ),
                                  Text(
                                    "Available Scholarships",
                                    style: FontStyles.labelMainPage,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: availableScholarships,
                              builder: (context, scholarship, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    child: PageView.builder(
                                      itemCount: scholarship.length,
                                      controller: cardPage,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration:
                                                ContainerDesign.scholarCards,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 10,
                                                          ),
                                                      child: Text("⭐"),
                                                    ),
                                                    Text(
                                                      scholarship[index].title,
                                                      style: FontStyles
                                                          .scholarshipTitle,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  scholarship[index].subtitle,
                                                  style: FontStyles
                                                      .scholarShipSubtitle,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 5,
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Application slots",
                                                        style:
                                                            GoogleFonts.inter(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .white38,
                                                            ),
                                                      ),
                                                      Text(
                                                        "${scholarship[index].slots} / ${scholarship[index].limit}",
                                                        style:
                                                            GoogleFonts.inter(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                0xFFA855F7,
                                                              ),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                    child: LinearProgressIndicator(
                                                      value:
                                                          scholarship[index]
                                                              .slots /
                                                          scholarship[index]
                                                              .limit,
                                                      minHeight: 6,
                                                      backgroundColor:
                                                          Colors.white12,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(Color(0xFFA855F7)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
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
                                onPressed: () {
                                  setState(() {
                                    navigationBarIndex.value = 1;
                                  });
                                },
                                child: SvgPicture.asset(
                                  "assets/university.svg",
                                ),
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
                                onPressed: () {
                                  setState(() {
                                    navigationBarIndex.value = 1;
                                  });
                                },
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
                                "Scholarships",
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
                                onPressed: () {
                                  setState(() {
                                    navigationBarIndex.value = 4;
                                  });
                                },
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
                                onPressed: () {
                                  setState(() {
                                    navigationBarIndex.value = 3;
                                  });
                                },
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
                flex: 4,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Recent Activity",
                                style: FontStyles.recentActivityLabel,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (activityList.value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          "There are no activities",
                                        ),
                                      ),
                                    );
                                  } else {
                                    ActivityFunctions.removeActivities();
                                  }
                                });
                              },
                              child: Text(
                                "Clear",
                                style: FontStyles.textButtonStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ValueListenableBuilder(
                          valueListenable: activityList,
                          builder: (context, acts, child) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: acts.isEmpty
                                  ? Center(
                                      child: Text(
                                        "There are no recent activities",
                                        style: FontStyles.recentActivityLabel,
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: acts.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Container(
                                            height: 70,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            decoration: ContainerDesign
                                                .activityContainers,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 10,
                                                      ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    padding: EdgeInsets.all(15),
                                                    decoration: ContainerDesign
                                                        .activityIconContainer,
                                                    child: SvgPicture.asset(
                                                      acts[index].iconName,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              right: 50,
                                                            ),
                                                        child: SizedBox(
                                                          height: 20,
                                                          child: Marquee(
                                                            key: ValueKey(
                                                              index,
                                                            ),
                                                            scrollAxis:
                                                                Axis.horizontal,
                                                            text: acts[index]
                                                                .description,
                                                            style: FontStyles
                                                                .activityDescriptionStyle,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            blankSpace: 60.0,
                                                            velocity: 40.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        acts[index].date,
                                                        style: FontStyles
                                                            .activityDateStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

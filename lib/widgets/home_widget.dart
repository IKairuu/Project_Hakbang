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
import 'package:hakbang/design/app_colors.dart';

// hm
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: ValueListenableBuilder(
        valueListenable: userCredentials,
        builder: (context, userData, child) {
          return userData == null
              ? Center(
                  child: Text(
                    "Not Logged In",
                    style: GoogleFonts.dmSans(
                      color: AppColors.textMuted,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              : Column(
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
                                    "Hello, ${userData.name.split("")[0]}!",
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
                                userData.avatar,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ValueListenableBuilder(
                                            valueListenable: savedSchools,
                                            builder: (context, saved, child) {
                                              return Text(
                                                "${saved.length}",
                                                style: FontStyles
                                                    .savedSchoolNumber,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable:
                                              availableScholarships,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 10,
                          left: 10,
                        ),
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
                                          navigationBarIndex.value = 0;
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
                                      child: SvgPicture.asset(
                                        "assets/exam.svg",
                                      ),
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
                                      child: SvgPicture.asset(
                                        "assets/robot.svg",
                                      ),
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
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (activityList.value.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                "There are no activities",
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize: 14,
                                                ),
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
                                      style: GoogleFonts.inter(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        letterSpacing: -0.5,
                                      ),
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
                                              style: TextStyle(
                                                color: AppColors.textSecondary,
                                                fontSize: 14,
                                              ),
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
                                                          padding:
                                                              EdgeInsets.all(
                                                                15,
                                                              ),
                                                          decoration:
                                                              ContainerDesign
                                                                  .activityIconContainer,
                                                          child:
                                                              SvgPicture.asset(
                                                                acts[index]
                                                                    .iconName,
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
                                                                  scrollAxis: Axis
                                                                      .horizontal,
                                                                  text: acts[index]
                                                                      .description,
                                                                  style: FontStyles
                                                                      .activityDescriptionStyle,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  blankSpace:
                                                                      60.0,
                                                                  velocity:
                                                                      40.0,
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

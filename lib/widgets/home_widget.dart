import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/profile_page.dart';
import 'package:marquee/marquee.dart';
import 'package:hakbang/design/app_colors.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController cardPage = PageController();
  int index = 0;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "Hello, ${userData.name.split(" ")[0]}!",
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: ContainerDesign.reviewUpg,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: rawSavedSchools,
                                          builder: (context, saved, child) {
                                            return Text(
                                              "${saved.length}",
                                              style:
                                                  FontStyles.savedSchoolNumber,
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
                                        CrossAxisAlignment.center,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: rawSavedScholarships,
                                        builder: (context, scholars, child) {
                                          return Text(
                                            "${scholars.length}",
                                            style: FontStyles.availScholars,
                                          );
                                        },
                                      ),
                                      Text(
                                        "Liked Scholarships",
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
                    SizedBox(height: 5),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 10,
                          left: 10,
                        ),
                        child: SizedBox(
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: AppColors.accent.withOpacity(
                                        0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => navigationBarIndex.value = 0,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: ContainerDesign.homeButton,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.accent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.school_outlined,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                "Discover Schools",
                                                style: FontStyles.homeButton,
                                              ),
                                            ),
                                            Text(
                                              "Find programs, exams, and campus fit",
                                              maxLines: 2,
                                              style: FontStyles.homeSubtitle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: AppColors.accent.withOpacity(
                                        0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => navigationBarIndex.value = 1,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: ContainerDesign.homeButton,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.accent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons
                                                    .workspace_premium_outlined,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                "Scholarships",
                                                style: FontStyles.homeButton,
                                              ),
                                            ),
                                            Text(
                                              "Matches, deadlines, and requirements",
                                              maxLines: 2,
                                              style: FontStyles.homeSubtitle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: AppColors.accent.withOpacity(
                                        0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => navigationBarIndex.value = 4,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: ContainerDesign.homeButton,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.accent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.menu_book_outlined,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                "Review Centers",
                                                style: FontStyles.homeButton,
                                              ),
                                            ),
                                            Text(
                                              "Choose modality + compare ratings",
                                              maxLines: 2,
                                              style: FontStyles.homeSubtitle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: AppColors.accent.withOpacity(
                                        0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => navigationBarIndex.value = 3,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: ContainerDesign.homeButton,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.accent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.smart_toy_outlined,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Text(
                                                "AI Companion",
                                                style: FontStyles.homeButton,
                                              ),
                                            ),
                                            Text(
                                              "Converse with Gabay AI Companion.",
                                              maxLines: 2,
                                              style: FontStyles.homeSubtitle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                                    padding: const EdgeInsets.only(bottom: 10),
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

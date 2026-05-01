import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/notifiers.dart';

class ViewAllScholarships extends StatefulWidget {
  const ViewAllScholarships({super.key, required this.government});
  final bool government;

  @override
  State<ViewAllScholarships> createState() => _ViewAllScholarshipsState();
}

class _ViewAllScholarshipsState extends State<ViewAllScholarships> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBg,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: AppColors.bg,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: titleBuilder(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: scholarshipContainers(),
      ),
    );
  }

  Widget titleBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.government ? "Governmental" : "Non-Governmental",
          style: FontStyles.header,
        ),
        Text(
          "Available Scholarships",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget scholarshipContainers() {
    return ValueListenableBuilder(
      valueListenable: widget.government
          ? governmentSection
          : nonGovernmentSection,
      builder: (context, section, child) {
        return GestureDetector(
          onTap: () {
            print("TAPPED");
            /*INSERT SCHOLARSHIP DDESCRIPTION PAGE HERE*/
          },
          child: SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: section.length,
              itemBuilder: (context, index) {
                var containerTheme = _centerGradientColors();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.frameBorder),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                              ),
                              gradient: LinearGradient(colors: containerTheme),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section[index].organizationName["short"],
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    section[index].scholarshipName,
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          section[index].allowance.split(
                                            "/",
                                          )[0],
                                          style: GoogleFonts.unbounded(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          "/ ${section[index].allowance.split("/")[1]}",
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      spacing: 5,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColors.tealDim,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            section[index].tags[0],
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.teal,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColors.purpleDim,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            section[index].tags[1],
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.purple,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Deadline",
                                          style: GoogleFonts.dmSans(
                                            fontSize: 10,
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          "${section[index].deadline} days left",
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.accentLight,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 4,
                                            color: AppColors.border2,
                                          ),
                                          FractionallySizedBox(
                                            widthFactor:
                                                (section[index].limit -
                                                    section[index].deadline) /
                                                section[index].limit,
                                            child: Container(
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  stops: [0.0, 0.8],
                                                  colors: [
                                                    containerTheme[0],
                                                    AppColors.accent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

final _randomGradient = Random();

List<Color> _centerGradientColors() {
  const gradients = [
    [Color(0xFF1E3A5F), Color(0xFF0D2040)],
    [Color(0xFF1A3320), Color(0xFF0D2014)],
    [Color(0xFF2D1B69), Color(0xFF1A0D40)],
    [Color(0xFF3D2010), Color(0xFF251008)],
    [Color(0xFF0D2A40), Color(0xFF061520)],
    [Color(0xFF1A1A40), Color(0xFF0D0D28)],
    [Color(0xFF2D2D2D), Color(0xFF1A1A1A)],
    [Color(0xFF2A1A00), Color(0xFF1A1000)],
    [Color(0xFF0D2D2D), Color(0xFF061A1A)],
    [Color(0xFF2D0D1A), Color(0xFF1A0810)],
  ];

  return gradients[_randomGradient.nextInt(gradients.length)];
}

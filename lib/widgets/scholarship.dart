import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/filter.dart';
import 'package:hakbang/notifiers.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  TextEditingController searchField = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          searchHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  scholarshipFeatured(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 70,
                      children: [
                        _buildTab("Government", 0),
                        _buildTab("Non-Governmental", 1),
                      ],
                    ),
                  ),
                  buildScholarGrids(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchHeader() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Scholarship", style: FontStyles.header),
          Text(
            "Explore grants & programs for you",
            style: FontStyles.scholarshipHeaderSecondary,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: buildTextField("Search scholarships...", searchField),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    Widget? trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              cursorColor: AppColors.accent,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
              onSubmitted: (value) => Filter.searchReviewHubs(controller.text),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                filled: true,
                fillColor: AppColors.surface2,
                suffixIcon: IconButton(
                  onPressed: () => Filter.searchReviewHubs(controller.text),
                  icon: Icon(Icons.search_outlined),
                ),
                contentPadding: EdgeInsets.only(
                  right: trailing != null ? 44 : 14,
                  top: 13,
                  bottom: 13,
                  left: 13,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border2, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.accent, width: 1.5),
                ),
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: trailing,
              ),
          ],
        ),
      ],
    );
  }

  Widget scholarshipFeatured() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 5, left: 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "· FEATURED",
              style: TextStyle(
                color: AppColors.textMuted,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ValueListenableBuilder(
                valueListenable: featuredScholarship,
                builder: (context, featured, child) {
                  return GestureDetector(
                    onTap: () {
                      /* INSERT SCHOLARSHIP DESCRIPTION PAGE HERE*/
                    },
                    child: SizedBox(
                      height: 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppColors.oceanBlue,
                                    AppColors.darkBlue,
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "⭐ TOP  PICK",
                                            style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.surface3,
                                          shape: CircleBorder(
                                            side: BorderSide(
                                              color: AppColors.frameBorder,
                                            ),
                                          ),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.heart,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: AppColors.scholarIcon,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        featured!.scholarshipIcon,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: BoxBorder.all(color: AppColors.border2),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20),
                                ),
                                color: AppColors.surface,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    featured.organizationName["long"],
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textMuted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    featured.scholarshipName,
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textPrimary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          featured.allowance.split("/")[0],
                                          style: GoogleFonts.unbounded(
                                            color: AppColors.accent,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "/",
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          featured.allowance.split("/")[1],
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
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
                                          "Application Period",
                                          style: GoogleFonts.dmSans(
                                            fontSize: 12,
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          "${featured.deadline} days left",
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.accentLight,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
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
                                                (featured.limit -
                                                    featured.deadline) /
                                                featured.limit,
                                            child: Container(
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    AppColors.blue,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? Color(0xFFB6FF3B) // neon green
                  : Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: 2,
            width: isSelected ? 110 : 0,
            decoration: BoxDecoration(
              color: Color(0xFFB6FF3B),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScholarGrids() {
    return ValueListenableBuilder(
      valueListenable: selectedIndex == 0
          ? governmentSection
          : nonGovernmentSection,
      builder: (context, section, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: GridView.builder(
            itemCount: section.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.5,
            ),
            itemBuilder: (context, index) {
              var containerTheme = _centerGradientColors();
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.frameBorder),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: containerTheme,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            section[index].scholarshipIcon,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.frameBorder),
                          color: AppColors.surface,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section[index].organizationName["short"],
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              section[index].scholarshipName,
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                section[index].allowance.split("/")[0],
                                style: GoogleFonts.unbounded(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              "per ${section[index].allowance.split("/")[1]}",
                              style: GoogleFonts.dmSans(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
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
                                      borderRadius: BorderRadius.circular(10),
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
                                      borderRadius: BorderRadius.circular(10),
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
              );
            },
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

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [searchHeader(), scholarshipFeatured()],
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
    return SingleChildScrollView(
      child: Padding(
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
                    return SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
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
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        height: 30,
                                        child: Text(
                                          "⭐ TOP  PICK",
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
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
                                    decoration: BoxDecoration(
                                      color: AppColors.darkBlue,
                                    ),
                                    child: Text(featured!.scholarshipIcon),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: BoxBorder.all(color: AppColors.border2),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20),
                                ),
                                color: AppColors.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

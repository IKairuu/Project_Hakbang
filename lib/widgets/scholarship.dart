import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/functions/launcher.dart';
import 'package:hakbang/notifiers.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});
  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  int matchIndex = Random().nextInt(availableScholarships.value.length - 1);

  Widget _scholarshipItem({
    required String title,
    required String subtitle,
    required List<dynamic> tags,
    required String icon,
    required Color iconBackgroundColor,
    List<Color>? tagColors,
    required VoidCallback onTap,
  }) {
    final palette =
        tagColors ?? [Color(0xFFA855F7), Color(0xFF4DFFB8), Color(0xFFFF6B4D)];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1C1E26),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFF343A4B)),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(icon, style: TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tag = entry.value;
                        final color = palette[index % palette.length];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScholarshipDetails({
    required String title,
    required String subtitle,
    required String description,
    required List<dynamic> details,
    required String website,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF111827),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white54),
                ),
                SizedBox(height: 18),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 18),
                ...details.map((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            detail,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.inter(
                          color: Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Launcher.launchBrowserView(Uri.parse(website));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Go to Website',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: ValueListenableBuilder(
        valueListenable: availableScholarships,
        builder: (context, scholarships, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Scholarships", style: FontStyles.header),
              SizedBox(height: 2),
              Text(
                "Funding opportunities matched to you",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),

              Stack(
                children: [
                  Positioned(
                    top: -18,
                    right: -24,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF9D7CFC).withOpacity(0.14),
                            Colors.transparent,
                          ],
                          radius: 0.8,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -28,
                    left: -20,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF7C3AED).withOpacity(0.10),
                            Colors.transparent,
                          ],
                          radius: 0.8,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Container(
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Color(0xFF1a0f2e),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Color(0xFF7C3AED).withOpacity(0.35),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⭐ SCHOLARSHIPS",
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA855F7),
                              letterSpacing: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              scholarships[matchIndex].title,
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            scholarships[matchIndex].subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white54,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Application slots",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.white38,
                                  ),
                                ),
                                Text(
                                  "${scholarships[matchIndex].slots} / ${scholarships[matchIndex].limit}",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFA855F7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: LinearProgressIndicator(
                                value:
                                    scholarships[matchIndex].slots /
                                    scholarships[matchIndex].limit,
                                minHeight: 6,
                                backgroundColor: Colors.white12,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFFA855F7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _showScholarshipDetails(
                                title: scholarships[matchIndex].title,
                                subtitle: scholarships[matchIndex].subtitle,
                                description:
                                    scholarships[matchIndex].description,
                                details: scholarships[matchIndex].details,
                                website: scholarships[matchIndex].website,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFC8FF4D),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                "Apply Now →",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
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

              Text(
                "All Scholarships",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: scholarships.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _scholarshipItem(
                      title: scholarships[index].title,
                      subtitle: scholarships[index].subtitle,
                      tags: scholarships[index].tags,
                      icon: scholarships[index].scholarIcon,
                      iconBackgroundColor: Color(0xFF5D3FD3),
                      onTap: () => _showScholarshipDetails(
                        title: scholarships[index].title,
                        subtitle: scholarships[index].subtitle,
                        description: scholarships[index].description,
                        details: scholarships[index].details,
                        website: scholarships[index].website,
                      ),
                    ),
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

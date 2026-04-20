import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/functions/launcher.dart';
import 'package:hakbang/notifiers.dart';
import 'package:intl/intl.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  late int matchIndex;

  @override
  void initState() {
    super.initState();
    final length = availableScholarships.value.length;
    matchIndex = length > 0 ? Random().nextInt(length) : 0;
  }

  Widget _scholarshipItem({
    required String title,
    required String subtitle,
    required List<dynamic> tags,
    required String icon,
    required Gradient iconGradient,
    List<Color>? tagColors,
    required VoidCallback onTap,
  }) {
    final palette = tagColors ??
        [
          const Color(0xFFA855F7),
          const Color(0xFF4DFFB8),
          const Color(0xFFFF6B4D),
        ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF343A4B)),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: iconGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
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
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags.asMap().entries.map((entry) {
                        final color = palette[entry.key % palette.length];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: color.withOpacity(0.30),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            entry.value.toString(),
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
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
          backgroundColor: AppColors.surface2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
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
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ...details.map((detail) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              detail.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Close',
                          style: GoogleFonts.inter(
                            color: Colors.white54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ActivityFunctions.addUserActivity(
                            DateFormat("MMM dd, yyyy").format(DateTime.now()),
                            "Viewed website of $title",
                            "assets/graduation-hat.svg",
                          );
                          Launcher.launchBrowserView(Uri.parse(website));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
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
          if (scholarships.isEmpty) {
            return const Center(
              child: Text(
                'No scholarships available.',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          final safeIndex = matchIndex.clamp(0, scholarships.length - 1);
          final featured = scholarships[safeIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Scholarships", style: FontStyles.header),
              const SizedBox(height: 2),
              Text(
                "Funding opportunities matched to you",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

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
                            const Color(0xFF9D7CFC).withOpacity(0.14),
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
                            const Color(0xFF7C3AED).withOpacity(0.10),
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
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1a0f2e),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF7C3AED).withOpacity(0.35),
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
                              color: const Color(0xFFA855F7),
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            featured.title,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            featured.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
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
                                "${featured.slots} / ${featured.limit}",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFA855F7),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: LinearProgressIndicator(
                              value: featured.limit > 0
                                  ? featured.slots / featured.limit
                                  : 0,
                              minHeight: 6,
                              backgroundColor: Colors.white12,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFA855F7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _showScholarshipDetails(
                                title: featured.title,
                                subtitle: featured.subtitle,
                                description: featured.description,
                                details: featured.details,
                                website: featured.website,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC8FF4D),
                                foregroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
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
              const SizedBox(height: 5),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: scholarships.length,
                  itemBuilder: (context, index) {
                    final s = scholarships[index];
                    final gradient = LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _centerGradientColors(s.title),
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: _scholarshipItem(
                        title: s.title,
                        subtitle: s.subtitle,
                        tags: s.tags,
                        icon: s.scholarIcon,
                        iconGradient: gradient,
                        onTap: () => _showScholarshipDetails(
                          title: s.title,
                          subtitle: s.subtitle,
                          description: s.description,
                          details: s.details,
                          website: s.website,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Helpers ──

final _rng = Random();

List<Color> _centerGradientColors(String title) {
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
  return List<Color>.from(gradients[_rng.nextInt(gradients.length)]);
}
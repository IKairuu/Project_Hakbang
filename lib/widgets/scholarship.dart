import 'package:flutter/material.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});
  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  Widget _stat(String value, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white38),
        ),
      ],
    );
  }

  Widget _scholarshipItem({
    required String title,
    required String subtitle,
    required List<String> tags,
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
    required List<String> details,
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
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Open website: $website')),
                        );
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
      child: Column(
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
          SizedBox(height: 20),

          // New card
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
              Container(
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
                      "⭐ BEST MATCH",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA855F7),
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "DOST Science & Engineering Scholarship",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Department of Science and Technology · Philippines",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        _stat("₱120k", "Per Year", Color(0xFFA855F7)),
                        SizedBox(width: 24),
                        _stat("4 yrs", "Duration", Color(0xFF4DFFB8)),
                        SizedBox(width: 24),
                        _stat("14d", "Deadline", Color(0xFFFF6B4D)),
                      ],
                    ),
                    SizedBox(height: 20),
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
                          "850 / 1000",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA855F7),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: 850 / 1000,
                        minHeight: 6,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFA855F7),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
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
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Scholarships",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                "Filter",
                style: GoogleFonts.inter(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                _scholarshipItem(
                  title: "UP Socialized Tuition",
                  subtitle: "University of the Philippines System",
                  tags: ["Full tuition", "Ongoing"],
                  icon: "🎓",
                  iconBackgroundColor: Color(0xFF5D3FD3),
                  onTap: () {
                    _showScholarshipDetails(
                      title: "UP Socialized Tuition",
                      subtitle: "University of the Philippines System",
                      description:
                          "UP Socialized Tuition helps eligible students cover tuition costs based on financial need and academic merit.",
                      details: [
                        "Full tuition coverage for qualifying UP degree programs.",
                        "Application windows vary by campus each semester.",
                        "Priority is given to students from low-income households.",
                      ],
                      website: "https://up.edu.ph",
                    );
                  },
                ),
                SizedBox(height: 12),
                _scholarshipItem(
                  title: "DOST Scholarship",
                  subtitle: "Department of Science and Technology",
                  tags: ["Science", "Open"],
                  icon: "🔬",
                  iconBackgroundColor: Color(0xFF256D85),
                  onTap: () {
                    _showScholarshipDetails(
                      title: "DOST Scholarship",
                      subtitle: "Department of Science and Technology",
                      description:
                          "The DOST scholarship supports science and engineering students with tuition, allowances, and research grants.",
                      details: [
                        "Covers tuition, stipend, and book allowances.",
                        "Available for STEM undergraduate programs.",
                        "Includes field-specific mentorship and training.",
                      ],
                      website: "https://dost.gov.ph",
                    );
                  },
                ),
                SizedBox(height: 12),
                _scholarshipItem(
                  title: "JLSS",
                  subtitle: "Junior Level Science Scholarship",
                  tags: ["Junior", "Available"],
                  icon: "🧪",
                  iconBackgroundColor: Color(0xFF9333EA),
                  onTap: () {
                    _showScholarshipDetails(
                      title: "JLSS",
                      subtitle: "Junior Level Science Scholarship",
                      description:
                          "The JLSS program is designed for junior scholars in science and technology fields, offering academic and financial support.",
                      details: [
                        "Supports scholars through secondary and early college pathways.",
                        "Includes training, mentoring, and access to science resources.",
                        "Open to qualified students with strong science aptitude.",
                      ],
                      website: "https://ched.gov.ph/jlss",
                    );
                  },
                ),
                SizedBox(height: 12),
                _scholarshipItem(
                  title: "CHED Scholarship",
                  subtitle: "Commission on Higher Education",
                  tags: ["Aid", "Student Support"],
                  icon: "🏛️",
                  iconBackgroundColor: Color(0xFFEF4444),
                  onTap: () {
                    _showScholarshipDetails(
                      title: "CHED Scholarship",
                      subtitle: "Commission on Higher Education",
                      description:
                          "CHED scholarships provide financial support and access to higher education for deserving Filipino students.",
                      details: [
                        "Includes tuition subsidies and book allowances.",
                        "Aimed at students pursuing priority courses.",
                        "Managed by the Commission on Higher Education.",
                      ],
                      website: "https://ched.gov.ph",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

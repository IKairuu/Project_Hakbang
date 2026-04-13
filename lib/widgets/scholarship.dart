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
          Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Color(0xFF1a0f2e),
              borderRadius: BorderRadius.circular(24),
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
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white54),
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
                  child: ElevatedButton(onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC8FF4D),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text("Apply Now →",
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
                )
              )
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1C1E26),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2D3A),
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Center(child: Text("🏛️", style: TextStyle(fontSize: 24))),
                    ),
                    SizedBox(width: 12,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("UP Socialized Tuition",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            ),
                          ),
                          Text("University of the Philippines System",
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.white54,
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF4D8FFF)),
                                borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text("Full tuition",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: Color(0xFF4D8FFF),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF4DFFB8)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text("Ongoing",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: Color(0xFF4DFFB8),
                                ))
                              )
                            ]
                          )

                        ]
                      )
                    )
                  ]
                )
              )
            ],
            
            )
          )
        ],
      ),
    );
  }
}

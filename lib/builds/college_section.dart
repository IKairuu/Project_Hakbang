import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/college_description.dart';
import 'package:latlong2/latlong.dart';
import 'package:hakbang/design/app_colors.dart';

const accentGreen = Color(0xFFC8FF4D);
const chipBlue = Color(0xFF4D8FFF);
const chipPurple = Color(0xFFA855F7);
const chipCoral = Color(0xFFFF6B4D);
const chipTeal = Color(0xFF4DFFB8);
const surface2 = Color(0xFF1c1e27);
const textPrimary = Color(0xFFF0F1F5);
const textSecondary = Color(0x8DF0F1F5);
const borderGray = Color(0xFF3a3d47);

class CollegeSection extends StatefulWidget {
  const CollegeSection({
    super.key,
    required this.college,
    required this.sectionIndex,
  });
  final College college;
  final int sectionIndex;
  @override
  State<CollegeSection> createState() => _CollegeSectionState();
}

class _CollegeSectionState extends State<CollegeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ValueListenableBuilder(
        valueListenable: selectedSchoolHover,
        builder: (context, selected, child) {
          final isSelected = selected[widget.sectionIndex];
          final borderColor = isSelected ? accentGreen : borderGray;
          final displayTags = widget.college.tags
              .cast<String>()
              .take(3)
              .toList();
          while (displayTags.length < 3) {
            if (displayTags.isEmpty) {
              displayTags.add('State U');
            } else if (displayTags.length == 1) {
              displayTags.add('UPCAT');
            } else {
              displayTags.add(
                widget.college.programNumbers.isNotEmpty
                    ? '${widget.college.programNumbers}+ Programs'
                    : '195+ Programs',
              );
            }
          }

          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: borderColor, width: 2),
                ),
              ),
              onPressed: () {
                setState(() {
                  Initialization.refreshCollegeSelection();
                  selectedSchoolHover.value[widget.sectionIndex] = true;
                  selectedSchoolPosition.value = LatLng(
                    widget.college.latitude,
                    widget.college.longitude,
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: surface2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.college.logoLink,
                          fit: BoxFit.cover,
                          width: 64,
                          height: 64,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Text(
                                  '🏫',
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.college.collegeName,
                                  style: GoogleFonts.dmSans(
                                    color: textPrimary,
                                    fontSize: 16,
                                    letterSpacing: -0.3,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('📍', style: TextStyle(fontSize: 12)),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.college.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.dmSans(
                                    color: textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              _buildChip(
                                displayTags[0],
                                chipBlue,
                                const Color(0x264D8FFF),
                                const Color(0x4D4D8FFF),
                              ),
                              _buildChip(
                                displayTags[1],
                                accentGreen,
                                const Color(0x1FC8FF4D),
                                const Color(0x4DC8FF4D),
                              ),
                              _buildChip(
                                displayTags[2],
                                chipTeal,
                                const Color(0x1A4DFFB8),
                                const Color(0x334DFFB8),
                              ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonDesign.mainButton,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CollegeDescription(
                                        college: widget.college,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'More Information',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(
    String label,
    Color textColor,
    Color backgroundColor,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

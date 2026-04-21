import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/models/college.dart';

class SavedSchoolCard extends StatelessWidget {
  final College college;

  const SavedSchoolCard({
    super.key,
    required this.college,
  });

  @override
  Widget build(BuildContext context) {
    final tags = college.tags.cast<String>().take(3).toList();
    while (tags.length < 3) {
      if (tags.isEmpty) {
        tags.add('State U');
      } else if (tags.length == 1) {
        tags.add('UPCAT');
      } else {
        tags.add(
          college.programNumbers.isNotEmpty
              ? '${college.programNumbers}+ Programs'
              : '195+ Programs',
        );
      }
    }

    const tagBackgroundColors = [
      Color(0xFF213536),
      Color(0xFF2B3619),
      Color(0xFF312746),
    ];
    const tagTextColors = [
      Color(0xFF4CF9B4),
      Color(0xFFC8FF4D),
      Color(0xFFA253EE),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ContainerDesign.universitySections,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.network(
                college.logoLink,
                height: 52,
                width: 52,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  college.collegeName,
                  style: FontStyles.schoolNames,
                ),
                const SizedBox(height: 4),
                Text(
                  '📍 ${college.address}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.schoolLocation,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.asMap().entries.map((entry) {
                    final index = entry.key;
                    final tag = entry.value;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: tagBackgroundColors[index %
                            tagBackgroundColors.length],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$tag',
                        style: GoogleFonts.dmSans(
                          color: tagTextColors[index % tagTextColors.length],
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
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
    );
  }
}

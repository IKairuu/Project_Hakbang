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
    final tags = college.tags.take(2).toList();

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
                  children: tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: ContainerDesign.pillTagIdentity,
                      child: Text(
                        '#$tag',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFFC8FF4D),
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

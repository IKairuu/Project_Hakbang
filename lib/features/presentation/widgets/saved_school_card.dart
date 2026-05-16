import 'package:flutter/material.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/models/college.dart';

class SavedSchoolCard extends StatelessWidget {
  final College college;

  const SavedSchoolCard({super.key, required this.college});

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
                Text(college.collegeName, style: FontStyles.schoolNames),
                const SizedBox(height: 4),
                Text(
                  '📍 ${college.address}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.schoolLocation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/widgets/scholarship.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/button_design.dart';

class ReviewCenter extends StatefulWidget {
  const ReviewCenter({super.key});

  @override
  State<ReviewCenter> createState() => _ReviewCenterState();
}

class _ReviewCenterState extends State<ReviewCenter> {
  final TextEditingController _reviewCenterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  const SizedBox(height: 20),
                  buildTextField(
                    'Search review centers...',
                    "📚",
                    _reviewCenterController,
                  ),
                  const SizedBox(height: 12),
                  buildTags(
                    labels: ["All", "On-site", "Online", "Hybrid"],
                    notifier: selectedFilter,
                    onChanged: () {
                      _reviewCenterController.clear();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Review Centers", style: FontStyles.header),
      const SizedBox(height: 3),
      Text(
        "Find the best place to prepare near you",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
      ),
    ],
  );
}

Widget buildTextField(String label, String iconEmoji, TextEditingController controller, {Widget? trailing}) {
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
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: AppColors.surface2,
              prefixIcon: Padding(
                padding: const EdgeInsetsGeometry.only(left: 14, right: 8),
                child: Text(
                  iconEmoji,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 30)
                )
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // to be updated
                }, 
                icon: Icon(Icons.search_outlined)),
              contentPadding: EdgeInsets.only(
                right: trailing != null ? 44 : 14,
                top: 13,
                bottom: 13,
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
          Padding(padding: const EdgeInsets.only(right: 14), child: trailing)
        ]
      )
    ]
  );
}

Widget buildTags({
  required List<String> labels,
  required ValueNotifier<List<bool>> notifier,
  VoidCallback? onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 10),
    child: ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, selected, child) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 5),
            itemCount: labels.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  notifier.value = List.generate(
                    labels.length,
                    (i) => i == index,
                  );
                  onChanged?.call();
                },
                style: selected[index]
                    ? ButtonDesign.filterUniversitySelected
                    : ButtonDesign.filterUniversityUnselected,
                child: Text(
                  labels[index],
                  style: selected[index]
                      ? FontStyles.filterLabelSelected
                      : FontStyles.filterLabelUnselected,
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
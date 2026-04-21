import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/models/review_center.dart' as rc_model;
import 'package:hakbang/pages/review_center_description.dart';

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
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: availableReviewCenters,
                    builder: (context, centers, child) {
                      return buildTopDetails(centers.length);
                    },
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: availableReviewCenters,
                      builder: (context, centers, child) {
                        return buildHubs(centers);
                      },
                    ),
                  ),
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

Widget buildTextField(
  String label,
  String iconEmoji,
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
            decoration: InputDecoration(
              hintText: label,
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: AppColors.surface2,
              prefixIcon: Padding(
                padding: const EdgeInsetsGeometry.only(left: 14, right: 8),
                child: Text(
                  iconEmoji,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 30,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // to be updated
                },
                icon: Icon(Icons.search_outlined),
              ),
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
            Padding(padding: const EdgeInsets.only(right: 14), child: trailing),
        ],
      ),
    ],
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

Widget buildTopDetails(int count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "All Centers",
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: -0.5,
        ),
      ),
      Text(
        "$count results",
        style: GoogleFonts.inter(
          color: AppColors.accent,
          fontWeight: FontWeight.w800,
          fontSize: 15,
          letterSpacing: -0.5,
        ),
      ),
    ],
  );
}

Widget buildHubs(dynamic centers) {
  if (centers.isEmpty) {
    return Center(
      child: Text(
        'No review centers available',
        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      ),
    );
  }

  return ListView.separated(
    padding: EdgeInsets.zero,
    itemCount: centers.length,
    separatorBuilder: (context, index) => Divider(
      color: Color.fromRGBO(255, 255, 255, 0.07),
      thickness: 1,
      height: 1,
    ),
    itemBuilder: (context, index) {
      final center = centers[index];
      final gradientColors = _centerGradientColors(center.title ?? '');

      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReviewCenterDescription(
                reviewCenter: rc_model.ReviewCenter(
                  title: center.title ?? '',
                  instructor: center.instructor ?? '',
                  ratingNum: center.ratingNum ?? '',
                  stars: center.stars ?? '',
                  ratingCount: center.ratingCount ?? '',
                  price: center.price ?? '',
                  originalPrice: center.originalPrice ?? '',
                  isBestSeller: center.isBestSeller ?? false,
                  emoji: center.emoji ?? '🎓',
                  subtitle: center.subtitle ?? '',
                  description: center.description ?? '',
                  managedBy: center.managedBy ?? '',
                  modalities: center.modalities ?? '',
                  location: center.location ?? '',
                  website: center.website ?? '',
                  phone: center.phone ?? '',
                  email: center.email ?? '',
                  exams: center.exams ?? '',
                  coverage: List<dynamic>.from(center.coverage ?? []),
                  programOverview: Map<String, dynamic>.from(
                    center.programOverview ?? {},
                  ),
                  centerOffers: List<dynamic>.from(center.centerOffers ?? []),
                  whoThisIsFor: List<dynamic>.from(center.whoThisIsFor ?? []),
                  aboutThisCenter: Map<String, dynamic>.from(
                    center.aboutThisCenter ?? {},
                  ),
                ),
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.white.withOpacity(0.05),
        highlightColor: Colors.white.withOpacity(0.03),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                ),
                child: Center(
                  child: Text(
                    center.emoji ?? '🎓',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      center.title ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF0F1F5),
                        letterSpacing: -0.2,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      center.instructor ?? '',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color.fromRGBO(240, 241, 245, 0.55),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          center.ratingNum ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0A500),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          center.stars ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFF0A500),
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          center.ratingCount ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color.fromRGBO(240, 241, 245, 0.3),
                          ),
                        ),
                      ],
                    ),
                    if ((center.price ?? '').isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            center.price ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF0F1F5),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if ((center.originalPrice ?? '').isNotEmpty)
                            Text(
                              center.originalPrice ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(240, 241, 245, 0.3),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 5),
                    if (center.isBestSeller)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 9,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentDim,
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'BESTSELLER',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

final _randomGradient = Random();

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

  return gradients[_randomGradient.nextInt(gradients.length)];
}

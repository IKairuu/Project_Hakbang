import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/functions/launcher.dart';
import 'package:hakbang/models/review_center.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewCenterDescription extends StatefulWidget {
  const ReviewCenterDescription({super.key, required this.reviewCenter});
  final ReviewCenter reviewCenter;

  @override
  State<ReviewCenterDescription> createState() =>
      _ReviewCenterDescriptionState();
}

class _ReviewCenterDescriptionState extends State<ReviewCenterDescription> {
  bool _descExpanded = false;

  @override
  Widget build(BuildContext context) {
    final rc = widget.reviewCenter;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColors.bg,
                  surfaceTintColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.ios_share,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCoverBanner(rc),
                      buildDetailContent(rc),
                      buildPremiumBlock(),
                      buildSectionDivider(),
                      buildWhatYoullCover(rc.coverage),
                      buildProgramOverview(rc.programOverview),
                      buildSectionDivider(),
                      buildCenterOffers(rc.centerOffers),
                      buildSectionDivider(),
                      buildWhoIsFor(rc.whoThisIsFor),
                      buildSectionDivider(),
                      buildAboutSection(
                        aboutData: rc.aboutThisCenter,
                        expanded: _descExpanded,
                        onToggle: () =>
                            setState(() => _descExpanded = !_descExpanded),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildStickyBottom(rc),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// ── Constants
// ════════════════════════════════════════════

const _gold = Color(0xFFF0A500);
const _border = Color.fromRGBO(255, 255, 255, 0.07);
const _border2 = Color.fromRGBO(255, 255, 255, 0.12);

TextStyle _dm(
  double size, {
  FontWeight weight = FontWeight.w500,
  Color color = AppColors.textSecondary,
  double spacing = 0,
  TextDecoration? decoration,
}) => GoogleFonts.dmSans(
  fontSize: size,
  fontWeight: weight,
  color: color,
  letterSpacing: spacing,
  decoration: decoration,
);

// ════════════════════════════════════════════
// ── Section Builders
// ════════════════════════════════════════════

Widget buildSectionDivider() {
  return Container(
    height: 1,
    color: _border,
    margin: const EdgeInsets.symmetric(horizontal: 16),
  );
}

Widget buildCoverBanner(ReviewCenter rc) {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2D1B69), Color(0xFF1A0D40)],
      ),
    ),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accent.withValues(alpha: 0.25),
                Colors.black.withValues(alpha: 0.4),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(rc.emoji, style: const TextStyle(fontSize: 46)),
              const SizedBox(height: 6),
              Text(
                rc.instructor,
                style: _dm(14, weight: FontWeight.w700, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBestsellerBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.accentDim,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
    ),
    child: Text(
      "BESTSELLER",
      style: _dm(
        10,
        weight: FontWeight.w700,
        color: AppColors.accent,
        spacing: 0.3,
      ),
    ),
  );
}

Widget buildRatingRow(ReviewCenter rc) {
  return Row(
    children: [
      Text(
        rc.ratingNum,
        style: _dm(15, weight: FontWeight.w700, color: _gold),
      ),
      const SizedBox(width: 6),
      Text(rc.stars, style: _dm(14, color: _gold, spacing: -1)),
      const SizedBox(width: 6),
      Text(
        "${rc.ratingCount} reviews",
        style: _dm(13, color: AppColors.textSecondary),
      ),
    ],
  );
}

Widget buildMetaRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: _dm(13, color: AppColors.textSecondary)),
        ),
      ],
    ),
  );
}

Widget buildPriceRow(ReviewCenter rc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Text(
        rc.price,
        style: _dm(
          28,
          weight: FontWeight.w700,
          color: AppColors.textPrimary,
          spacing: -1,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        rc.originalPrice,
        style: _dm(
          16,
          color: AppColors.textMuted,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        "Get now!",
        style: _dm(12, weight: FontWeight.w700, color: AppColors.accent),
      ),
    ],
  );
}

Widget buildDetailContent(ReviewCenter rc) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rc.title,
          style: _dm(
            22,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        if (rc.subtitle.isNotEmpty)
          Text(rc.subtitle, style: _dm(14, color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        if (rc.isBestSeller == true) ...[
          buildBestsellerBadge(),
          const SizedBox(height: 10),
        ],
        buildRatingRow(rc),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: _dm(13, color: AppColors.textSecondary),
            children: [
              const TextSpan(text: "Managed by "),
              TextSpan(
                text: rc.managedBy.isNotEmpty ? rc.managedBy : rc.instructor,
                style: _dm(
                  13,
                  weight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        buildMetaRow(
          Icons.location_on_outlined,
          rc.location.isNotEmpty
              ? rc.location
              : "Location info not yet available",
        ),
        buildMetaRow(
          Icons.desktop_mac_outlined,
          rc.modalities.isNotEmpty
              ? rc.modalities
              : "Online · On-site · Hybrid available",
        ),
        buildMetaRow(
          Icons.calendar_today_outlined,
          "Check center for next batch",
        ),
        buildMetaRow(
          Icons.chat_bubble_outline,
          "Filipino & English instruction",
        ),
        if (rc.phone.isNotEmpty) buildMetaRow(Icons.phone_outlined, rc.phone),
        if (rc.email.isNotEmpty) buildMetaRow(Icons.email_outlined, rc.email),
        if (rc.exams.isNotEmpty) buildMetaRow(Icons.school_outlined, rc.exams),
        const SizedBox(height: 14),
        buildPriceRow(rc),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.onAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.language, size: 18),
            label: Text(
              "Visit Website",
              style: _dm(
                15,
                weight: FontWeight.w700,
                color: AppColors.onAccent,
              ),
            ),
            onPressed: () async {
              if (rc.website.isNotEmpty) {
                final uri = Uri.tryParse(rc.website);
                Launcher.launchBrowserView(uri!, rc.title, "assets/exams.svg");
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: _border2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.bookmark_border, size: 18),
            label: Text(
              "Save Center",
              style: _dm(
                15,
                weight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: Container(height: 1, color: _border2)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("or", style: _dm(12, color: AppColors.textMuted)),
            ),
            Expanded(child: Container(height: 1, color: _border2)),
          ],
        ),
      ],
    ),
  );
}

Widget buildPremiumBlock() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Unlock with HAKBANG Premium",
          style: _dm(
            18,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Get exclusive fee discounts, priority enrollment slots, and direct inquiry access for this and 50+ partner review centers.",
          style: _dm(13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Text(
            "See what's included →",
            style: _dm(13, weight: FontWeight.w600, color: AppColors.accent),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: _border2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Try Premium Free",
              style: _dm(
                15,
                weight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            "Starting at ₱299.00/month. Cancel anytime.",
            style: _dm(11.5, color: AppColors.textMuted),
          ),
        ),
      ],
    ),
  );
}

Widget buildWhatYoullCover(List<dynamic> items) {
  if (items.isEmpty) return const SizedBox.shrink();
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.surface2,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What you'll cover",
          style: _dm(
            17,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.3,
          ),
        ),
        const SizedBox(height: 14),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("✓ ", style: _dm(14, color: AppColors.accent)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item,
                    style: _dm(13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildProgramOverview(Map<String, dynamic> overview) {
  if (overview.isEmpty) return const SizedBox.shrink();
  final modules = overview['modules'] ?? '';
  final sessions = overview['sessions'] ?? '';
  final hours = overview['hours'] ?? '';
  final schedule = overview['schedule'] ?? '';
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Program Overview",
          style: _dm(
            20,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "$modules modules · $sessions sessions · $hours hours · $schedule",
          style: _dm(13, color: AppColors.textSecondary),
        ),
      ],
    ),
  );
}

Widget buildCenterOffers(List<dynamic> offerItems) {
  if (offerItems.isEmpty) return const SizedBox.shrink();
  final icons = [
    Icons.videocam_outlined,
    Icons.file_download_outlined,
    Icons.assignment_turned_in_outlined,
    Icons.people_outline,
    Icons.phone_iphone_outlined,
    Icons.workspace_premium_outlined,
  ];

  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This center offers",
          style: _dm(
            17,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        ...offerItems.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(
                  icons[entry.key % icons.length],
                  size: 20,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: _dm(13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildWhoIsFor(List<dynamic> items) {
  if (items.isEmpty) return const SizedBox.shrink();
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who this is for",
          style: _dm(
            17,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: _dm(13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAboutSection({
  required Map<String, dynamic> aboutData,
  required bool expanded,
  required VoidCallback onToggle,
}) {
  final shortText = aboutData['short'] ?? '';
  final longText = aboutData['long'] ?? '';
  if (shortText.isEmpty && longText.isEmpty) return const SizedBox.shrink();
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About this center",
          style: _dm(
            17,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          expanded ? '$shortText\n\n$longText' : shortText,
          style: _dm(13, color: AppColors.textSecondary),
          maxLines: expanded ? null : 3,
          overflow: expanded ? null : TextOverflow.ellipsis,
        ),
        if (longText.isNotEmpty) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              expanded ? "Show less" : "Show more",
              style: _dm(13, weight: FontWeight.w600, color: AppColors.accent),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget buildStickyBottom(ReviewCenter rc) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
    decoration: const BoxDecoration(
      color: AppColors.bg,
      border: Border(top: BorderSide(color: _border)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rc.price,
                style: _dm(
                  22,
                  weight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  spacing: -0.5,
                ),
              ),
              Text(
                rc.originalPrice,
                style: _dm(
                  12,
                  color: AppColors.textMuted,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.onAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            if (rc.website.isNotEmpty) {
              final uri = Uri.tryParse(rc.website);
              Launcher.launchBrowserView(uri!, rc.title, "assets/exams.svg");
            }
          },
          child: Text(
            "Enroll Now",
            style: _dm(
              15,
              weight: FontWeight.w700,
              color: AppColors.onAccent,
              spacing: -0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

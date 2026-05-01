import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/functions/filter.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/pages/scholarship_description.dart';
import 'package:hakbang/pages/view_all_scholarships.dart';
import 'package:hakbang/design/font_styles.dart';

// ════════════════════════════════════════════════════════════════════════════
class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  TextEditingController searchField = TextEditingController();
  final _tabIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          searchHeader(),
          SizedBox(height: 2),
          buildTextField("Search scholarships...", searchField, 0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  scholarshipFeatured(),
                  ValueListenableBuilder<int>(
                    valueListenable: _tabIndex,
                    builder: (context, tabIdx, child) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 70,
                              children: [
                                _buildTab("Government", 0, tabIdx),
                                _buildTab("Non-Governmental", 1, tabIdx),
                              ],
                            ),
                          ),
                          buildScholarGrids(tabIdx),
                          ValueListenableBuilder(
                            valueListenable: tabIdx == 0
                                ? governmentSection
                                : nonGovernmentSection,
                            builder: (ctx, section, _) => section.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: viewAll(context, tabIdx),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Scholarship", style: FontStyles.header),
        const SizedBox(height: 3),
        const Text(
          "Explore grants & programs for you",
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
    TextEditingController controller,
    int index, {
    Widget? trailing,
  }) {
    return ValueListenableBuilder(
      valueListenable: governmentSelected,
      builder: (context, gov, child) {
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
                  onSubmitted: (value) {
                    Filter.searchScholarship(value, gov);
                    controller.clear();
                  },
                  decoration: InputDecoration(
                    hintText: label,
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: AppColors.surface2,
                    prefixIcon: const Padding(
                      padding: EdgeInsetsGeometry.only(left: 14, right: 8),
                      child: Icon(
                        Icons.search_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Filter.searchScholarship(controller.text, gov);
                        controller.clear();
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
                      borderSide: BorderSide(
                        color: AppColors.border2,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.accent,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: trailing,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget scholarshipFeatured() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 5, left: 5),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "⚡ FEATURED",
              style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.08 * 11,
                color: AppColors.textMuted,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ValueListenableBuilder(
                valueListenable: featuredScholarship,
                builder: (context, featured, child) {
                  final featuredTheme = _cardTheme(featured!.color);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ScholarshipDescription(scholarship: featured),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 290,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                                child: Stack(
                                  children: [
                                    // gradient bg
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: featuredTheme.gradient,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // radial glow
                                    Positioned(
                                      top: -110,
                                      right: -100,
                                      child: Container(
                                        width: 300,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: RadialGradient(
                                            colors: [
                                              featuredTheme.accent.withOpacity(
                                                0.35,
                                              ),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // grid overlay
                                    Positioned.fill(
                                      child: CustomPaint(
                                        painter: _SchGridPainter(),
                                      ),
                                    ),
                                    // content
                                    Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.accent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "⭐ TOP PICK",
                                                    style: GoogleFonts.dmSans(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 9,
                                                      letterSpacing: 0.08 * 9,
                                                      color: AppColors.onAccent,
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: SizedBox(),
                                                ),
                                              ],
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Container(
                                              height: 52,
                                              width: 52,
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  0.55,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.12),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  featured.scholarshipIcon,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    height: 1.2,
                                                    leadingDistribution:
                                                        TextLeadingDistribution
                                                            .even,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                14,
                                16,
                                16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.border2),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(24),
                                ),
                                color: AppColors.surface,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    featured.organizationName["long"],
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textMuted,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    featured.scholarshipName,
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.textPrimary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                      height: 1.25,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            featured.allowance.split("/")[0],
                                            style: GoogleFonts.unbounded(
                                              color: AppColors.accent,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                          Text(
                                            " / ${featured.allowance.split("/")[1]}",
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.textMuted,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF4ade80),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Open · Jun 30",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 11,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Application Period",
                                        style: GoogleFonts.dmSans(
                                          fontSize: 11,
                                          color: AppColors.textMuted,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${featured.deadline} days left",
                                        style: GoogleFonts.dmSans(
                                          color: AppColors.accentLight,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 3,
                                          color: AppColors.border2,
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: featured.limit == 0
                                              ? 0.0
                                              : ((featured.limit -
                                                            featured.deadline) /
                                                        featured.limit)
                                                    .clamp(0.0, 1.0),
                                          child: Container(
                                            height: 3,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  featuredTheme.accent,
                                                  AppColors.accent,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index, int currentIndex) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        _tabIndex.value = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: isSelected ? AppColors.accent : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 2,
            width: isSelected ? 110 : 0,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScholarGrids(int tabIdx) {
    return ValueListenableBuilder(
      valueListenable: tabIdx == 0 ? governmentSection : nonGovernmentSection,
      builder: (context, section, child) {
        return section.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Center(
                  child: Text(
                    "There are no available scholarships available",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : GridView.builder(
                itemCount: section.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15),

                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) {
                  final theme = _cardTheme(section[index].color);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScholarshipDescription(
                            scholarship: section[index],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 113,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border2),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: Stack(
                              children: [
                                // gradient bg
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: theme.gradient,
                                      ),
                                    ),
                                  ),
                                ),
                                // radial glow
                                Positioned(
                                  top: -20,
                                  left: -10,
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          theme.accent.withOpacity(0.22),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // grid overlay
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _SchGridPainter(),
                                  ),
                                ),
                                // status dot
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _cardStatusColor(section[index]),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                // icon
                                Center(
                                  child: Text(
                                    section[index].scholarshipIcon,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      height: 1.2,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(11, 10, 11, 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border2),
                              color: AppColors.surface,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(18),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section[index].organizationName["short"],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textMuted,
                                    letterSpacing: 0.02 * 9.5,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  section[index].scholarshipName,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.1,
                                    height: 1.25,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  section[index].allowance.split("/")[0],
                                  style: GoogleFonts.unbounded(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                Text(
                                  "per ${section[index].allowance.split("/")[1]}",
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.textMuted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (section[index].tags.isNotEmpty)
                                  Row(
                                    spacing: 4,
                                    children: section[index].tags.take(2).map((
                                      tag,
                                    ) {
                                      final tc = _cardTagColor(tag.toString());
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: tc.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Text(
                                          tag.toString(),
                                          style: GoogleFonts.dmSans(
                                            color: tc,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 8.5,
                                            letterSpacing: 0.04 * 8.5,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Deadline",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 8,
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "${section[index].deadline} days",
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.accentLight,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 2,
                                        color: AppColors.border2,
                                      ),
                                      FractionallySizedBox(
                                        widthFactor: section[index].limit == 0
                                            ? 0.0
                                            : ((section[index].limit -
                                                          section[index]
                                                              .deadline) /
                                                      section[index].limit)
                                                  .clamp(0.0, 1.0),
                                        child: Container(
                                          height: 2,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              stops: const [0.0, 0.8],
                                              colors: [
                                                theme.accent,
                                                AppColors.accent,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}

Widget viewAll(BuildContext context, int index) {
  return InkWell(
    splashColor: AppColors.accent.withOpacity(0.2),
    borderRadius: BorderRadius.circular(10),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ViewAllScholarships(government: index == 0 ? true : false);
          },
        ),
      );
    },
    child: DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: const [10, 3],
        strokeWidth: 1.5,
        radius: const Radius.circular(14),
        color: AppColors.border2,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.textSecondary,
              size: 14,
            ),
            Text(
              "View All ${index == 0 ? "Governmental" : "Non-Governmental"} Scholarships",
              style: GoogleFonts.dmSans(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

({List<Color> gradient, Color accent}) _cardTheme(String colorKey) =>
    switch (colorKey) {
      'purple' => (
        gradient: const [Color(0xFF1A0840), Color(0xFF090415)],
        accent: AppColors.purple,
      ),
      'teal' => (
        gradient: const [Color(0xFF052A1A), Color(0xFF020F0A)],
        accent: AppColors.teal,
      ),
      'coral' => (
        gradient: const [Color(0xFF2A0A04), Color(0xFF0F0402)],
        accent: AppColors.coral,
      ),
      'lime' => (
        gradient: const [Color(0xFF142008), Color(0xFF080D04)],
        accent: AppColors.accent,
      ),
      'green' => (
        gradient: const [Color(0xFF0A2010), Color(0xFF040C06)],
        accent: AppColors.teal,
      ),
      'darkblue' => (
        gradient: const [Color(0xFF0D1A40), Color(0xFF060C20)],
        accent: Color(0xFF1A6BCC),
      ),
      'darkcoral' => (
        gradient: const [Color(0xFF280808), Color(0xFF120404)],
        accent: Color(0xFFCC3D1E),
      ),
      'darkpurple' => (
        gradient: const [Color(0xFF1A0830), Color(0xFF0A0418)],
        accent: Color(0xFF7C3AC7),
      ),
      'darkteal' => (
        gradient: const [Color(0xFF032018), Color(0xFF010D0A)],
        accent: Color(0xFF1AB87A),
      ),
      'darkgreen' => (
        gradient: const [Color(0xFF041A0A), Color(0xFF020C05)],
        accent: Color(0xFF2A8C4A),
      ),
      'darklime' => (
        gradient: const [Color(0xFF0F1A04), Color(0xFF060D02)],
        accent: Color(0xFF8FB82A),
      ),
      _ => (
        gradient: const [Color(0xFF0D2040), Color(0xFF060D20)],
        accent: AppColors.blue,
      ),
    };

Color _cardTagColor(String tag) {
  final t = tag.toLowerCase();
  if (t == 'open') return const Color(0xFF4ade80);
  if (t == 'closing' || t == 'closing soon') return AppColors.coral;
  if (t == 'closed') return const Color(0xFF888888);
  if (t.contains('gov') || t.contains('government')) return AppColors.blue;
  if (t.contains('ngo')) return AppColors.purple;
  if (t.contains('stem')) return AppColors.blue;
  if (t.contains('merit') || t.contains('academic')) return AppColors.accent;
  if (t.contains('undergrad') || t.contains('college')) return AppColors.teal;
  if (t.contains('tvet') || t.contains('vocational')) return AppColors.coral;
  if (t.contains('shs') || t.contains('senior')) return AppColors.teal;
  const colors = [
    AppColors.blue,
    AppColors.purple,
    AppColors.teal,
    AppColors.coral,
    AppColors.accent,
  ];
  return colors[tag.hashCode.abs() % colors.length];
}

Color _cardStatusColor(ScholarshipObject s) {
  for (final t in s.tags) {
    final tl = t.toString().toLowerCase();
    if (tl == 'open') return const Color(0xFF4ade80);
    if (tl.contains('closing')) return AppColors.coral;
    if (tl == 'closed') return const Color(0xFF888888);
  }
  if (s.deadline > 30) return const Color(0xFF4ade80);
  if (s.deadline > 0) return AppColors.coral;
  return const Color(0xFF888888);
}

class _SchGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..strokeWidth = 1;
    const step = 36.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_SchGridPainter old) => false;
}

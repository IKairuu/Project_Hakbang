import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/functions/school_save.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class CollegeDescription extends StatefulWidget {
  const CollegeDescription({super.key, required this.college});
  final College college;

  @override
  State<CollegeDescription> createState() => _CollegeDescriptionState();
}

class _CollegeDescriptionState extends State<CollegeDescription> {
  final ScrollController _tagScroll = ScrollController();
  bool _aboutExpanded = false;

  @override
  Widget build(BuildContext context) {
    final college = widget.college;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.bg,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
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
                // ── Cover image — full width, no border radius, badges overlaid
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          college.collegeImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 16,
                        child: _cdTypeBadge(college.type),
                      ),
                      Positioned(
                        top: 12,
                        right: 16,
                        child: _cdRatingBadge(college.rating),
                      ),
                    ],
                  ),
                ),

                // ── Header info
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo + Name + Address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.network(
                              college.logoLink,
                              height: 52,
                              width: 52,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  college.collegeName,
                                  style: _cdDm(
                                    20,
                                    weight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                    spacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        college.address,
                                        style: _cdDm(
                                          13,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Stats row
                      Container(
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            _cdStatItem(
                              college.programNumbers,
                              "PROGRAMS",
                              AppColors.accentLight,
                            ),
                            Container(
                              width: 1,
                              height: 36,
                              color: AppColors.border,
                            ),
                            _cdStatItem(
                              "#${college.ranking}",
                              "RANKING",
                              AppColors.purple,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Save button
                      ValueListenableBuilder(
                        valueListenable: savedSchools,
                        builder: (context, saved, child) {
                          final isSaved = saved.contains(college);
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonDesign.mainButton,
                              onPressed: () {
                                setState(() {
                                  if (isSaved) {
                                    ActivityFunctions.addUserActivity(
                                      DateFormat(
                                        "MMM dd, yyyy",
                                      ).format(DateTime.now()),
                                      "School Unsaved: ${college.collegeName}",
                                      "assets/university.svg",
                                    );
                                    SchoolSave.removeSchool(college);
                                  } else {
                                    ActivityFunctions.addUserActivity(
                                      DateFormat(
                                        "MMM dd, yyyy",
                                      ).format(DateTime.now()),
                                      "School Saved: ${college.collegeName}",
                                      "assets/university.svg",
                                    );
                                    SchoolSave.saveSchool(college);
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isSaved
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColors.onAccent,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isSaved ? "Saved" : "Save School",
                                    style: _cdDm(
                                      15,
                                      weight: FontWeight.w700,
                                      color: AppColors.onAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                _cdSectionDivider(),

                // ── About
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cdSectionLabel("ABOUT"),
                      const SizedBox(height: 10),
                      Text(
                        college.about,
                        style: _cdDm(13, color: AppColors.textSecondary),
                        maxLines: _aboutExpanded ? null : 4,
                        overflow: _aboutExpanded ? null : TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () =>
                            setState(() => _aboutExpanded = !_aboutExpanded),
                        child: Text(
                          _aboutExpanded ? "Show less" : "Show more",
                          style: _cdDm(
                            13,
                            weight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                _cdSectionDivider(),

                // ── Tags
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cdSectionLabel("TAGS"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 38,
                        child: FadingEdgeScrollView.fromScrollView(
                          gradientFractionOnEnd: 0.15,
                          gradientFractionOnStart: 0.0,
                          child: ListView.builder(
                            controller: _tagScroll,
                            scrollDirection: Axis.horizontal,
                            itemCount: college.tags.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accentDim,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.accent.withValues(
                                      alpha: 0.35,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "#${college.tags[index]}",
                                  style: _cdDm(
                                    13,
                                    weight: FontWeight.w700,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                _cdSectionDivider(),

                // ── Programs Offered
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cdSectionLabel("PROGRAMS OFFERED"),
                      const SizedBox(height: 10),
                      ...college.programs.map(
                        (program) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface2,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    program.toString(),
                                    style: _cdDm(
                                      14,
                                      weight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                _cdSectionDivider(),

                // ── Contact
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cdSectionLabel("CONTACT"),
                      const SizedBox(height: 10),
                      _cdContactRow(
                        iconWidget: const Icon(
                          Icons.phone_enabled_rounded,
                          color: AppColors.teal,
                          size: 22,
                        ),
                        iconBg: const Color(0xFF0D2420),
                        label: "TELEPHONE",
                        value: college.telephone,
                        valueColor: AppColors.textPrimary,
                      ),
                      const SizedBox(height: 8),
                      _cdContactRow(
                        iconWidget: const Icon(
                          Icons.email_outlined,
                          color: AppColors.blue,
                          size: 22,
                        ),
                        iconBg: const Color(0xFF0D1A2A),
                        label: "EMAIL",
                        value: college.email,
                        valueColor: AppColors.textPrimary,
                      ),
                      const SizedBox(height: 8),
                      _cdContactRow(
                        iconWidget: const Icon(
                          Icons.public,
                          color: Color(0xFF1877F2),
                          size: 22,
                        ),
                        iconBg: const Color(0xFF0A1520),
                        label: "FACEBOOK",
                        value: college.fbPage,
                        valueColor: AppColors.blue,
                        isLink: true,
                      ),
                    ],
                  ),
                ),

                _cdSectionDivider(),

                // ── Location
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cdSectionLabel("LOCATION"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(
                                college.latitude,
                                college.longitude,
                              ),
                              initialZoom: 7,
                              maxZoom: 7,
                              minZoom: 6,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: "com.example.hakbang",
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    rotate: true,
                                    point: LatLng(
                                      college.latitude,
                                      college.longitude,
                                    ),
                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════
// ── Helpers
// ════════════════════════════════════════════

TextStyle _cdDm(
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

Widget _cdSectionDivider() => Container(
  height: 1,
  color: const Color.fromRGBO(255, 255, 255, 0.07),
  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
);

Widget _cdSectionLabel(String label) => Text(
  label,
  style: _cdDm(
    11,
    weight: FontWeight.w700,
    color: AppColors.textMuted,
    spacing: 0.8,
  ),
);

Widget _cdTypeBadge(String type) {
  final label = type == "private" ? "PRIVATE UNIVERSITY" : "PUBLIC UNIVERSITY";
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.72),
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.7)),
    ),
    child: Text(
      label,
      style: _cdDm(
        11,
        weight: FontWeight.w800,
        color: AppColors.accent,
        spacing: 0.4,
      ),
    ),
  );
}

Widget _cdRatingBadge(String rating) => Container(
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
  decoration: BoxDecoration(
    color: const Color(0xFF1A1500),
    borderRadius: BorderRadius.circular(100),
    border: Border.all(color: const Color(0xFFF0A500).withValues(alpha: 0.3)),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text("⭐", style: TextStyle(fontSize: 13)),
      const SizedBox(width: 5),
      Text(
        rating,
        style: _cdDm(
          13,
          weight: FontWeight.w700,
          color: const Color(0xFFF0A500),
        ),
      ),
    ],
  ),
);

Widget _cdStatItem(String value, String label, Color valueColor) => Expanded(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        value,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: valueColor),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: _cdDm(
          11,
          weight: FontWeight.w700,
          color: AppColors.textMuted,
          spacing: 0.5,
        ),
      ),
    ],
  ),
);

Widget _cdContactRow({
  required Widget iconWidget,
  required Color iconBg,
  required String label,
  required String value,
  required Color valueColor,
  bool isLink = false,
}) => Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: AppColors.surface2,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.border),
  ),
  child: Row(
    children: [
      Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: iconWidget),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: _cdDm(
                11,
                weight: FontWeight.w700,
                color: AppColors.textMuted,
                spacing: 0.6,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: _cdDm(
                14,
                weight: FontWeight.w600,
                color: valueColor,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

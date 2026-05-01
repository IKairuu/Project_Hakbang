import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/scholarship_description.dart';

class ViewAllScholarships extends StatefulWidget {
  const ViewAllScholarships({super.key, required this.government});
  final bool government;

  @override
  State<ViewAllScholarships> createState() => _ViewAllScholarshipsState();
}

class _ViewAllScholarshipsState extends State<ViewAllScholarships> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bodyBg,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: AppColors.bg,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface2,
                border: Border.all(color: AppColors.border2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textPrimary,
                size: 16,
              ),
            ),
          ),
        ),
        title: titleBuilder(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: scholarshipContainers(),
      ),
    );
  }

  Widget titleBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.government ? "Governmental" : "Non-Governmental",
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
        Text(
          "Available Scholarships",
          style: GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget scholarshipContainers() {
    return ValueListenableBuilder(
      valueListenable: widget.government
          ? governmentSection
          : nonGovernmentSection,
      builder: (context, section, child) {
        return GestureDetector(
          onTap: () {},
          child: SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: section.length,
              itemBuilder: (context, index) {
                final s = section[index];
                final theme = _valCardTheme(s.color);
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScholarshipDescription(scholarship: s),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border2),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            // left accent stripe
                            Container(
                              width: 5,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    theme.accent,
                                    theme.accent.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 13,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          s.organizationName["short"],
                                          style: GoogleFonts.dmSans(
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                        const Spacer(),
                                        // status dot
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: _valStatusColor(s),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      s.scholarshipName,
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            s.allowance.split("/")[0],
                                            style: GoogleFonts.unbounded(
                                              color: theme.accent,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                          Text(
                                            " per ${s.allowance.split("/")[1]}",
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.textMuted,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (s.tags.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          spacing: 5,
                                          children: s.tags.take(2).map((tag) {
                                            final tc = _valTagColor(
                                              tag.toString(),
                                            );
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 7,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: tc.withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                tag.toString(),
                                                style: GoogleFonts.dmSans(
                                                  color: tc,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 8.5,
                                                  letterSpacing: 0.4,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Deadline",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 8.5,
                                              color: AppColors.textMuted,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Text(
                                            "${s.deadline} days left",
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.accentLight,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 2,
                                              color: AppColors.border2,
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: s.limit == 0
                                                  ? 0.0
                                                  : ((s.limit - s.deadline) /
                                                            s.limit)
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}

({Color accent}) _valCardTheme(String colorKey) => switch (colorKey) {
  'purple' => (accent: AppColors.purple),
  'teal' => (accent: AppColors.teal),
  'coral' => (accent: AppColors.coral),
  'lime' => (accent: AppColors.accent),
  'green' => (accent: AppColors.teal),
  'darkblue' => (accent: const Color(0xFF1A6BCC)),
  'darkcoral' => (accent: const Color(0xFFCC3D1E)),
  _ => (accent: AppColors.blue),
};

Color _valTagColor(String tag) {
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

Color _valStatusColor(ScholarshipObject s) {
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

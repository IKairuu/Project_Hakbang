import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/functions/activity_functions.dart';
import 'package:hakbang/functions/filter.dart';
import 'package:hakbang/functions/launcher.dart';
import 'package:hakbang/functions/scholarship_save.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipDescription extends StatefulWidget {
  const ScholarshipDescription({super.key, required this.scholarship});
  final ScholarshipObject scholarship;

  @override
  State<ScholarshipDescription> createState() => _ScholarshipDescriptionState();
}

class _ScholarshipDescriptionState extends State<ScholarshipDescription> {
  bool _showTitle = false;
  late List<bool> _checkedDocs;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    retrievedSavedScholarship();
    _checkedDocs = List.filled(
      widget.scholarship.requiredDocuments.length,
      false,
    );
    _scrollController = ScrollController()
      ..addListener(() {
        // Show ung title once na di na kita title ng scholarship
        // (hero collapses at ~204px; name sits ~50px into content = ~254px)
        final show = _scrollController.offset > 250;
        if (show != _showTitle) setState(() => _showTitle = show);
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> retrievedSavedScholarship() async {
    if (availableScholarships.value.isEmpty) {
      await Database.getScholarships();
      Filter.getTopPick();
      Filter.filterScholarships();
    }
    ScholarshipSave.convertSavedScholarship();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scholarship;
    final (:accent, :accentDim) = _sdColorOf(s.color);
    final orgName = _sdMapVal(s.organizationName);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: ValueListenableBuilder(
        valueListenable: savedScholarships,
        builder: (context, save, child) {
          bool isSaved = save.contains(widget.scholarship);
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 260,
                      pinned: true,
                      backgroundColor: AppColors.bg,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: false,
                      titleSpacing: 0,
                      title: AnimatedOpacity(
                        opacity: _showTitle ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                orgName,
                                style: _sdDm(
                                  9.5,
                                  weight: FontWeight.w500,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              Text(
                                s.scholarshipName,
                                style: _sdDm(
                                  14,
                                  weight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                  spacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      leading: _sdCircleBtn(
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 22,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      actions: [
                        _sdCircleBtn(
                          child: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? accent : Colors.white,
                            size: 18,
                          ),
                          onTap: () {
                            if (isSaved) {
                              ActivityFunctions.addUserActivity(
                                DateFormat(
                                  "MMM dd, yyyy",
                                ).format(DateTime.now()),
                                "Like removed: ${s.scholarshipName}",
                                "assets/graduation-hat.svg",
                              );
                              ScholarshipSave.removeScholarship(s);
                            } else {
                              ActivityFunctions.addUserActivity(
                                DateFormat(
                                  "MMM dd, yyyy",
                                ).format(DateTime.now()),
                                "Scholarship Liked : ${s.scholarshipName}",
                                "assets/graduation-hat.svg",
                              );
                              ScholarshipSave.saveScholarship(s);
                            }
                          },
                          bgColor: isSaved ? accentDim : null,
                          borderColor: isSaved ? accent.withOpacity(0.3) : null,
                        ),
                        const SizedBox(width: 6),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: buildScholarHero(s, accent, accentDim),
                        collapseMode: CollapseMode.pin,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildScholarHeader(s, orgName, accent, accentDim),
                          buildScholarDeadlineBar(s),
                          buildSdDivider(),
                          buildScholarSection(
                            'About',
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.border2),
                              ),
                              child: Text(
                                s.about,
                                style: _sdDm(
                                  13,
                                  color: AppColors.textSecondary,
                                  height: 1.65,
                                ),
                              ),
                            ),
                          ),
                          if (s.benefits.isNotEmpty) ...[
                            buildSdDivider(),
                            buildScholarSection(
                              'Benefits',
                              buildScholarBenefits(
                                s.benefits,
                                accent,
                                accentDim,
                              ),
                            ),
                          ],
                          if (s.eligibility.isNotEmpty) ...[
                            buildSdDivider(),
                            buildScholarSection(
                              'Eligibility',
                              buildScholarEligibility(s.eligibility),
                            ),
                          ],
                          if (s.requiredDocuments.isNotEmpty) ...[
                            buildSdDivider(),
                            buildScholarSection(
                              'Required Documents',
                              _buildDocs(s.requiredDocuments),
                            ),
                          ],
                          if (s.applicationTimeline.isNotEmpty) ...[
                            buildSdDivider(),
                            buildScholarSection(
                              'Timeline',
                              buildScholarTimeline(
                                s.applicationTimeline,
                                accent,
                              ),
                            ),
                          ],
                          buildSdDivider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
                            child: buildScholarObligation(s.serviceObligation),
                          ),
                          if (s.applicationSteps.isNotEmpty) ...[
                            buildSdDivider(),
                            buildScholarSection(
                              'How to Apply',
                              buildScholarApplySteps(s.applicationSteps),
                            ),
                          ],
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildScholarCta(
                s,
                accent,
                isSaved,
                () => setState(() => isSaved = !isSaved),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDocs(List<dynamic> docs) {
    return Column(
      children: List.generate(docs.length, (i) {
        final isLast = i == docs.length - 1;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: isLast
              ? null
              : const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => setState(() => _checkedDocs[i] = !_checkedDocs[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: _checkedDocs[i]
                        ? AppColors.accentDim
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _checkedDocs[i]
                          ? AppColors.accent
                          : AppColors.border2,
                      width: 1.5,
                    ),
                  ),
                  child: _checkedDocs[i]
                      ? const Icon(
                          Icons.check,
                          size: 11,
                          color: AppColors.accent,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  docs[i].toString(),
                  style: _sdDm(13, color: AppColors.textSecondary, height: 1.4),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

String _sdMapVal(Map<String, dynamic> map) =>
    (map['en'] ?? map.values.firstOrNull ?? '').toString();

TextStyle _sdDm(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.textSecondary,
  double spacing = 0,
  double? height,
}) => GoogleFonts.dmSans(
  fontSize: size,
  fontWeight: weight,
  color: color,
  letterSpacing: spacing,
  height: height,
);

Widget _sdCircleBtn({
  required Widget child,
  required VoidCallback onTap,
  Color? bgColor,
  Color? borderColor,
}) => GestureDetector(
  onTap: onTap,
  child: Container(
    width: 36,
    height: 36,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    decoration: BoxDecoration(
      color: bgColor ?? Colors.black.withOpacity(0.45),
      shape: BoxShape.circle,
      border: Border.all(color: borderColor ?? Colors.white.withOpacity(0.1)),
    ),
    child: Center(child: child),
  ),
);

Widget buildSdDivider() => Container(
  height: 1,
  color: AppColors.border,
  margin: const EdgeInsets.symmetric(horizontal: 18),
);

Color _sdTagColor(String tag) {
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
  // fallback: cycle through palette by hash
  final colors = [
    AppColors.blue,
    AppColors.purple,
    AppColors.teal,
    AppColors.coral,
    AppColors.accent,
  ];
  return colors[tag.hashCode.abs() % colors.length];
}

({Color accent, Color accentDim}) _sdColorOf(String colorKey) =>
    switch (colorKey) {
      'lime' => (accent: AppColors.accent, accentDim: AppColors.accentDim),
      'purple' => (accent: AppColors.purple, accentDim: AppColors.purpleDim),
      'teal' => (accent: AppColors.teal, accentDim: AppColors.tealDim),
      'coral' => (accent: AppColors.coral, accentDim: AppColors.coralDim),
      'darkblue' => (
        accent: const Color(0xFF1A6BCC),
        accentDim: const Color(0x261A6BCC),
      ),
      'darkcoral' => (
        accent: const Color(0xFFCC3D1E),
        accentDim: const Color(0x26CC3D1E),
      ),
      'darkpurple' => (
        accent: const Color(0xFF7C3AC7),
        accentDim: const Color(0x267C3AC7),
      ),
      'darkteal' => (
        accent: const Color(0xFF1AB87A),
        accentDim: const Color(0x261AB87A),
      ),
      'darkgreen' => (
        accent: const Color(0xFF2A8C4A),
        accentDim: const Color(0x262A8C4A),
      ),
      'darklime' => (
        accent: const Color(0xFF8FB82A),
        accentDim: const Color(0x268FB82A),
      ),
      _ => (accent: AppColors.blue, accentDim: AppColors.blueDim),
    };

Widget buildScholarHero(ScholarshipObject s, Color accent, Color accentDim) {
  final heroBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.alphaBlend(accent.withOpacity(0.10), AppColors.bg),
      Color.alphaBlend(accent.withOpacity(0.20), AppColors.bg),
      Color.alphaBlend(accent.withOpacity(0.08), AppColors.bg),
    ],
  );

  return Stack(
    children: [
      Positioned.fill(
        child: Container(decoration: BoxDecoration(gradient: heroBg)),
      ),
      Positioned(
        top: -60,
        right: -60,
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [accent.withOpacity(0.45), Colors.transparent],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: -80,
        left: -40,
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppColors.accent.withOpacity(0.2), Colors.transparent],
            ),
          ),
        ),
      ),
      Positioned.fill(child: CustomPaint(painter: _SdGridPainter())),
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 1.0],
              colors: [Colors.transparent, Color(0xEB0C0D10)],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: accentDim,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accent.withOpacity(0.25), width: 1.5),
          ),
          child: Center(
            child: Text(
              s.scholarshipIcon,
              style: const TextStyle(
                fontSize: 26,
                height: 1.2,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        right: 18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            ...s.tags.map((tag) {
              final tagColor = _sdTagColor(tag.toString());
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: tagColor.withOpacity(0.35)),
                ),
                child: Text(
                  tag.toString().toUpperCase(),
                  style: _sdDm(
                    8,
                    weight: FontWeight.w700,
                    color: tagColor,
                    spacing: 0.5,
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: accent.withOpacity(0.3)),
              ),
              child: Text(
                s.government ? "GOV'T" : 'NGO',
                style: _sdDm(
                  9,
                  weight: FontWeight.w800,
                  color: accent,
                  spacing: 0.08,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildScholarHeader(
  ScholarshipObject s,
  String orgName,
  Color accent,
  Color accentDim,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orgName,
          style: _sdDm(11, weight: FontWeight.w500, color: AppColors.textMuted),
        ),
        const SizedBox(height: 5),
        Text(
          s.scholarshipName,
          style: _sdDm(
            24,
            weight: FontWeight.w700,
            color: AppColors.textPrimary,
            spacing: -0.6,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          decoration: BoxDecoration(
            color: accentDim,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentDim,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    s.scholarshipIcon,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ALLOWANCE',
                    style: _sdDm(
                      10,
                      weight: FontWeight.w600,
                      color: AppColors.textMuted,
                      spacing: 0.5,
                    ),
                  ),
                  Text(
                    s.allowance,
                    style: GoogleFonts.unbounded(
                      fontSize: 22,
                      color: accent,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _sdStatPill(
                s.minGwa > 0 ? s.minGwa.toStringAsFixed(2) : 'N/A',
                'Min GWA',
                AppColors.accentLight,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _sdStatPill(
                '${s.duration}yr${s.duration != 1 ? 's' : ''}',
                'Duration',
                AppColors.teal,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _sdStatPill(
                s.deadline > 0 ? '${s.deadline}d' : 'N/A',
                'Days Left',
                AppColors.coral,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _sdStatPill(String val, String label, Color valColor) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.border2),
    ),
    child: Column(
      children: [
        Text(
          val,
          style: GoogleFonts.unbounded(
            fontSize: 16,
            color: valColor,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: _sdDm(
            9.5,
            weight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
        ),
      ],
    ),
  );
}

Widget buildScholarDeadlineBar(ScholarshipObject s) {
  if (s.deadline <= 0) return const SizedBox.shrink();

  final deadline = s.deadline;
  final windowDays = s.limit;
  final pct = ((windowDays - deadline) / windowDays);
  final accent = _sdColorOf(s.color).accent;
  final barGradient = LinearGradient(colors: [accent, AppColors.accent]);

  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Application Period',
              style: _sdDm(
                11,
                weight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
            Text(
              s.deadline > 0 ? '${s.deadline} days left' : 'Closed',
              style: _sdDm(
                11,
                weight: FontWeight.w700,
                color: AppColors.accentLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Container(height: 4, color: AppColors.border2),
              FractionallySizedBox(
                widthFactor: pct,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(gradient: barGradient),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildScholarSection(String title, Widget content) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: _sdDm(
                14,
                weight: FontWeight.w700,
                color: AppColors.textPrimary,
                spacing: -0.2,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Container(height: 1, color: AppColors.border2)),
          ],
        ),
        const SizedBox(height: 12),
        content,
      ],
    ),
  );
}

Widget buildScholarBenefits(
  List<dynamic> benefits,
  Color accent,
  Color accentDim,
) {
  return Column(
    children: List.generate(benefits.length, (i) {
      final b = benefits[i];
      final isLast = i == benefits.length - 1;
      final title = b is Map ? (b['title'] ?? '').toString() : b.toString();
      final desc = b is Map
          ? (b['description'] ?? b['desc'] ?? '').toString()
          : '';
      final icon = b is Map ? (b['icon'] ?? '').toString() : '';
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: isLast
            ? null
            : const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accentDim,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: icon.isNotEmpty
                    ? Text(
                        icon,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    : Text('✦', style: TextStyle(fontSize: 14, color: accent)),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _sdDm(
                      13,
                      weight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (desc.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: _sdDm(
                        11.5,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget buildScholarEligibility(List<dynamic> eligibility) {
  return Column(
    children: List.generate(eligibility.length, (i) {
      final isLast = i == eligibility.length - 1;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isLast
            ? null
            : const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 5, right: 10),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                eligibility[i].toString(),
                style: _sdDm(13, color: AppColors.textSecondary, height: 1.45),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget buildScholarTimeline(List<dynamic> timeline, Color accent) {
  return Column(
    children: List.generate(timeline.length, (i) {
      final t = timeline[i];
      final isLast = i == timeline.length - 1;
      String date = '';
      if (t is Map) {
        final start = (t['start_date'] ?? t['date'] ?? t['period'] ?? '')
            .toString();
        final end = (t['end_date'] ?? '').toString();
        if (start.isNotEmpty && end.isNotEmpty && end != 'Not yet stated') {
          date = '$start – $end';
        } else if (start.isNotEmpty) {
          date = start;
        }
      }
      final event = t is Map
          ? (t['phase'] ?? t['event'] ?? t['title'] ?? '').toString()
          : t.toString();
      final note = t is Map
          ? (t['description'] ?? t['note'] ?? '').toString()
          : '';
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 14,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: accent, width: 2),
                  ),
                ),
                if (!isLast)
                  Container(width: 2, height: 40, color: AppColors.border),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (date.isNotEmpty)
                    Text(
                      date.toUpperCase(),
                      style: _sdDm(
                        10,
                        weight: FontWeight.w700,
                        color: AppColors.textMuted,
                        spacing: 0.05,
                      ),
                    ),
                  Text(
                    event,
                    style: _sdDm(
                      13,
                      weight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (note.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      note,
                      style: _sdDm(11, color: AppColors.textMuted, height: 1.4),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
    }).toList(),
  );
}

Widget buildScholarObligation(Map<String, dynamic> obligation) {
  final obligationText = (obligation['note'] ?? '').toString();
  final hasObligation = (obligation['required'] == true);

  if (hasObligation) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.coralDim,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.coral.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service Obligation",
                  style: _sdDm(
                    12,
                    weight: FontWeight.w700,
                    color: AppColors.coral,
                  ),
                ),
                if (obligationText.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    obligationText,
                    style: _sdDm(
                      12,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.tealDim,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.teal.withOpacity(0.2)),
    ),
    child: Row(
      children: [
        const Text('✅', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Text(
          'No service obligation required',
          style: _sdDm(12, weight: FontWeight.w600, color: AppColors.teal),
        ),
      ],
    ),
  );
}

Widget buildScholarApplySteps(List<dynamic> steps) {
  return Column(
    children: List.generate(steps.length, (i) {
      final step = steps[i];
      final isLast = i == steps.length - 1;
      final text = step is Map
          ? (step['description'] ?? step['text'] ?? step['step'] ?? '')
                .toString()
          : step.toString();
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: isLast
            ? null
            : const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.accentDim,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: GoogleFonts.unbounded(
                    fontSize: 11,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  text,
                  style: _sdDm(
                    13,
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget buildScholarCta(
  ScholarshipObject s,
  Color accent,
  bool isSaved,
  VoidCallback onSaveToggle,
) {
  return Container(
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 28),
    decoration: const BoxDecoration(
      color: Color(0xF70C0D10),
      border: Border(top: BorderSide(color: AppColors.border)),
    ),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.onAccent,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              final uri = Uri.tryParse(s.website);
              if (uri != null) {
                Launcher.launchBrowserView(
                  uri,
                  s.scholarshipName,
                  "assets/graduation-hat.svg",
                );
              }
            },
            child: Text(
              'Apply Now',
              style: GoogleFonts.unbounded(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.onAccent,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (isSaved) {
              ActivityFunctions.addUserActivity(
                DateFormat("MMM dd, yyyy").format(DateTime.now()),
                "Like removed: ${s.scholarshipName}",
                "assets/graduation-hat.svg",
              );
              ScholarshipSave.removeScholarship(s);
            } else {
              ActivityFunctions.addUserActivity(
                DateFormat("MMM dd, yyyy").format(DateTime.now()),
                "Scholarship Liked : ${s.scholarshipName}",
                "assets/graduation-hat.svg",
              );
              ScholarshipSave.saveScholarship(s);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSaved ? AppColors.accentDim : AppColors.surface2,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSaved
                    ? AppColors.accent.withOpacity(0.3)
                    : AppColors.border2,
              ),
            ),
            child: Icon(
              isSaved ? Icons.favorite : Icons.favorite_border,
              color: isSaved ? AppColors.accent : AppColors.textSecondary,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SdGridPainter extends CustomPainter {
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
  bool shouldRepaint(_SdGridPainter old) => false;
}

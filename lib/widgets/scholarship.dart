import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/scholarship_description.dart';

// ════════════════════════════════════════════════════════════════════════════
class Scholarship extends StatelessWidget {
  const Scholarship({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ScholarshipObject>>(
      valueListenable: availableScholarships,
      builder: (context, scholarships, _) {
        if (scholarships.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent, strokeWidth: 2),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          itemCount: scholarships.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) => _ScholarshipCard(scholarship: scholarships[i]),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class _ScholarshipCard extends StatelessWidget {
  const _ScholarshipCard({required this.scholarship});
  final ScholarshipObject scholarship;

  @override
  Widget build(BuildContext context) {
    final s = scholarship;
    final (:accent, :accentDim) = _scColorOf(s.color);
    final orgName = (s.organizationName['en'] ?? s.organizationName.values.firstOrNull ?? '').toString();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ScholarshipDescription(scholarship: s)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mini hero
            Container(
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.alphaBlend(accent.withOpacity(0.10), AppColors.bg),
                    Color.alphaBlend(accent.withOpacity(0.22), AppColors.bg),
                    Color.alphaBlend(accent.withOpacity(0.08), AppColors.bg),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Glow
                  Positioned(
                    top: -30, right: -30,
                    child: Container(
                      width: 140, height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [accent.withOpacity(0.4), Colors.transparent]),
                      ),
                    ),
                  ),
                  // Gov / NGO badge
                  Positioned(
                    top: 10, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: accentDim,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: accent.withOpacity(0.3)),
                      ),
                      child: Text(
                        s.government ? "GOV'T" : 'NGO',
                        style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w800, color: accent, letterSpacing: 0.08),
                      ),
                    ),
                  ),
                  // Icon
                  Positioned(
                    bottom: 10, right: 12,
                    child: Text(s.scholarshipIcon, style: const TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ),

            // Card body
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orgName, style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 3),
                  Text(
                    s.scholarshipName,
                    style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.allowance,
                        style: GoogleFonts.unbounded(fontSize: 16, color: accent, fontWeight: FontWeight.w700, letterSpacing: -0.4),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: AppColors.accentDim, borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'View Details →',
                          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.accent),
                        ),
                      ),
                    ],
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

// ─────────────────────────────────────────────────────────────────────────────
({Color accent, Color accentDim}) _scColorOf(String colorKey) {
  switch (colorKey) {
    case 'lime':      return (accent: AppColors.accent,         accentDim: AppColors.accentDim);
    case 'purple':    return (accent: AppColors.purple,         accentDim: AppColors.purpleDim);
    case 'teal':      return (accent: AppColors.teal,           accentDim: AppColors.tealDim);
    case 'coral':     return (accent: AppColors.coral,          accentDim: AppColors.coralDim);
    case 'darkblue':  return (accent: const Color(0xFF1A6BCC),  accentDim: const Color(0x261A6BCC));
    case 'darkcoral': return (accent: const Color(0xFFCC3D1E),  accentDim: const Color(0x26CC3D1E));
    case 'blue': default: return (accent: AppColors.blue,       accentDim: AppColors.blueDim);
  }
}

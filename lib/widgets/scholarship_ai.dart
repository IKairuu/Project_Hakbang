import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

class ScholarshipAi extends StatefulWidget {
  const ScholarshipAi({super.key});

  @override
  State<ScholarshipAi> createState() => _ScholarshipAiState();
}

class _ScholarshipAiState extends State<ScholarshipAi>
    with TickerProviderStateMixin {
  late final AnimationController _floatCtrl1;
  late final AnimationController _floatCtrl2;

  late final Animation<double> _float1;
  late final Animation<double> _float2;

  @override
  void initState() {
    super.initState();

    _floatCtrl1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _floatCtrl2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _floatCtrl2.repeat(reverse: true);
    });

    _float1 = Tween<double>(
      begin: 0.0,
      end: -8.0,
    ).animate(CurvedAnimation(parent: _floatCtrl1, curve: Curves.easeInOut));
    _float2 = Tween<double>(
      begin: 0.0,
      end: -8.0,
    ).animate(CurvedAnimation(parent: _floatCtrl2, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatCtrl1.dispose();
    _floatCtrl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Purple radial gradient — top right
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.8, -1.0),
                radius: 1.4,
                colors: [Color(0x24A855F7), Colors.transparent],
              ),
            ),
          ),
        ),
        // Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Illustration
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Scholarship card — top left
                  Positioned(
                    top: 40,
                    left: 20,
                    child: AnimatedBuilder(
                      animation: _float1,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float1.value),
                        child: _scholarshipCard(),
                      ),
                    ),
                  ),
                  // Second scholarship card — bottom right
                  Positioned(
                    bottom: 28,
                    right: 20,
                    child: AnimatedBuilder(
                      animation: _float2,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float2.value),
                        child: _matchCard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text block
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.purpleDim,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🏆', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 5),
                        Text(
                          'SCHOLARSHIPS',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.purple,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Find Funding.\nGet Matched.',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.6,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover scholarships matched to your profile — government, private, and merit-based grants all in one feed.',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _scholarshipCard() {
    return Container(
      width: 195,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A0F2E), Color(0xFF0F0D20)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0x40A855F7)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.purpleDim,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.purple,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Merit Scholarship',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Full Tuition Coverage',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '₱120,000',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.purple,
                ),
              ),
              Text(
                '/yr',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.coralDim,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Deadline: Jun 30',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.coral,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matchCard() {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Matched for you',
            style: GoogleFonts.dmSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          _matchRow('CHED Scholarship', '₱60,000/yr', AppColors.purple),
          const SizedBox(height: 6),
          _matchRow('SM Foundation', '₱80,000/yr', AppColors.blue),
          const SizedBox(height: 6),
          _matchRow('DOST-SEI', '₱50,000/yr', AppColors.teal),
        ],
      ),
    );
  }

  Widget _matchRow(String name, String amount, Color color) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.dmSans(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

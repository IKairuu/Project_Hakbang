import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

class ReviewCenterSlide extends StatefulWidget {
  const ReviewCenterSlide({super.key});

  @override
  State<ReviewCenterSlide> createState() => _ReviewCenterSlideState();
}

class _ReviewCenterSlideState extends State<ReviewCenterSlide>
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
    Future.delayed(const Duration(milliseconds: 1800), () {
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
        // Coral radial gradient — top center
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -1.0),
                radius: 1.4,
                colors: [Color(0x28FF6B4D), Colors.transparent],
              ),
            ),
          ),
        ),
        // Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Illustration
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Review hub card — top right float
                  Positioned(
                    top: 60,
                    right: 20,
                    child: AnimatedBuilder(
                      animation: _float1,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float1.value),
                        child: _hubCard(),
                      ),
                    ),
                  ),
                  // Nearby centers card — bottom left float
                  Positioned(
                    bottom: 28,
                    left: 20,
                    child: AnimatedBuilder(
                      animation: _float2,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float2.value),
                        child: _scoreCard(),
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
                      color: AppColors.coralDim,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('📚', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 5),
                        Text(
                          'REVIEW CENTERS',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.coral,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ace your exams.\nFind the right hub.',
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
                    'Browse on-site, online, and hybrid review centers for UPCAT, ACET, DCAT, and more — all in one place.',
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

  Widget _hubCard() {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A1209), Color(0xFF1A0C06)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0x40FF6B4D)),
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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.coralDim,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.coral,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'MSA Review Center',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFF5A623),
                size: 14,
              ),
              const SizedBox(width: 3),
              Text(
                '4.9',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(1.2k reviews)',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'UPCAT · ACET · USTET',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.coralDim,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'On-site',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.coral,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.border2),
                ),
                child: Text(
                  'Online',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreCard() {
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
            'Nearby Centers',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10),
          _centerRow('Review Masters', 4.8, 'Hybrid'),
          const SizedBox(height: 8),
          _centerRow('AMA Review', 4.7, 'Online'),
          const SizedBox(height: 8),
          _centerRow('Ahead Tutorial', 4.9, 'On-site'),
        ],
      ),
    );
  }

  Widget _centerRow(String name, double rating, String mode) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.coralDim,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.school_rounded,
            color: AppColors.coral,
            size: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFF5A623),
                    size: 10,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$rating  ·  $mode',
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

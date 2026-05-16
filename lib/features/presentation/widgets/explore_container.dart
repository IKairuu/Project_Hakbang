import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

class ExploreContainer extends StatefulWidget {
  const ExploreContainer({super.key});

  @override
  State<ExploreContainer> createState() => _ExploreContainerState();
}

class _ExploreContainerState extends State<ExploreContainer>
    with TickerProviderStateMixin {
  late final AnimationController _floatCtrl;
  late final AnimationController _dotPulseCtrl;

  late final Animation<double> _floatCard;
  late final Animation<double> _dotScale;

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _dotPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatCard = Tween<double>(
      begin: 0.0,
      end: -8.0,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
    _dotScale = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _dotPulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _dotPulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Blue radial gradient — top left
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -1.0),
                radius: 1.4,
                colors: [Color(0x244D8FFF), Colors.transparent],
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
                  // Map mock card
                  _MapMockCard(dotScale: _dotScale),
                  // Floating school card — bottom right
                  Positioned(
                    bottom: 24,
                    right: 20,
                    child: AnimatedBuilder(
                      animation: _floatCard,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _floatCard.value),
                        child: _schoolCard(),
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
                      color: AppColors.blueDim,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🗺', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 5),
                        Text(
                          'SCHOOL DISCOVERY',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Explore schools\nnear you.',
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
                    'Browse 500+ colleges and universities across the Philippines. Filter by course, location, and entrance exam.',
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

  Widget _schoolCard() {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.blueDim,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.blue,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'UST Manila',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFF5A623),
                size: 12,
              ),
              const SizedBox(width: 3),
              Text(
                '4.8',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.textMuted,
                size: 11,
              ),
              const SizedBox(width: 2),
              Text(
                '2.1 km away',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapMockCard extends StatelessWidget {
  final Animation<double> dotScale;
  const _MapMockCard({required this.dotScale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F1824), Color(0xFF0A1520)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0x264D8FFF)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 40,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Grid
            CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: _MapGridPainter(),
            ),
            // Pin 1 — UST (accent)
            _pin('UST', const Offset(0.38, 0.50), true),
            // Pin 2 — UP Diliman
            _pin('UP Diliman', const Offset(0.68, 0.38), false),
            // Pin 3 — DLSU
            _pin('DLSU', const Offset(0.22, 0.68), false),
            // User location dot
            Positioned(
              left: 270 * 0.46 - 6,
              top: 200 * 0.52 - 6,
              child: AnimatedBuilder(
                animation: dotScale,
                builder: (context, _) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: dotScale.value,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blue.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                        border: Border.all(color: Colors.white, width: 2.5),
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
  }

  Widget _pin(String label, Offset fraction, bool isAccent) {
    final left = 270 * fraction.dx;
    final top = 200 * fraction.dy;
    return Positioned(
      left: left - 30,
      top: top - 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isAccent ? AppColors.accent : AppColors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isAccent ? AppColors.accent : AppColors.border2,
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: isAccent
                    ? const Color(0xFF0C0D10)
                    : AppColors.textPrimary,
              ),
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isAccent ? AppColors.accent : AppColors.surface,
              border: Border(
                right: BorderSide(
                  color: isAccent ? AppColors.accent : AppColors.border2,
                  width: 1.5,
                ),
                bottom: BorderSide(
                  color: isAccent ? AppColors.accent : AppColors.border2,
                  width: 1.5,
                ),
              ),
            ),
            transform: Matrix4.rotationZ(0.785398),
            transformAlignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4D8FFF).withValues(alpha: 0.06)
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

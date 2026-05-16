import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _floatCtrl1;
  late final AnimationController _floatCtrl2;

  late final Animation<double> _pulseScale;
  late final Animation<double> _float1;
  late final Animation<double> _float2;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatCtrl1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _floatCtrl2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _floatCtrl2.repeat(reverse: true);
    });

    _pulseScale = Tween<double>(
      begin: 1.0,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
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
    _pulseCtrl.dispose();
    _floatCtrl1.dispose();
    _floatCtrl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Lime radial gradient — top center
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -1.0),
                radius: 1.4,
                colors: [Color(0x24C8FF4D), Colors.transparent],
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
                  // Pulsing rings
                  AnimatedBuilder(
                    animation: _pulseCtrl,
                    builder: (context, _) => Stack(
                      alignment: Alignment.center,
                      children: [
                        _ring(290, 0.04),
                        _ring(220, 0.08),
                        _ring(160, 0.15),
                      ],
                    ),
                  ),
                  // Pulsing icon box
                  AnimatedBuilder(
                    animation: _pulseScale,
                    builder: (context, _) => Transform.scale(
                      scale: _pulseScale.value,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/hakbang_logo.png"),
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(
                                alpha: 0.35 + _pulseCtrl.value * 0.2,
                              ),
                              blurRadius: 50 + _pulseCtrl.value * 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Float card 1 — top left
                  Positioned(
                    top: 60,
                    left: 20,
                    child: AnimatedBuilder(
                      animation: _float1,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float1.value),
                        child: _floatCard('🎓', '500+ Schools'),
                      ),
                    ),
                  ),
                  // Float card 2 — bottom right
                  Positioned(
                    bottom: 36,
                    right: 20,
                    child: AnimatedBuilder(
                      animation: _float2,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _float2.value),
                        child: _floatCard('⭐', '4.8 Rating'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text block
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'HAK',
                        style: GoogleFonts.unbounded(
                          fontSize: 26,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                      Text(
                        'BANG',
                        style: GoogleFonts.unbounded(
                          fontSize: 26,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your intelligent guide to college in the Philippines. Explore schools, find scholarships, and plan your path — all in one place.',
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

  Widget _ring(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.accent.withValues(alpha: opacity),
          width: 1,
        ),
      ),
    );
  }

  Widget _floatCard(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

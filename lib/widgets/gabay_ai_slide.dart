import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

class GabayAiSlide extends StatefulWidget {
  const GabayAiSlide({super.key});

  @override
  State<GabayAiSlide> createState() => _GabayAiSlideState();
}

class _GabayAiSlideState extends State<GabayAiSlide>
    with TickerProviderStateMixin {
  late final AnimationController _floatCtrl;
  late final AnimationController _typingCtrl;

  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _typingCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _float = Tween<double>(
      begin: 0.0,
      end: -6.0,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _typingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Teal radial gradient — top center
        IgnorePointer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -1.0),
                radius: 1.4,
                colors: [Color(0x284DFFB8), Colors.transparent],
              ),
            ),
          ),
        ),
        // Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Chat console illustration
            Expanded(
              child: AnimatedBuilder(
                animation: _float,
                builder: (context, _) => Transform.translate(
                  offset: Offset(0, _float.value),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: _chatConsole(),
                    ),
                  ),
                ),
              ),
            ),
            // Text block
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 4, 28, 16),
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
                      color: AppColors.tealDim,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('✨', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 5),
                        Text(
                          'GABAY AI',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teal,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your 24/7\nCollege Advisor.',
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
                    'Ask Gabay anything — courses, schools, scholarships, deadlines. Get instant, personalized answers powered by AI.',
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

  Widget _chatConsole() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border2),
        boxShadow: [
          BoxShadow(
            color: AppColors.teal.withValues(alpha: 0.08),
            blurRadius: 40,
            spreadRadius: 4,
          ),
          const BoxShadow(
            color: Colors.black54,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header — matches real app
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border(bottom: BorderSide(color: AppColors.border2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accentDim,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accent, width: 1.5),
                  ),
                  child: const Center(
                    child: Text('🤖', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gabay AI',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Text(
                          '●',
                          style: TextStyle(color: AppColors.teal, fontSize: 9),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Online · Ready to help',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            color: AppColors.teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Messages area
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date separator
                Center(
                  child: Text(
                    'Today · 10:24 AM',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // AI message
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.tealDim,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.teal, width: 1),
                      ),
                      child: const Center(
                        child: Text('🤖', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4),
                          ),
                          border: Border.all(color: const Color(0x11FFFFFF)),
                        ),
                        child: Text(
                          'Hi! I\'m Gabay. Ask me anything about schools, courses, or scholarships 🎓',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),

                // User message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 9,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.teal,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'What are the best schools for pre-med?',
                        style: TextStyle(
                          color: Color(0xFF0C0D10),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      '10:25 AM',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 9),
                    ),
                  ],
                ),
                const SizedBox(height: 9),

                // AI typing / reply
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.tealDim,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.teal, width: 1),
                      ),
                      child: const Center(
                        child: Text('🤖', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(4),
                        ),
                        border: Border.all(color: const Color(0x11FFFFFF)),
                      ),
                      child: AnimatedBuilder(
                        animation: _typingCtrl,
                        builder: (context, _) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (i) {
                            final t = ((_typingCtrl.value + i * 0.33) % 1.0);
                            final opacity = t < 0.5
                                ? 0.3 + t * 1.4
                                : 1.0 - (t - 0.5) * 1.4;
                            return Padding(
                              padding: EdgeInsets.only(right: i < 2 ? 4 : 0),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.teal.withValues(
                                    alpha: opacity.clamp(0.2, 1.0),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Suggestion chips — matches real app
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              physics: const NeverScrollableScrollPhysics(),
              children: ['Best STEM schools', 'Scholarship tips', 'UPCAT guide']
                  .map(
                    (chip) => Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.border2),
                        ),
                        child: Text(
                          chip,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Input bar — matches real app
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border2),
                    ),
                    child: const Text(
                      'Ask Gabay anything...',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '➤',
                      style: TextStyle(color: Color(0xFF0C0D10), fontSize: 16),
                    ),
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

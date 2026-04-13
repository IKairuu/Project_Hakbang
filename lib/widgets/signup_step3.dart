import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';

class SignupStep3 extends StatelessWidget {
  final VoidCallback onCreate;
  final VoidCallback onBack;

  const SignupStep3({
    super.key,
    required this.onCreate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Almost done! 🚀",
                style: GoogleFonts.unbounded(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "Step 3 of 3 — Review and confirm",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1f2231),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF343943),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile summary',
                    style: GoogleFonts.unbounded(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This page will show a final review of your selections before you create your account. For now, use this space to display a clean overview of the data you selected in the previous steps.',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9FA1A8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF272C3F),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preview will appear here',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9FA1A8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No inputs or buttons yet. This section will later show your final profile preview and confirmation details.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF7A7F8C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onCreate,
                    style: ButtonDesign.signUpButton,
                    child: Text(
                      'Create My Account 🎉',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onBack,
                    style: ButtonDesign.backButton,
                    child: Text(
                      '← Back',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

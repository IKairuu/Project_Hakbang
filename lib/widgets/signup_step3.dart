import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';

class SignupStep3 extends StatefulWidget {
  final VoidCallback onCreate;
  final VoidCallback onBack;

  const SignupStep3({
    super.key,
    required this.onCreate,
    required this.onBack,
  });

  @override
  State<SignupStep3> createState() => _SignupStep3State();
}

class _SignupStep3State extends State<SignupStep3> {
  bool agreeToTerms = false;
  bool sendTipsEmail = false;

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
                style: FontStyles.header,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "Step 3 of 3 — Review and confirm",
                style: FontStyles.stepSubtitle,
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
            const SizedBox(height: 24),
            // Checkbox options
            Theme(
              data: Theme.of(context).copyWith(
                checkboxTheme: ButtonDesign.checkboxDesign,
              ),
              child: Column(
                children: [
                  // Terms and Services checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I agree to the ',
                                style: FontStyles.memberSignIn,
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: FontStyles.signIntext,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Terms of Service tap
                                  },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: FontStyles.memberSignIn,
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: FontStyles.signIntext,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Privacy Policy tap
                                  },
                              ),
                              TextSpan(
                                text: '. I understand that my data will be used to personalize my college-planning experience.',
                                style: FontStyles.memberSignIn,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Send tips via email checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: sendTipsEmail,
                          onChanged: (value) {
                            setState(() {
                              sendTipsEmail = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          'Send me helpful scholarship alerts and study reminders via email. (Optional)',
                          style: FontStyles.memberSignIn,
                        ),
                      ),
                    ],
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
                    onPressed: widget.onCreate,
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
                    onPressed: widget.onBack,
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

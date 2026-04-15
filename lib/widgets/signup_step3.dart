import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/models/identity_option.dart';
import 'package:hakbang/notifiers.dart';

class SignupStep3 extends StatefulWidget {
  final VoidCallback onCreate;
  final VoidCallback onBack;
  final int? selectedAvatarIndex;
  final List<String> avatars;
  final String fullName;
  final String email;
  final int? selectedIdentityIndex;
  final List<IdentityOption> identities;
  final String grade;

  const SignupStep3({
    super.key,
    required this.onCreate,
    required this.onBack,
    required this.selectedAvatarIndex,
    required this.avatars,
    required this.fullName,
    required this.email,
    required this.selectedIdentityIndex,
    required this.identities,
    required this.grade,
  });

  @override
  State<SignupStep3> createState() => _SignupStep3State();
}

class _SignupStep3State extends State<SignupStep3> {
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
              padding: const EdgeInsets.only(bottom: 5),
              child: Text("Almost done! 🚀", style: FontStyles.header),
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
                border: Border.all(color: const Color(0xFF343943), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration:
                            ContainerDesign.signupSelectionOptionSelected,
                        child: Center(
                          child: Text(
                            widget.selectedAvatarIndex != null
                                ? widget.avatars[widget.selectedAvatarIndex!]
                                : '🙂',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fullName.isNotEmpty
                                  ? widget.fullName
                                  : 'Your Name',
                              style: FontStyles.previewName,
                            ),
                            Text(
                              widget.email.isNotEmpty
                                  ? widget.email
                                  : 'you@example.com',
                              style: FontStyles.previewEmail,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: ContainerDesign.pillTagIdentity,
                        child: Text(
                          widget.selectedIdentityIndex != null
                              ? widget
                                    .identities[widget.selectedIdentityIndex!]
                                    .title
                              : 'Identity',
                          style: FontStyles.previewPillText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: ContainerDesign.pillTagGrade,
                        child: Text(
                          widget.grade.isNotEmpty
                              ? widget.grade
                              : 'Grade Level',
                          style: FontStyles.previewPillText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Checkbox options
            Theme(
              data: Theme.of(
                context,
              ).copyWith(checkboxTheme: ButtonDesign.checkboxDesign),
              child: Column(
                children: [
                  // Terms and Services checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: ValueListenableBuilder(
                          valueListenable: agreeToTerms,
                          builder: (context, agree, child) {
                            return Checkbox(
                              value: agree,
                              onChanged: (value) {
                                setState(() {
                                  agreeToTerms.value = value!;
                                });
                              },
                            );
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
                                style: FontStyles.highlightText,
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
                                style: FontStyles.highlightText,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Privacy Policy tap
                                  },
                              ),
                              TextSpan(
                                text:
                                    '. I understand that my data will be used to personalize my college-planning experience.',
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
                      style: FontStyles.continueButton,
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
                      style: FontStyles.backButton,
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

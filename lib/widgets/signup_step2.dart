import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/models/identity_option.dart';

class SignupStep2 extends StatefulWidget {
  final int? selectedAvatarIndex;
  final int? selectedIdentityIndex;
  final TextEditingController schoolController;
  final TextEditingController gradeController;
  final List<String> avatars;
  final List<IdentityOption> identities;
  final ValueChanged<int?> onAvatarSelected;
  final ValueChanged<int?> onIdentitySelected;
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const SignupStep2({
    super.key,
    required this.selectedAvatarIndex,
    required this.selectedIdentityIndex,
    required this.schoolController,
    required this.gradeController,
    required this.avatars,
    required this.identities,
    required this.onAvatarSelected,
    required this.onIdentitySelected,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<SignupStep2> createState() => _SignupStep2State();
}

class _SignupStep2State extends State<SignupStep2> {
  InputDecoration _getInputDecoration(String hintText) {
    return InputDesign.unfocusedInputDecoration(hintText);
  }

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
                "Your profile 🎓",
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
                "Step 2 of 3 — Let us personalize your experience",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Choose your avatar section
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "CHOOSE YOUR AVATAR",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              children: List.generate(5, (index) {
                final isSelected = widget.selectedAvatarIndex == index;
                return GestureDetector(
                  onTap: () => widget.onAvatarSelected(index),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: isSelected
                        ? ContainerDesign.signupSelectionOptionSelected
                        : ContainerDesign.signupIdentityOptionUnselected,
                    child: Center(
                      child: Text(
                        widget.avatars[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // I am a section
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "I AM A",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: List.generate(3, (index) {
                final isSelected = widget.selectedIdentityIndex == index;
                final identity = widget.identities[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onIdentitySelected(index),
                    child: Container(
                      margin: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: isSelected
                          ? ContainerDesign.signupSelectionOptionSelected
                          : ContainerDesign.signupIdentityOptionUnselected,
                      child: Column(
                        children: [
                          Text(
                            identity.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 4),

                          Text(
                            identity.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            identity.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 150, 150, 150),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "SCHOOL / INSTITUTION",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            TextField(
              controller: widget.gradeController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: _getInputDecoration('e.g. Ateneo de Manila HS')
                  .copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 6),
                      child: Opacity(
                        opacity: 0.5,
                        child: const Text('🏫', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                  ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "GRADE LEVEL",
                style: GoogleFonts.unbounded(
                  color: const Color.fromARGB(255, 97, 105, 109),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            TextField(
              controller: widget.gradeController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: _getInputDecoration('e.g. Grade 12').copyWith(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 6),
                  child: Opacity(
                    opacity: 0.5,
                    child: const Text('📋', style: TextStyle(fontSize: 16)),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Continue and Back buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.onContinue,
                    style: ButtonDesign.signUpButton,
                    child: Text(
                      'Continue →',
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

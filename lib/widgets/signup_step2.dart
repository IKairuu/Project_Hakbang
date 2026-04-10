import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/button_design.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: List.generate(5, (index) {
                final isSelected = widget.selectedAvatarIndex == index;
                return GestureDetector(
                  onTap: () => widget.onAvatarSelected(index),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(101, 199, 255, 77) : const Color(0xFF2a2d38),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFC8FF4D) : const Color.fromARGB(255, 60, 61, 67),
                        width: 1,
                      ),
                    ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: List.generate(3, (index) {
                final isSelected = widget.selectedIdentityIndex == index;
                final identity = widget.identities[index];
                return GestureDetector(
                  onTap: () => widget.onIdentitySelected(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(101, 199, 255, 77) : const Color(0xFF2a2d38),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFC8FF4D) : const Color.fromARGB(255, 60, 61, 67),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          identity.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          identity.title,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          identity.subtitle,
                          style: TextStyle(
                            color: isSelected ? const Color.fromARGB(255, 100, 100, 100) : const Color.fromARGB(255, 150, 150, 150),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // Two text boxes (user will design these)
            TextField(
              controller: widget.schoolController,
              decoration: _getInputDecoration('School/University'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: widget.gradeController,
              decoration: _getInputDecoration('Grade/Year Level'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 32),

            // Continue and Back buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2a2d38),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
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
                const SizedBox(width: 16),
                Expanded(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/design/font_styles.dart';
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

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: FontStyles.inputLabel),
    );
  }

  Widget _buildEmojiPrefixContent(String emoji) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 6),
      child: Opacity(
        opacity: 0.5,
        child: Text(emoji, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      style: FontStyles.inputText,
      decoration: _getInputDecoration(hintText).copyWith(
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIcon != null
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
      ),
    );
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
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Your profile 🎓",
                style: FontStyles.header,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "Step 2 of 3 — Let us personalize your experience",
                style: FontStyles.stepSubtitle,
              ),
            ),

            // Choose your avatar section
            _buildInputLabel("CHOOSE YOUR AVATAR"),
            Row(
              spacing: 8,
              children: List.generate(5, (index) {
                final isSelected = widget.selectedAvatarIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onAvatarSelected(index),
                    child: Container(
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
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // I am a section
            _buildInputLabel("I AM A"),
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
                            style: FontStyles.identityTitle,
                          ),

                          const SizedBox(height: 2),

                          Text(
                            identity.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: FontStyles.identitySubtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            _buildInputLabel("SCHOOL / INSTITUTION"),

            _buildInputField(
              controller: widget.schoolController,
              hintText: 'e.g. Ateneo de Manila HS',
              prefixIcon: _buildEmojiPrefixContent('🏫'),
            ),

            const SizedBox(height: 16),

            _buildInputLabel("GRADE LEVEL"),

            _buildInputField(
              controller: widget.gradeController,
              hintText: 'e.g. Grade 12',
              prefixIcon: _buildEmojiPrefixContent('📋'),
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

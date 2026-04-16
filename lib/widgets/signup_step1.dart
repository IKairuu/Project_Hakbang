import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/design/font_styles.dart';

class SignupStep1 extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool showPassword;
  final bool showConfirmPassword;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onConfirmPasswordVisibilityToggle;
  final VoidCallback onContinue;
  final VoidCallback onSignIn;

  const SignupStep1({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.onPasswordVisibilityToggle,
    required this.onConfirmPasswordVisibilityToggle,
    required this.onContinue,
    required this.onSignIn,
  });

  @override
  State<SignupStep1> createState() => _SignupStep1State();
}

class _SignupStep1State extends State<SignupStep1> {
  static const _iconColor = Color(0xFF828a8a);

  InputDecoration _getInputDecoration(String hintText) {
    return InputDesign.unfocusedInputDecoration(hintText);
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: FontStyles.inputLabel),
    );
  }

  Widget _buildPasswordSuffix({
    required bool isVisible,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: _iconColor,
        size: 20,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: _getInputDecoration(hintText).copyWith(
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIcon != null
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        suffixIcon: suffixIcon,
      ),
      style: FontStyles.inputText,
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

  Widget _buildEmailPrefixIcon() {
    return const Padding(
      padding: EdgeInsets.only(left: 12, right: 6),
      child: Opacity(
        opacity: 0.5,
        child: Icon(
          Icons.email_outlined,
          size: 20,
          color: _iconColor,
        ),
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
              child: Text("Create account ✨", style: FontStyles.header),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "Step 1 of 3 — Your account details",
                style: FontStyles.stepSubtitle,
              ),
            ),
            _buildInputLabel("FULL NAME"),
            _buildInputField(
              controller: widget.fullNameController,
              hintText: 'Maria dela Cruz',
              prefixIcon: _buildEmojiPrefixContent('👤'),
            ),
            const SizedBox(height: 5),
            _buildInputLabel("EMAIL ADDRESS"),
            _buildInputField(
              controller: widget.emailController,
              hintText: 'you@example.com',
              prefixIcon: _buildEmailPrefixIcon(),
            ),
            const SizedBox(height: 5),
            _buildInputLabel("PASSWORD"),
            _buildInputField(
              controller: widget.passwordController,
              hintText: 'Create a strong password',
              obscureText: !widget.showPassword,
              prefixIcon: _buildEmojiPrefixContent('🔒'),
              suffixIcon: _buildPasswordSuffix(
                isVisible: widget.showPassword,
                onPressed: widget.onPasswordVisibilityToggle,
              ),
            ),
            const SizedBox(height: 5),
            _buildInputLabel("CONFIRM PASSWORD"),
            _buildInputField(
              controller: widget.confirmPasswordController,
              hintText: 'Re-enter password',
              obscureText: !widget.showConfirmPassword,
              prefixIcon: _buildEmojiPrefixContent('🔒'),
              suffixIcon: _buildPasswordSuffix(
                isVisible: widget.showConfirmPassword,
                onPressed: widget.onConfirmPasswordVisibilityToggle,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onContinue,
                style: ButtonDesign.signUpButton,
                child: Text(
                  'Continue →',
                  style: FontStyles.continueButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
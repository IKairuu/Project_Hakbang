import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hakbang/features/user/presentation/design/app_colors.dart';
import 'package:hakbang/features/user/presentation/design/button_design.dart';
import 'package:hakbang/features/user/presentation/design/input_design.dart';
import 'package:hakbang/features/user/presentation/design/font_styles.dart';
import 'package:hakbang/functions/verifications.dart';

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
    required this.passwordController,
    required this.confirmPasswordController,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.onPasswordVisibilityToggle,
    required this.onConfirmPasswordVisibilityToggle,
    required this.onContinue,
    required this.onSignIn,
    required this.fullNameController,
    required this.emailController,
  });

  @override
  State<SignupStep1> createState() => _SignupStep1State();
}

class _SignupStep1State extends State<SignupStep1> {
  static const _iconColor = Color(0xFF828a8a);
  late TextEditingController fullName = widget.fullNameController;
  late TextEditingController email = widget.emailController;
  ValueNotifier<bool> authenticated = ValueNotifier(false);

  InputDecoration _getInputDecoration(String hintText) {
    return InputDesign.unfocusedInputDecoration(hintText);
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
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
    bool isEmail = false,
    bool obscureText = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: authenticated,
      builder: (context, auth, child) {
        return TextField(
          controller: controller,
          enabled: isEmail ? !auth : true,
          obscureText: obscureText,
          cursorColor: AppColors.accent,
          decoration: _getInputDecoration(hintText).copyWith(
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIcon != null
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            suffixIcon: suffixIcon,
          ),
          style: FontStyles.inputText,
        );
      },
    );
  }

  Widget _buildGoogleSignInButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            var userDetails = await Verifications.authentication();
            if (userDetails != null) {
              fullName.text = userDetails["fullname"];
              email.text = userDetails["email"];
              setState(() {
                authenticated.value = true;
              });
            }
          } catch (error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          }
        },
        style: ButtonDesign.googleSignIn,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            FaIcon(FontAwesomeIcons.google, color: Colors.white),
            Text(
              'Sign Up with Google →',
              style: FontStyles.signupContinueButton,
            ),
          ],
        ),
      ),
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
        child: Icon(Icons.email_outlined, size: 20, color: _iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ValueListenableBuilder(
          valueListenable: authenticated,
          builder: (context, auth, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Create account ✨",
                    style: FontStyles.signupHeader,
                  ),
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
                  controller: fullName,
                  hintText: 'Maria dela Cruz',
                  prefixIcon: _buildEmojiPrefixContent('👤'),
                ),
                const SizedBox(height: 14),
                _buildInputLabel("EMAIL ADDRESS"),
                _buildInputField(
                  controller: email,
                  hintText: 'you@example.com',
                  isEmail: true,
                  prefixIcon: _buildEmailPrefixIcon(),
                ),
                const SizedBox(height: 14),
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
                const SizedBox(height: 14),
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
                !auth ? _buildGoogleSignInButton() : SizedBox(),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onContinue,
                    style: ButtonDesign.signUpButton,
                    child: Text(
                      'Continue →',
                      style: FontStyles.signupContinueButton,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

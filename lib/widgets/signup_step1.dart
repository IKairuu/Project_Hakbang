import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                "Create account ✨",
                style: FontStyles.header,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                "Step 1 of 3 — Your account details",
                style: FontStyles.stepSubtitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "FULL NAME",
                style: FontStyles.inputLabel,
              ),
            ),
            TextField(
              controller: widget.fullNameController,
              decoration: _getInputDecoration('Maria dela Cruz').copyWith(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 12, right: 6),
                  child: Opacity(
                    opacity: 0.5,
                    child: Text('👤', style: TextStyle(fontSize: 16)),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "EMAIL ADDRESS",
                style: FontStyles.inputLabel,
              ),
            ),
            TextField(
              controller: widget.emailController,
              decoration: InputDesign.unfocusedInputDecoration(
                'you@example.com',
                prefixIcon: const Opacity(
                  opacity: 0.5,
                  child: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: Color(0xFF828a8a), // keep or remove, either is fine
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "PASSWORD",
                style: FontStyles.inputLabel,
              ),
            ),
            TextField(
              controller: widget.passwordController,
              obscureText: !widget.showPassword,
              decoration: _getInputDecoration('Create a strong password')
                  .copyWith(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 6),
                      child: Opacity(
                        opacity: 0.5,
                        child: Text('🔒', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        widget.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF828a8a),
                        size: 20,
                      ),
                      onPressed: widget.onPasswordVisibilityToggle,
                    ),
                  ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "CONFIRM PASSWORD",
                style: FontStyles.inputLabel,
              ),
            ),
            TextField(
              controller: widget.confirmPasswordController,
              obscureText: !widget.showConfirmPassword,
              decoration: _getInputDecoration('Re-enter password').copyWith(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 12, right: 6),
                  child: Opacity(
                    opacity: 0.5,
                    child: Text('🔒', style: TextStyle(fontSize: 16)),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF828a8a),
                    size: 20,
                  ),
                  onPressed: widget.onConfirmPasswordVisibilityToggle,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/widgets/signup_step1.dart';
import 'package:hakbang/widgets/signup_progress_indicator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late PageController _pageController;
  int _currentStep = 0;

  // Step 1 controllers
  late TextEditingController emailController;
  late TextEditingController fullNameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  // Step 2 state
  late TextEditingController schoolController;
  late TextEditingController gradeController;

  bool showPassword = false;
  bool showConfirmPassword = false;


  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Step 1 controllers
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundDesign.startPageColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo, HAKBANG text, and progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: ContainerDesign.startImage,
                        child: const Icon(Icons.image, size: 30),
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          Text("HAK", style: FontStyles.mainHeadingLeft.copyWith(fontSize: 24)),
                          Text("BANG", style: FontStyles.mainHeadingRight.copyWith(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SignupProgressIndicator(
                    currentStep: _currentStep,
                    totalSteps: 3,
                  ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  SignupStep1(
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    showPassword: showPassword,
                    showConfirmPassword: showConfirmPassword,
                    onPasswordVisibilityToggle: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    onConfirmPasswordVisibilityToggle: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    },
                    onContinue: _nextStep,
                    onSignIn: () {
                      // Navigate to sign in
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

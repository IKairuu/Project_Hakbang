import 'package:flutter/material.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/functions/verifications.dart';
import 'package:hakbang/models/identity_option.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/main_page.dart';
import 'package:hakbang/pages/start_page.dart';
import 'package:hakbang/server/database/database.dart';
import 'package:hakbang/widgets/signup_step1.dart';
import 'package:hakbang/widgets/signup_step2.dart';
import 'package:hakbang/widgets/signup_step3.dart';
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
  int? _selectedAvatarIndex;
  int? _selectedIdentityIndex;
  late TextEditingController schoolController;
  late TextEditingController gradeController;

  bool showPassword = false;
  bool showConfirmPassword = false;

  final List<String> avatars = ['🦁', '🦊', '🐉', '🦅', '🐬'];
  final List<IdentityOption> identities = [
    IdentityOption(emoji: '🧑‍🎓', title: 'Student', subtitle: 'Grade 11 - 12'),
    IdentityOption(
      emoji: '👨‍👩‍👧',
      title: 'Parent',
      subtitle: 'Supporting a student',
    ),
    IdentityOption(emoji: '🏫', title: 'Counselor', subtitle: 'School Staff'),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    // Step 1 controllers
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // Step 2 controllers
    schoolController = TextEditingController();
    gradeController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    schoolController.dispose();
    gradeController.dispose();
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

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSubmit() async {
    final data = {
      "data": {
        "name": fullNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "avatar": avatars[_selectedAvatarIndex!],
        "occupation": identities[_selectedIdentityIndex!].title,
        "institution": schoolController.text,
        "grade": gradeController.text,
      },
    };
    await Database.signupUser(data)
        .then((value) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Setup successfull"),
                actions: [
                  TextButton(
                    onPressed: () {
                      fullNameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      _selectedAvatarIndex = null;
                      _selectedIdentityIndex = null;
                      schoolController.clear();
                      gradeController.clear();
                      agreeToTerms.value = false;
                    },
                    child: Text("Ok"),
                  ),
                ],
              );
            },
          );
        })
        .onError((error, stackTrace) {
          print(error);
        });
    // UI-only form; add submission behavior later.
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
                          Text(
                            "HAK",
                            style: FontStyles.mainHeadingLeft.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "BANG",
                            style: FontStyles.mainHeadingRight.copyWith(
                              fontSize: 24,
                            ),
                          ),
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
                    onContinue: () {
                      if (!Verifications.verifyCredentials([
                        fullNameController.text,
                        emailController.text,
                        passwordController.text,
                        passwordController.text,
                      ])) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Required fields are not filled"),
                          ),
                        );
                      } else if (!Verifications.checkPasswordLength(
                        passwordController.text,
                      )) {
                        passwordController.clear();
                        confirmPasswordController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Password must be 8 characters long"),
                          ),
                        );
                      } else if (!Verifications.checkPasswordFormat(
                        passwordController.text,
                      )) {
                        passwordController.clear();
                        confirmPasswordController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Password must contain upper case, lower case and numbers",
                            ),
                          ),
                        );
                      } else if (!Verifications.checkPasswordMatch(
                        passwordController.text,
                        confirmPasswordController.text,
                      )) {
                        passwordController.clear();
                        confirmPasswordController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Passwords do not match"),
                          ),
                        );
                      } else {
                        print(passwordController.text);
                        _nextStep();
                      }
                    },
                    onSignIn: () {
                      // Navigate to sign in
                    },
                  ),
                  SignupStep2(
                    selectedAvatarIndex: _selectedAvatarIndex,
                    selectedIdentityIndex: _selectedIdentityIndex,
                    schoolController: schoolController,
                    gradeController: gradeController,
                    avatars: avatars,
                    identities: identities,
                    onAvatarSelected: (index) {
                      setState(() {
                        _selectedAvatarIndex = index;
                      });
                    },
                    onIdentitySelected: (index) {
                      setState(() {
                        _selectedIdentityIndex = index;
                      });
                    },
                    onContinue: () {
                      if (_selectedAvatarIndex == null ||
                          _selectedIdentityIndex == null ||
                          schoolController.text.trim().isEmpty ||
                          gradeController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Required fields are not filled"),
                          ),
                        );
                      } else {
                        _nextStep();
                      }
                    },
                    onBack: _previousStep,
                  ),
                  SignupStep3(
                    selectedAvatarIndex: _selectedAvatarIndex,
                    avatars: avatars,
                    fullName: fullNameController.text,
                    email: emailController.text,
                    selectedIdentityIndex: _selectedIdentityIndex,
                    identities: identities,
                    grade: gradeController.text,
                    onCreate: () {
                      if (!Verifications.checkTerms()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Please check if you agree to the terms",
                            ),
                          ),
                        );
                      } else {
                        _onSubmit();
                      }
                    },
                    onBack: _previousStep,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(color: Color(0xFF2a2d38), thickness: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: FontStyles.memberSignIn,
                      ),
                      TextButton(
                        onPressed: () async {
                          userPosition.value =
                              await Locations.getUserLocation();
                          if (!mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                        },
                        child: Text("Sign In", style: FontStyles.signIntext),
                      ),
                    ],
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

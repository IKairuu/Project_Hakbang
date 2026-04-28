import 'package:flutter/material.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/internet.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/functions/verifications.dart';
import 'package:hakbang/main.dart';
import 'package:hakbang/models/occupation_option.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/login_page.dart';
import 'package:hakbang/pages/no_internet_page.dart';
import 'package:hakbang/server/database/database.dart';
import 'package:hakbang/widgets/signup_step1.dart';
import 'package:hakbang/widgets/signup_step2.dart';
import 'package:hakbang/widgets/signup_step3.dart';
import 'package:hakbang/widgets/signup_progress_indicator.dart';
import 'package:hakbang/widgets/auth_gradient_bg.dart';

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
  int? _selectedOccupationIndex;
  late TextEditingController schoolController;
  late TextEditingController gradeController;

  bool showPassword = false;
  bool showConfirmPassword = false;

  final List<String> avatars = ['🦁', '🦊', '🐉', '🦅', '🐬'];
  final List<occupationOption> occupations = [
    occupationOption(
      emoji: '🧑‍🎓',
      title: 'Student',
      subtitle: 'Grade 11 - 12\n ',
    ),
    occupationOption(
      emoji: '👨‍👩‍👧',
      title: 'Parent',
      subtitle: 'Supporting a\nstudent',
    ),
    occupationOption(
      emoji: '🏫',
      title: 'Counselor',
      subtitle: 'School Staff\n ',
    ),
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
    if (!await Internet.checkInternetConnection()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("There is no internet connection"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NoInternetPage(currentWidget: MyHomePage()),
        ),
      );
    } else {
      final data = {
        "data": {
          "name": fullNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "avatar": avatars[_selectedAvatarIndex!],
          "occupation": occupations[_selectedOccupationIndex!].title,
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
                  backgroundColor: Color(0xFF343943),
                  title: Text(
                    value["message"],
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonDesign.alertDialog,
                      onPressed: () {
                        fullNameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                        _selectedAvatarIndex = null;
                        _selectedOccupationIndex = null;
                        schoolController.clear();
                        gradeController.clear();
                        agreeToTerms.value = false;
                        Navigator.of(context).pop();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: Text("Ok"),
                    ),
                  ],
                );
              },
            );
          })
          .onError((error, stackTrace) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Server Error"),
                backgroundColor: Color(0xFF343943),
                actions: [
                  ElevatedButton(
                    style: ButtonDesign.alertDialog,
                    onPressed: () {
                      fullNameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      _selectedAvatarIndex = null;
                      _selectedOccupationIndex = null;
                      schoolController.clear();
                      gradeController.clear();
                      agreeToTerms.value = false;
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    },
                    child: Text("Ok"),
                  ),
                ],
              ),
            );
          });
    }

    // UI-only form; add submission behavior later.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundDesign.startPageColor,
      body: Stack(
        children: [
          const AuthGradientBg(),
          SafeArea(
            child: Column(
              children: [
                // Header with logo, HAKBANG text, and progress indicator
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
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
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable swipe
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
                                content: Text(
                                  "Password must be 8 characters long",
                                ),
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
                            _nextStep();
                          }
                        },
                        onSignIn: () {
                          // Navigate to sign in
                        },
                      ),
                      SignupStep2(
                        selectedAvatarIndex: _selectedAvatarIndex,
                        selectedOccupationIndex: _selectedOccupationIndex,
                        schoolController: schoolController,
                        gradeController: gradeController,
                        avatars: avatars,
                        occupations: occupations,
                        onAvatarSelected: (index) {
                          setState(() {
                            _selectedAvatarIndex = index;
                          });
                        },
                        onOccupationSelected: (index) {
                          setState(() {
                            _selectedOccupationIndex = index;
                          });
                        },
                        onContinue: () {
                          if (_selectedAvatarIndex == null ||
                              _selectedOccupationIndex == null ||
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
                        selectedOccupationIndex: _selectedOccupationIndex,
                        occupations: occupations,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
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
                              try {
                                await Locations.initializeLocationServices();
                                userPosition.value =
                                    await Locations.getUserLocation();
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Location permission required to sign in',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Sign In",
                              style: FontStyles.highlightText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

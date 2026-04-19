import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/models/user.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/main_page.dart';
import 'package:hakbang/pages/signup_page.dart';
import 'package:hakbang/server/database/database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  bool _showPassword = false;
  bool _showError = false;
  String _errorText = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    FocusScope.of(context).unfocus();
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _showError = true;
        _errorText = 'Please fill in all fields.';
      });
      return;
    }

    setState(() => _showError = false);

    var login = await Database.userLogin(email, password);
    switch (login["status"]) {
      case 200:
        userCredentials.value = User(
          name: login["data"]["name"],
          email: login["data"]["email"],
          avatar: login["data"]["avatar"],
          grade: login["data"]["grade"],
          institution: login["data"]["institution"],
          occupation: login["data"]["occupation"],
        );
        token.value = "Bearer ${login["token"]}";
        Initialization.mainInitialization();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(login["message"]),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        break;
      case 401:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(login["message"]),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Server Error"),
          ),
        );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Color(0xFFC8FF4D),
                  year2023: true,
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 36),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          buildHeader(),
                          const SizedBox(height: 32),
                          buildTitle(),
                          if (_showError) ...[
                            const SizedBox(height: 20),
                            buildErrorBanner(_errorText),
                          ],
                          const SizedBox(height: 28),
                          buildTextField(
                            'EMAIL ADDRESS',
                            'you@example.com',
                            '✉',
                            _emailController,
                          ),
                          const SizedBox(height: 14),
                          buildTextField(
                            'PASSWORD',
                            'Enter your password',
                            '🔒',
                            _passwordController,
                            isPassword: true,
                            trailing: GestureDetector(
                              onTap: () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                              child: Text(
                                _showPassword ? '🙈' : '👁',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(1, 1),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: AppColors.onAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textStyle: GoogleFonts.dmSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: _handleLogin,
                              child: const Text('Sign In →'),
                            ),
                          ),
                          const SizedBox(height: 18),
                          buildDivider(),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.border2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create Account',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildFooterText(),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget buildHeader() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(width: 10),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'HAK',
              style: GoogleFonts.unbounded(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            TextSpan(
              text: 'BANG',
              style: GoogleFonts.unbounded(
                color: AppColors.accent,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildTitle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Welcome back 👋',
        style: GoogleFonts.inter(
          color: AppColors.textPrimary,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.6,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        'Sign in to continue your college journey.',
        style: GoogleFonts.dmSans(
          color: AppColors.textSecondary,
          fontSize: 13,
          height: 1.6,
        ),
      ),
    ],
  );
}

Widget buildErrorBanner(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0x1AFF6B4D),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x40FF6B4D)),
    ),
    child: Row(
      children: [
        const Text('⚠️', style: TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            message,
            style: GoogleFonts.dmSans(
              color: AppColors.coral,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextField(
  String label,
  String placeholder,
  String iconEmoji,
  TextEditingController controller, {
  bool isPassword = false,
  bool showPassword = false,
  Widget? trailing,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.dmSans(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      const SizedBox(height: 7),
      Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            controller: controller,
            obscureText: isPassword && !showPassword,
            cursorColor: AppColors.accent,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: AppColors.surface2,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14, right: 8),
                child: Text(
                  iconEmoji,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 15),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              contentPadding: EdgeInsets.only(
                right: trailing != null ? 44 : 14,
                top: 13,
                bottom: 13,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.border2, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.accent, width: 1.5),
              ),
            ),
          ),
          if (trailing != null)
            Padding(padding: const EdgeInsets.only(right: 14), child: trailing),
        ],
      ),
    ],
  );
}

Widget buildDivider() {
  return Row(
    children: [
      Expanded(child: Container(height: 1, color: AppColors.border)),
      const SizedBox(width: 12),
      Text(
        "Don't have an account?",
        style: GoogleFonts.dmSans(
          color: AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(child: Container(height: 1, color: AppColors.border)),
    ],
  );
}

Widget buildFooterText() {
  return Center(
    child: Text.rich(
      TextSpan(
        text: 'By signing in, you agree to our ',
        style: GoogleFonts.dmSans(color: AppColors.textSecondary, fontSize: 13),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: GoogleFonts.dmSans(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: GoogleFonts.dmSans(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );
}

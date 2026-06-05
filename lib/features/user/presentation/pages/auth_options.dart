import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/features/user/data/user_repo.dart';
import 'package:hakbang/features/user/presentation/design/app_colors.dart';
import 'package:hakbang/features/user/presentation/design/button_design.dart';
import 'package:hakbang/features/user/presentation/design/font_styles.dart';
import 'package:hakbang/features/user/presentation/design/input_design.dart';
import 'package:hakbang/features/user/presentation/pages/verification_timer.dart';
import 'package:hakbang/functions/verifications.dart';

class AuthOptions extends StatefulWidget {
  const AuthOptions({super.key});

  @override
  State<AuthOptions> createState() => _AuthOptionsState();
}

class _AuthOptionsState extends State<AuthOptions> {
  TextEditingController emailController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Widget _buildGoogleSignInButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            isLoading.value = true;
            var userDetails = await Verifications.authentication();
            if (userDetails == null) {
              throw "No Email found";
            }
            var data = await UserRepo.requestCode(userDetails["email"]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationTimer(
                  email: userDetails["email"],
                  token: data["token"],
                  fullname: userDetails["fullname"],
                ),
              ),
            );
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(error.toString()),
              ),
            );
          } finally {
            isLoading.value = false;
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
              'Continue with Google →',
              style: FontStyles.signupContinueButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          try {
            isLoading.value = true;
            var data = await UserRepo.requestCode(emailController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationTimer(
                  email: emailController.text,
                  token: data["token"],
                ),
              ),
            );
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(error.toString()),
              ),
            );
          } finally {
            isLoading.value = false;
          }
        },
        style: ButtonDesign.signUpButton,
        child: Text('SIGN UP', style: FontStyles.signupContinueButton),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.accent,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/hakbang_logo.png"),
        ),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'HAK',
          style: GoogleFonts.unbounded(
            fontSize: 26,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        Text(
          'BANG',
          style: GoogleFonts.unbounded(
            fontSize: 26,
            color: AppColors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparators() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 2,
            height: 2,
            indent: 5,
            endIndent: 5,
          ),
        ),
        Text(
          "OR SIGN UP WITH",
          style: GoogleFonts.dmSans(color: AppColors.textPrimary),
        ),
        Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 2,
            height: 10,
            indent: 5,
            endIndent: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Align(widthFactor: 1, heightFactor: 1, child: prefixIcon),
        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
        filled: true,
        fillColor: AppColors.surface2,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        border: InputDesign.borderInput(color: AppColors.border2, width: 1.5),
        enabledBorder: InputDesign.borderInput(
          color: AppColors.border2,
          width: 1.5,
        ),
        focusedBorder: InputDesign.borderInput(
          color: AppColors.accent,
          width: 1.5,
        ),
      ),
      style: FontStyles.inputText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.textPrimary,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, loading, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: loading
                    ? ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Align(
                          alignment: Alignment(0, -0.2),
                          child: CircularProgressIndicator(
                            color: AppColors.accent,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLogo(),
                          const SizedBox(height: 5),
                          _buildTitle(),
                          const SizedBox(height: 20),
                          _buildInputField(
                            controller: emailController,
                            hintText: "Input Email here",
                            prefixIcon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildContinueButton(),
                          const SizedBox(height: 20),
                          _buildSeparators(),
                          const SizedBox(height: 10),
                          _buildGoogleSignInButton(),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

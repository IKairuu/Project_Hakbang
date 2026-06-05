import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/features/user/data/user_repo.dart';
import 'package:hakbang/features/user/presentation/design/app_colors.dart';
import 'package:hakbang/features/user/presentation/pages/signup_page.dart';
import 'package:pinput/pinput.dart';

class VerificationTimer extends StatefulWidget {
  final String? fullname;
  final String email;
  final String token;
  const VerificationTimer({
    super.key,
    required this.email,
    required this.token,
    this.fullname,
  });

  @override
  State<VerificationTimer> createState() => _VerificationTimerState();
}

class _VerificationTimerState extends State<VerificationTimer> {
  ValueNotifier<int> endTime = ValueNotifier(
    DateTime.now().millisecondsSinceEpoch + 1000 * 59,
  );
  late ValueNotifier<String> activeToken = ValueNotifier(widget.token);
  late ValueNotifier<CountdownTimerController> countTime = ValueNotifier(
    CountdownTimerController(endTime: endTime.value),
  );

  Widget _buildCodeField(String token) {
    return Pinput(
      length: 6,
      focusedPinTheme: PinTheme(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.surface2,
        ),
        height: 50,
        width: 50,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      defaultPinTheme: PinTheme(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.surface2,
        ),
        height: 40,
        width: 40,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      enabled: true,
      onCompleted: (value) async {
        try {
          var data = await UserRepo.verifyCode(token, value);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(data["message"]),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignupPage(
                authFullname: widget.fullname,
                authemail: widget.email,
                token: token,
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
        }
      },
    );
  }

  @override
  void dispose() {
    countTime.value.dispose();
    endTime.value = DateTime.now().millisecondsSinceEpoch + 1000 * 59;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      countTime.value = CountdownTimerController(endTime: endTime.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          "Verify Account",
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "To verify your account, please check the verification code sent to your account: ${widget.email} ",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: activeToken,
                builder: (context, token, child) {
                  return _buildCodeField(token);
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: countTime,
                builder: (context, count, child) {
                  return ValueListenableBuilder(
                    valueListenable: endTime,
                    builder: (context, end, child) {
                      return CountdownTimer(
                        controller: count,
                        endTime: end,
                        widgetBuilder: (context, time) {
                          if (time == null) {
                            return TextButton(
                              onPressed: () async {
                                try {
                                  var data = await UserRepo.requestCode(
                                    widget.email,
                                  );
                                  setState(() {
                                    activeToken.value = data["token"];
                                    endTime.value =
                                        DateTime.now().millisecondsSinceEpoch +
                                        1000 * 60;
                                    countTime.value = CountdownTimerController(
                                      endTime: endTime.value,
                                    );
                                  });
                                } catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error.toString())),
                                  );
                                }
                              },
                              child: Text(
                                "Resend Code?",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }
                          return Text(
                            ' Resend Verification Email in 00:${time.sec! > 9 ? time.sec : "0${time.sec}"}',
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

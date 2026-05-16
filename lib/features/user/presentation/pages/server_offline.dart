import 'package:flutter/material.dart';
import 'package:hakbang/features/user/presentation/design/font_styles.dart';
import 'package:lottie/lottie.dart';

class ServerOffline extends StatelessWidget {
  const ServerOffline({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0D10),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/noInternet.json",
                height: 150,
                width: 150,
              ),
              Text(
                "Cannot reach the server, Please try again later",
                style: FontStyles.noInternetConnection,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

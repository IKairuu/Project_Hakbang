import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key, required this.currentWidget});
  final Widget currentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0D10),
      body: Center(
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
              "No Internet Connection",
              style: FontStyles.noInternetConnection,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ButtonDesign.mainButton,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => currentWidget),
                  );
                },
                child: Text("Retry", style: FontStyles.continueButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

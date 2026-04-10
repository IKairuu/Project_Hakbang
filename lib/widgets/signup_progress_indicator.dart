import 'package:flutter/material.dart';

class SignupProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const SignupProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 3,
            decoration: BoxDecoration(
              color: index <= currentStep
                  ? const Color(0xFFC8FF4D) // Active step - lime green
                  : const Color(0xFF2a2d38), // Inactive step - gray
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
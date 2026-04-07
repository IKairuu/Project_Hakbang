import 'package:flutter/material.dart';
import 'package:hakbang/widgets/welcome_widget.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: WelcomeWidget(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hakbang/design/font_styles.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:40, right:20, left: 20),
      child: Column(
        children: [Text("Scholarships", 
        style: FontStyles.header)],
        )
    );
  }
}
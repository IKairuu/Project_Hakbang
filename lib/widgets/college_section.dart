import 'package:flutter/material.dart';
import 'package:hakbang/models/college.dart';

class CollegeSection extends StatefulWidget {
  const CollegeSection({super.key, required this.college});
  final College college;
  @override
  State<CollegeSection> createState() => _CollegeSectionState();
}

class _CollegeSectionState extends State<CollegeSection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

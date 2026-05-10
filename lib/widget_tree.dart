import 'package:flutter/material.dart';
import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/pages/start_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  void initState() {
    super.initState();
    initializeLocation();
  }

  void initializeLocation() async {
    await Locations.initializeLocationServices();
  }

  @override
  Widget build(BuildContext context) {
    return StartPage();
  }
}

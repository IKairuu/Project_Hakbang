import 'package:flutter/material.dart';
import 'package:hakbang/design/font_styles.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        children: [Text("Discover Schools", style: FontStyles.header)],
      ),
    );
  }
}

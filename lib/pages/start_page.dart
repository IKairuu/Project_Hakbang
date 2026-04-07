import 'package:flutter/material.dart';
import 'package:hakbang/design/container_design.dart';

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
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: ContainerDesign.start_image,
              child: Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }
}

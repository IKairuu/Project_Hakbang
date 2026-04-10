import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Hello, NAME",
                              style: FontStyles.mainPageheader,
                            ),
                          ),
                          Text("👋", style: TextStyle(fontSize: 35)),
                        ],
                      ),
                      Text(
                        "Where would you like to go?",
                        style: FontStyles.mainPageUnderName,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  decoration: ContainerDesign.homeAvatar,
                  child: Text("🦁", style: TextStyle(fontSize: 40)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: ContainerDesign.reviewUpg,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1.87", style: FontStyles.upgNumber),
                              Text(
                                "Current UPG",
                                style: FontStyles.labelMainPage,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("3", style: FontStyles.savedSchoolNumber),
                            Text(
                              "Saved Schools",
                              style: FontStyles.labelMainPage,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ButtonDesign.mainButton,
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Review UPG", style: FontStyles.reviewUpg),
                              Icon(
                                Icons.arrow_right_alt_rounded,
                                color: Colors.black,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

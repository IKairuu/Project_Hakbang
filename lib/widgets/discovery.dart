import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/input_design.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  TextEditingController searchInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Discover Schools", style: FontStyles.discoveryHeader),
          Expanded(
            flex: 1,
            child: TextField(
              controller: searchInput,
              decoration: InputDesign.unfocusedInputDecoration(
                'Search school',
                prefixIcon: const Opacity(
                  opacity: 0.5,
                  child: Icon(
                    Icons.search_outlined,
                    size: 20,
                    color: Color(0xFF828a8a), // keep or remove, either is fine
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Row(
                    spacing: 5,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonDesign.filterUniversity,
                        child: Text("All", style: FontStyles.filterLabel),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonDesign.filterUniversity,
                        child: Text(
                          "State University",
                          style: FontStyles.filterLabel,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonDesign.filterUniversity,
                        child: Text("Private", style: FontStyles.filterLabel),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonDesign.filterUniversity,
                        child: Text(
                          "With Scholarhship",
                          style: FontStyles.filterLabel,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/notifiers.dart';

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
          TextField(
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
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(decoration: ContainerDesign.universityLocation),
          ),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder(
              valueListenable: availableColleges,
              builder: (context, univ, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "${univ.isEmpty ? "No" : univ.length} available ${univ.length <= 1 ? "school" : "schools"}",
                          style: FontStyles.availSchoolsLabel,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

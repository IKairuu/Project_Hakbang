import 'package:flutter/material.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/widgets/college_section.dart';

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
              child: ValueListenableBuilder(
                valueListenable: selectedFilter,
                builder: (context, selected, child) {
                  return SizedBox(
                    child: Row(
                      spacing: 5,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter.value = [true, false, false];
                            });
                          },
                          style: selected[0]
                              ? ButtonDesign.filterUniversitySelected
                              : ButtonDesign.filterUniversityUnselected,
                          child: Text(
                            "All",
                            style: selected[0]
                                ? FontStyles.filterLabelSelected
                                : FontStyles.filterLabelUnselected,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter.value = [false, true, false];
                            });
                          },
                          style: selected[1]
                              ? ButtonDesign.filterUniversitySelected
                              : ButtonDesign.filterUniversityUnselected,
                          child: Text(
                            "State University",
                            style: selected[1]
                                ? FontStyles.filterLabelSelected
                                : FontStyles.filterLabelUnselected,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter.value = [false, false, true];
                            });
                          },
                          style: selected[2]
                              ? ButtonDesign.filterUniversitySelected
                              : ButtonDesign.filterUniversityUnselected,
                          child: Text(
                            "Private",
                            style: selected[2]
                                ? FontStyles.filterLabelSelected
                                : FontStyles.filterLabelUnselected,
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                        ValueListenableBuilder(
                          valueListenable: selectedFilter,
                          builder: (context, value, child) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                if (value[0]) {
                                  return CollegeSection(college: univ[index]);
                                }
                              },
                            );
                          },
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

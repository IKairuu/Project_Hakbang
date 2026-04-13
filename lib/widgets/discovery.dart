import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/design/input_design.dart';
import 'package:hakbang/functions/filter.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/builds/college_section.dart';
import 'package:latlong2/latlong.dart';

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
      child: ValueListenableBuilder(
        valueListenable: selectedSchoolHover,
        builder: (context, schoolSelected, child) {
          return Column(
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
                      color: Color(
                        0xFF828a8a,
                      ), // keep or remove, either is fine
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                              Filter.filterCollegeSection(
                                availableColleges.value,
                              );
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
                              Filter.filterCollegeSection(
                                availableColleges.value,
                              );
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
                              Filter.filterCollegeSection(
                                availableColleges.value,
                              );
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
              Expanded(
                flex: 3,
                child: Container(
                  decoration: ContainerDesign.universityLocation,
                  child: schoolSelected.contains(true)
                      ? ValueListenableBuilder(
                          valueListenable: userPosition,
                          builder: (context, user, child) {
                            return ValueListenableBuilder(
                              valueListenable: selectedSchoolPosition,
                              builder: (context, school, child) {
                                return FlutterMap(
                                  options: MapOptions(
                                    initialCenter: LatLng(
                                      user!.latitude,
                                      user.longitude,
                                    ), // Center the map over London, UK
                                    initialZoom: 9,
                                    maxZoom: 9,
                                  ),
                                  children: [
                                    TileLayer(
                                      // Bring your own tiles
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName:
                                          "com.example.hakbang",
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: LatLng(
                                            school!.latitude,
                                            school.longitude,
                                          ),
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Marker(
                                          point: LatLng(
                                            user.latitude,
                                            user.longitude,
                                          ),
                                          child: Icon(
                                            Icons.location_history_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "There is no selected university",
                            style: FontStyles.mapLabel,
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ValueListenableBuilder(
                  valueListenable: collegeSection,
                  builder: (context, univ, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${univ.isEmpty ? "No" : univ.length} available ${univ.length <= 1 ? "school" : "schools"}",
                              style: FontStyles.availSchoolsLabel,
                            ),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder(
                                valueListenable: selectedFilter,
                                builder: (context, value, child) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(top: 10),
                                    itemCount: univ.length,
                                    itemBuilder: (context, index) {
                                      return CollegeSection(
                                        college: univ[index],
                                        sectionIndex: index,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

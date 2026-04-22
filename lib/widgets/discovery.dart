import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/button_design.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/functions/filter.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/builds/college_section.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

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
          return ValueListenableBuilder(
            valueListenable: onSelect,
            builder: (context, onSelected, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Discover Schools", style: FontStyles.header),
                  const SizedBox(height: 3),
                  Text(
                    "Find the best university for you",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    onSubmitted: (value) {
                      Filter.searchCollege(searchInput.text);
                    },
                    controller: searchInput,
                    cursorColor: AppColors.accent,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.surface2,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.accent,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.border2,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Search school",
                      suffixIcon: IconButton(
                        onPressed: () {
                          Filter.searchCollege(searchInput.text);
                        },
                        icon: Icon(Icons.search_outlined),
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
                                    selectedFilter.value = [
                                      true,
                                      false,
                                      false,
                                      false,
                                    ];
                                  });
                                  searchInput.clear();
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
                                    selectedFilter.value = [
                                      false,
                                      true,
                                      false,
                                      false,
                                    ];
                                  });
                                  searchInput.clear();
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
                                    selectedFilter.value = [
                                      false,
                                      false,
                                      true,
                                      false,
                                    ];
                                  });
                                  searchInput.clear();
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
                  onSelected.isEmpty
                      ? SizedBox()
                      : Expanded(
                          flex: 4,
                          child: Container(
                            decoration: ContainerDesign.universityLocation,
                            child: ValueListenableBuilder(
                              valueListenable: userPosition,
                              builder: (context, user, child) {
                                return ValueListenableBuilder(
                                  valueListenable: selectedSchoolPosition,
                                  builder: (context, school, child) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: FlutterMap(
                                        options: MapOptions(
                                          initialCenter: LatLng(
                                            user!.latitude,
                                            user.longitude,
                                          ), // Center the map over London, UK
                                          initialZoom: 6,
                                          maxZoom: 100,
                                          minZoom: 6,
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
                                                rotate: true,
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
                                                rotate: true,
                                                point: LatLng(
                                                  user.latitude,
                                                  user.longitude,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .location_history_rounded,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                  Expanded(
                    flex: onSelected.isEmpty ? 3 : 5,
                    child: ValueListenableBuilder(
                      valueListenable: collegeSection,
                      builder: (context, univ, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "${univ.isEmpty ? "No" : univ.length} Available ${univ.length <= 1 ? "School" : "Schools"}",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: 5),
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
          );
        },
      ),
    );
  }
}

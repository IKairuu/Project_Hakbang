import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hakbang/models/activity.dart';
import 'package:hakbang/models/college.dart';
import 'package:latlong2/latlong.dart';

ValueNotifier<int> welcomePageIndex = ValueNotifier(0);
ValueNotifier<int> navigationBarIndex = ValueNotifier(0);
ValueNotifier<List<Activity>> activityList = ValueNotifier([
  Activity(
    // FOR TESTING PURPOSES
    description: "Viewed UPCAT",
    iconName: "assets/exam.svg",
    date: "Mar. 3, 2026",
  ),
  Activity(
    // FOR TESTING PURPOSES
    description: "Viewed UPCAT",
    iconName: "assets/exam.svg",
    date: "Mar. 33, 2026",
  ),
  Activity(
    // FOR TESTING PURPOSES
    description: "Viewed UPCAT",
    iconName: "assets/exam.svg",
    date: "Mar. 2, 2026",
  ),
]);
ValueNotifier<List<bool>> selectedFilter = ValueNotifier([true, false, false]);
ValueNotifier<Position?> userPosition = ValueNotifier(null);
ValueNotifier<LatLng?> selectedSchoolPosition = ValueNotifier(null);
ValueNotifier<String?> selectedSchool = ValueNotifier(null);
ValueNotifier<List<bool>> selectedSchoolHover = ValueNotifier([]);
ValueNotifier<List<College>> availableColleges = ValueNotifier([]);
ValueNotifier<List<College>> collegeSection = ValueNotifier([]);

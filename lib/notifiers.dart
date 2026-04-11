import 'package:flutter/material.dart';
import 'package:hakbang/objects/activity.dart';

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

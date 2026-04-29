import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hakbang/models/activity.dart';
import 'package:hakbang/models/ai_message.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/models/review_center.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/models/user.dart';
import 'package:latlong2/latlong.dart';

ValueNotifier<int> welcomePageIndex = ValueNotifier(0);
ValueNotifier<int> navigationBarIndex = ValueNotifier(2);
ValueNotifier<User?> userCredentials = ValueNotifier(null);
ValueNotifier<String?> token = ValueNotifier(null);
ValueNotifier<List<Activity>> activityList = ValueNotifier([]);
ValueNotifier<bool> agreeToTerms = ValueNotifier(false);
ValueNotifier<List<bool>> selectedFilter = ValueNotifier([
  true,
  false,
  false,
  false,
]);
ValueNotifier<Position?> userPosition = ValueNotifier(null);
ValueNotifier<LatLng?> selectedSchoolPosition = ValueNotifier(null);
ValueNotifier<List<bool>> selectedSchoolHover = ValueNotifier([]);
ValueNotifier<List<College>> availableColleges = ValueNotifier([]);
ValueNotifier<String> onSelect = ValueNotifier("");
ValueNotifier<List<ScholarshipObject>> availableScholarships = ValueNotifier(
  [],
);
ValueNotifier<List<College>> collegeSection = ValueNotifier([]);
ValueNotifier<List<AiMessage>> chatMessages = ValueNotifier([]);
ValueNotifier<bool> chatLoading = ValueNotifier(false);
ValueNotifier<List<College>> savedSchools = ValueNotifier([]);
ValueNotifier<bool> hasInternetConnection = ValueNotifier(false);
ValueNotifier<List<ReviewCenter>> availableReviewCenters = ValueNotifier([]);
ValueNotifier<List<ReviewCenter>> reviewCenterSection = ValueNotifier([]);
ValueNotifier<ScholarshipObject?> featuredScholarship = ValueNotifier(null);

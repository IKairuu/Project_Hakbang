import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hakbang/features/data/models/activity.dart';
import 'package:hakbang/features/data/models/ai_message.dart';
import 'package:hakbang/features/data/models/college.dart';
import 'package:hakbang/features/data/models/review_center.dart';
import 'package:hakbang/features/data/models/scholarship_object.dart';
import 'package:hakbang/features/data/models/user.dart';
import 'package:latlong2/latlong.dart';

ValueNotifier<bool> connectedToServer = ValueNotifier(false);
ValueNotifier<int> welcomePageIndex = ValueNotifier(0);
ValueNotifier<int> navigationBarIndex = ValueNotifier(2);
ValueNotifier<User?> userCredentials = ValueNotifier(null);
ValueNotifier<String?> token = ValueNotifier(null);
ValueNotifier<List<Activity>> activityList = ValueNotifier([]);
ValueNotifier<bool> agreeToTerms = ValueNotifier(false);
ValueNotifier<bool?> locationEnabled = ValueNotifier(null);
ValueNotifier<List<bool>> selectedFilter = ValueNotifier([true, false, false]);
ValueNotifier<List<bool>> selectedHubFilter = ValueNotifier([
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
ValueNotifier<List<Map<String, dynamic>>> rawSavedScholarships = ValueNotifier(
  [],
);
ValueNotifier<List<Map<String, dynamic>>> rawSavedSchools = ValueNotifier([]);
ValueNotifier<bool> governmentSelected = ValueNotifier(true);
ValueNotifier<List<ScholarshipObject>> governmentSection = ValueNotifier([]);
ValueNotifier<List<ScholarshipObject>> nonGovernmentSection = ValueNotifier([]);
ValueNotifier<List<College>> collegeSection = ValueNotifier([]);
ValueNotifier<List<AiMessage>> chatMessages = ValueNotifier([]);
ValueNotifier<bool> chatLoading = ValueNotifier(false);
ValueNotifier<List<College>> savedSchools = ValueNotifier([]);
ValueNotifier<List<ScholarshipObject>> savedScholarships = ValueNotifier([]);
ValueNotifier<bool> hasInternetConnection = ValueNotifier(false);
ValueNotifier<List<ReviewCenter>> availableReviewCenters = ValueNotifier([]);
ValueNotifier<List<ReviewCenter>> reviewCenterSection = ValueNotifier([]);
ValueNotifier<ScholarshipObject?> featuredScholarship = ValueNotifier(null);

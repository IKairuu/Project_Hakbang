import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/features/user/data/models/ai_message.dart';
import 'package:hakbang/features/college/college_model.dart';
import 'package:hakbang/features/center/center_model.dart';
import 'package:hakbang/features/scholarship/scholarship_model.dart';
import 'package:hakbang/features/user/data/models/user.dart';
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
ValueNotifier<List<CollegeModel>> availableColleges = ValueNotifier([]);
ValueNotifier<String> onSelect = ValueNotifier("");
ValueNotifier<List<ScholarshipModel>> availableScholarships = ValueNotifier([]);
ValueNotifier<List<Map<String, dynamic>>> rawSavedScholarships = ValueNotifier(
  [],
);
ValueNotifier<List<Map<String, dynamic>>> rawSavedSchools = ValueNotifier([]);
ValueNotifier<bool> governmentSelected = ValueNotifier(true);
ValueNotifier<List<ScholarshipModel>> governmentSection = ValueNotifier([]);
ValueNotifier<List<ScholarshipModel>> nonGovernmentSection = ValueNotifier([]);
ValueNotifier<List<CollegeModel>> collegeSection = ValueNotifier([]);
ValueNotifier<List<AiMessage>> chatMessages = ValueNotifier([]);
ValueNotifier<bool> chatLoading = ValueNotifier(false);
ValueNotifier<List<CollegeModel>> savedSchools = ValueNotifier([]);
ValueNotifier<List<ScholarshipModel>> savedScholarships = ValueNotifier([]);
ValueNotifier<bool> hasInternetConnection = ValueNotifier(false);
ValueNotifier<List<CenterModel>> availableReviewCenters = ValueNotifier([]);
ValueNotifier<List<CenterModel>> reviewCenterSection = ValueNotifier([]);
ValueNotifier<ScholarshipModel?> featuredScholarship = ValueNotifier(null);

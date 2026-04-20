import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hakbang/models/activity.dart';
import 'package:hakbang/models/ai_message.dart';
import 'package:hakbang/models/college.dart';
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
ValueNotifier<String?> selectedSchool = ValueNotifier(null);
ValueNotifier<List<bool>> selectedSchoolHover = ValueNotifier([]);
ValueNotifier<List<College>> availableColleges = ValueNotifier([]);
ValueNotifier<List<ScholarshipObject>> availableScholarships = ValueNotifier(
  [],
);
ValueNotifier<List<College>> collegeSection = ValueNotifier([]);
ValueNotifier<List<AiMessage>> chatMessages = ValueNotifier([]);
ValueNotifier<bool> chatLoading = ValueNotifier(false);
ValueNotifier<List<College>> savedSchools = ValueNotifier([]);
ValueNotifier<bool> hasInternetConnection = ValueNotifier(false);
ValueNotifier<List<Map<String, String>>> availableReviewCenters = ValueNotifier(
  [
    {
      'title': 'Academic Gateway — Complete CET Review Program',
      'instructor': 'Academic Gateway · Manila, QC & More',
      'ratingNum': '4.8',
      'stars': '⭐⭐⭐⭐⭐',
      'ratingCount': '(2,140)',
      'price': '₱8,000',
      'originalPrice': '₱12,500',
      'isBestseller': 'true',
      'emoji': '🎓',
    },
    {
      'title': 'Ahead Tutorial — Intensive Review',
      'instructor': 'Ahead Tutorial · Quezon City',
      'ratingNum': '4.7',
      'stars': '⭐⭐⭐⭐',
      'ratingCount': '(1,820)',
      'price': '₱6,500',
      'originalPrice': '₱9,000',
      'isBestseller': 'false',
      'emoji': '🚀',
    },
    {
      'title': 'Review Masters — Exam Prep Series',
      'instructor': 'Review Masters · Pasig, Metro Manila',
      'ratingNum': '4.9',
      'stars': '⭐⭐⭐⭐⭐',
      'ratingCount': '(3,480)',
      'price': '₱7,200',
      'originalPrice': '₱10,000',
      'isBestseller': 'true',
      'emoji': '🏆',
    },
    {
      'title': 'ProReview Institute — CET Mastery Course',
      'instructor': 'ProReview Institute · Cebu City',
      'ratingNum': '4.5',
      'stars': '⭐⭐⭐⭐⭐',
      'ratingCount': '(1,500)',
      'price': '₱5,500',
      'originalPrice': '₱8,000',
      'isBestseller': 'false',
      'emoji': '📚',
    },
    {
      'title': 'SmartStudy Hub — Comprehensive Review',
      'instructor': 'SmartStudy Hub · Davao',
      'ratingNum': '4.9',
      'stars': '⭐⭐⭐⭐⭐',
      'ratingCount': '(2,800)',
      'price': '₱9,000',
      'originalPrice': '₱13,000',
      'isBestseller': 'true',
      'emoji': '🧠',
    },
    {
      'title': 'ExamPro Academy — Intensive CET Prep',
      'instructor': 'ExamPro Academy · Baguio',
      'ratingNum': '4.4',
      'stars': '⭐⭐⭐⭐',
      'ratingCount': '(950)',
      'price': '₱4,200',
      'originalPrice': '₱6,500',
      'isBestseller': 'false',
      'emoji': '📖',
    },
    {
      'title': 'TopScore Reviews — Elite CET Training',
      'instructor': 'TopScore Reviews · Iloilo',
      'ratingNum': '4.8',
      'stars': '⭐⭐⭐⭐⭐',
      'ratingCount': '(2,200)',
      'price': '₱7,500',
      'originalPrice': '₱11,000',
      'isBestseller': 'true',
      'emoji': '🎯',
    },
  ],
);

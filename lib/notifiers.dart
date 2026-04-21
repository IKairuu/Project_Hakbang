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
ValueNotifier<List<Map<String, dynamic>>>
availableReviewCenters = ValueNotifier([
  {
    'title': 'AHEAD Tutorial & Review — CET + Science HS Entrance Prep',
    'instructor': 'AHEAD · Katipunan QC + other locations',
    'ratingNum': '4.8',
    'stars': '⭐⭐⭐⭐⭐',
    'ratingCount': '(2,300)',
    'price': '₱12,500',
    'originalPrice': '₱18,000',
    'isBestseller': 'true',
    'emoji': '🏅',
    'subtitle':
        'Test-based review programs for college entrance exams and Philippine Science High School (PSHS) entrance test prep.',
    'description':
        'AHEAD publishes review programs (including College Entrance Test Review Classes and Philippine Science High School Review Classes) and official office address/contact details.',
    'managedBy': 'AHEAD Tutorial & Review Center',
    'modalities': 'On-site · Online · Hybrid',
    'location': '50 Esteban Abada St., Katipunan, Loyola Heights, Quezon City',
    'website': 'https://www.ahead.edu.ph/',
    'phone': '0917-891-1187',
    'email': 'info@ahead.edu.ph',
    'exams':
        'UPCAT, ACET, DCAT, USTET, CET (General), PSHS (Science HS Entrance)',
    'whatYouWillCover': [
      'CET fundamentals: Reading/Language, Math, Science, Abstract/Logical Reasoning',
      'PSHS/Science HS-style Math & Science problem solving (concept mastery + speed)',
      'Timed drills and test-day strategy (pacing, question selection, error control)',
      'Mock exams with guided solution discussions and remediation plans',
    ],
    'programOverview': {
      'modules': 4,
      'sessions': 48,
      'hours': 96,
      'schedule': 'Weekend-focused with optional weekday add-ons (batch-based)',
      'delivery': 'Hybrid',
    },
    'centerOffers': [
      'Live classes + optional online materials',
      'Practice sets and reviewer handouts',
      'Mock exams with score breakdown',
      'Coaching/consultation options',
      'Progress tracking checkpoints',
      'Certificate of completion',
    ],
    'whoThisIsFor': [
      'SHS students preparing for UPCAT/ACET/DCAT/USTET',
      'Students preparing for Science HS entrance tests (PSHS/PISAY track)',
      'Students needing structure, deadlines, and coaching accountability',
    ],
    'aboutThisCenter': {
      'short':
          'Structured review with strong emphasis on timed practice, diagnostics, and strategy coaching.',
      'long':
          'Programs typically combine high-yield content review with repeated timed drills to build speed and accuracy. Students often go through a diagnostic phase, then targeted remediation per subject area, followed by mock tests and solution discussions to refine strategy under pressure.',
    },
  },
  {
    'title': 'ACAD1 Review Center — CET + PISAY/Science HS Admission Tests',
    'instructor': 'ACAD1 · Taft (Manila) + multiple branches',
    'ratingNum': '4.6',
    'stars': '⭐⭐⭐⭐⭐',
    'ratingCount': '(1,500)',
    'price': '₱5,900',
    'originalPrice': '₱7,900',
    'isBestseller': 'true',
    'emoji': '🎓',
    'subtitle':
        'Programs for UPCAT/ACET/DCAT/UST and Science High School admission tests (e.g., PSHS/PISAY).',
    'description':
        'ACAD1 lists College Entrance Exam Review and Science High School Admission Test Review programs, plus address/contact and a branch list on their official site.',
    'managedBy': 'ACAD1 Review Center',
    'modalities': 'On-site · Hybrid',
    'location': '3/F Room 307, 2133 ROL Bldg., Taft Avenue, Manila',
    'website': 'https://acad1.ph/',
    'phone': '+63 905 358 1150',
    'email': 'acad1review@gmail.com',
    'exams':
        'UPCAT, ACET, DCAT, USTET, CET (General), PSHS/PISAY (Science HS Entrance)',
    'whatYouWillCover': [
      'CET coverage: English/Reading, Math, Science, Abstract/Logical Reasoning',
      'Science HS admission test focus: foundational Math/Science + advanced drills',
      'Problem-solving frameworks and speed techniques for high-frequency topics',
      'Mock exams + post-test analytics (topics missed, recurring error patterns)',
    ],
    'programOverview': {
      'modules': 5,
      'sessions': 60,
      'hours': 120,
      'schedule': 'Weekday & weekend batches available',
      'delivery': 'Hybrid',
    },
    'centerOffers': [
      'Hybrid classes (face-to-face + online support when available)',
      'Reviewer sets + drill worksheets',
      'Mock series with solution discussions',
      'Optional coaching sessions',
      'Structured study plan and progress checks',
      'Certificate of completion',
    ],
    'whoThisIsFor': [
      'Grade 11–12 students taking CETs',
      'Students applying to Science High Schools (PSHS/PISAY track)',
      'Students who want a guided plan instead of pure self-review',
    ],
    'aboutThisCenter': {
      'short':
          'Track-based review programs designed for both CET and science high school admission tests.',
      'long':
          'Programs usually start by aligning students to exam formats and identifying weak skills via diagnostics. Instruction then targets high-yield topics, followed by intensive drills and mock exams. Feedback focuses on strategy: time allocation, accuracy under pressure, and fixing patterns of mistakes.',
    },
  },
  {
    'title':
        'Review Masters — UPCAT/CET Review (Katipunan QC + Regional Batches)',
    'instructor': 'Review Masters · One Burgundy Plaza (Katipunan Ave)',
    'ratingNum': '4.7',
    'stars': '⭐⭐⭐⭐⭐',
    'ratingCount': '(1,900)',
    'price': '₱6,500',
    'originalPrice': '₱9,500',
    'isBestseller': 'false',
    'emoji': '📍',
    'subtitle':
        'Publishes venue/schedules at One Burgundy Plaza (Katipunan Ave) and regional batch pages.',
    'description':
        'Review Masters publishes schedule pages showing One Burgundy Plaza, Katipunan Ave as a venue, and regional pages (e.g., Naga batch) listing QC contact location and contact details.',
    'managedBy': 'Review Masters',
    'modalities': 'On-site · Online · Hybrid',
    'location':
        'One Burgundy Plaza, Katipunan Ave., Loyola Heights, Quezon City',
    'website':
        'https://www.upcatreview.com/upcat-review-centers-and-schedules-2/',
    'phone': '0917 117 0765',
    'email': 'reviewmasters@upcatreview.com',
    'exams': 'UPCAT, CET (General)',
    'whatYouWillCover': [
      'UPCAT/CET-style problem sets across Reading/Language, Math, Science, Reasoning',
      'Timed practice routines to build consistency and test stamina',
      'Mock exams and post-mock review sessions',
      'Personalized improvement plan using your mock performance trends',
    ],
    'programOverview': {
      'modules': 4,
      'sessions': 44,
      'hours': 88,
      'schedule': 'Weekend batches + regional schedules (batch-based)',
      'delivery': 'Hybrid',
    },
    'centerOffers': [
      'Live classes and batch-based review sessions',
      'Practice sets + handouts',
      'Mock exams with topic breakdown',
      'Optional coaching upon request',
      'Progress tracking and diagnostics',
      'Certificate of completion',
    ],
    'whoThisIsFor': [
      'SHS students preparing for UPCAT and other CETs',
      'Students who learn best with a fixed schedule and repeated mock tests',
      'Students needing structured pacing and accountability',
    ],
    'aboutThisCenter': {
      'short':
          'Batch-based review built around repeated mocks, timed drills, and strategy refinement.',
      'long':
          'The program style emphasizes doing many practice tests and learning from mistakes quickly. Students typically track scores over time and focus on the topics that produce the biggest gains. The goal is exam readiness: speed, accuracy, and calm decision-making under time pressure.',
    },
  },
  {
    'title': 'MSA Institute — CETP (UPCAT/ACET/DCAT/USTET) + Refreshers',
    'instructor': 'MSA Academic Advancement Institute · CETP listings',
    'ratingNum': '4.5',
    'stars': '⭐⭐⭐⭐⭐',
    'ratingCount': '(1,200)',
    'price': '₱15,000',
    'originalPrice': '₱18,000',
    'isBestseller': 'true',
    'emoji': '🧪',
    'subtitle':
        'Official product listings show CETP comprehensive review and refresher/simulated exam options with prices that vary by variant.',
    'description':
        'MSA publishes product listings for College Entrance Test review (CETP) and related variants with price ranges visible on their official store category.',
    'managedBy': 'MSA Academic Advancement Institute',
    'modalities': 'On-site · Hybrid',
    'location': '',
    'website':
        'https://msainstitute.com/index.php/product-category/programs/acadreview/cetp/',
    'phone': '',
    'email': '',
    'exams': 'UPCAT, ACET, DCAT, USTET, CET (General)',
    'whatYouWillCover': [
      'CET coverage: English/Reading, Math, Science, Abstract/Logical Reasoning',
      'High-yield drills for common CET question types',
      'Mock exams + refreshers to reinforce timing and retention',
      'Math/Science strengthening suitable for scholarship-type assessments',
    ],
    'programOverview': {
      'modules': 6,
      'sessions': 72,
      'hours': 144,
      'schedule': 'Weekday & weekend options (variant-dependent)',
      'delivery': 'Hybrid',
    },
    'centerOffers': [
      'Structured review sessions (variant-dependent)',
      'Printed/digital materials depending on package',
      'Mock/simulated exams (variant-dependent)',
      'Refresher modules for weak areas',
      'Progress tracking and practice schedules',
      'Certificate of completion (where included)',
    ],
    'whoThisIsFor': [
      'SHS students preparing for top university CETs',
      'Students who want a longer program with refreshers and repetition',
      'Students who need extra strengthening in Math/Science fundamentals',
    ],
    'aboutThisCenter': {
      'short':
          'A structured, variant-based CET program that can include refreshers and simulated exams.',
      'long':
          'Many students benefit from longer timelines and repeated exposure to key topics. Programs often focus on building strong fundamentals first, then improving timing and accuracy through drills and simulated exams. Refreshers are useful close to exam dates to keep skills sharp.',
    },
  },
]);

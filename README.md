<div align="center">

<img src="assets/hakbang_main_logo.png" alt="Hakbang Logo" width="120"/>

# Hakbang

**Your All-in-One College Journey Companion**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey?style=flat-square)](https://flutter.dev)
[![Version](https://img.shields.io/badge/Version-1.0.0-C8FF4D?style=flat-square)](#)
[![License](https://img.shields.io/badge/License-Private-red?style=flat-square)](#)

*Empowering Filipino students to navigate the path to higher education — one step at a time.*

</div>

---

## Table of Contents

1. [Pitch Deck](#pitch-deck)
2. [Background & Significance](#background--significance)
3. [What is Hakbang?](#what-is-hakbang)
4. [Target Users](#target-users)
5. [Core Features](#core-features)
6. [App Flow & Architecture](#app-flow--architecture)
7. [Tech Stack](#tech-stack)
8. [Dependencies](#dependencies)
9. [State Management](#state-management)
10. [Data Models](#data-models)
11. [Backend & API](#backend--api)
12. [Project Structure](#project-structure)
13. [Design System](#design-system)
14. [Getting Started](#getting-started)
15. [Environment Setup](#environment-setup)
16. [Roadmap](#roadmap)

---

## Pitch Deck

[View Hakbang Pitch Deck (PDF)](assets/ppt/HAKBANG_PitchDeck.pdf)

---

## Background & Significance

<div align="center">
    <img src="assets/ppt/HAKBANG-1.png" alt="Hakbang background and significance" width="900"/>
</div>

The transition from senior high school to college is one of the most consequential decisions a young Filipino will ever make. Yet millions of students face this crossroads with little more than word-of-mouth, outdated printed guides, or scattered information spread across dozens of disconnected websites.

**The problems are real:**

- Students in provincial and rural areas have severely limited access to accurate, up-to-date college information.
- Scholarship opportunities go unclaimed every year simply because students do not know they exist, or cannot navigate the complicated application processes.
- School guidance counselors are severely outnumbered, often managing hundreds of students at once, leaving many without personalized advice.
- Review centers and entrance exam preparation resources are unevenly distributed, disadvantaging students outside Metro Manila.

**Hakbang** (*Filipino for "step"* or *"stride"*) was built to close these gaps. The name reflects the app's core philosophy — every student deserves a clear, guided, and confident step forward into higher education, regardless of geography, socioeconomic background, or access to traditional resources.

By aggregating college discovery, scholarship matching, AI-powered guidance, and review center information into a single mobile platform, Hakbang levels the playing field for Filipino students who would otherwise navigate this journey alone.

---

## What is Hakbang?

<div align="center">
    <img src="assets/ppt/HAKBANG-2.png" alt="What is Hakbang" width="900"/>
</div>

Hakbang is a cross-platform mobile application built with Flutter that serves as a comprehensive college planning assistant. It provides:

- A **searchable, map-enabled directory** of colleges and universities.
- A **curated scholarship database** categorized by government and non-government programs.
- An **AI-powered chat assistant (Gabay)** that answers questions about admissions, entrance exams, scholarships, and career paths.
- A **review center hub** that connects students with test preparation resources filtered by learning modality.
- A **personal profile system** that tracks saved schools, saved scholarships, and user activity.

---

## Target Users

<div align="center">
    <img src="assets/ppt/HAKBANG-3.png" alt="Hakbang target users" width="900"/>
</div>

| Role | Description |
|---|---|
| **Student** | Senior high school or incoming college students exploring their options |
| **Parent** | Parents monitoring scholarship deadlines and school options for their children |
| **Counselor** | Guidance counselors who need a quick reference tool for advising sessions |

---

## Core Features

<div align="center">
    <img src="assets/ppt/HAKBANG-13.png" alt="Hakbang core features" width="900"/>
</div>

### 1. College Discovery
- Browse a complete, live directory of colleges and universities fetched from the Hakbang backend.
- View each college's name, address, type (public/private), contact information, Facebook page, programs offered, ratings, rankings, and about section.
- Interactive map view powered by OpenStreetMap and `flutter_map`, with geolocation-based positioning.
- Save colleges to a personal list for quick future reference.
- Search and filter colleges by name or category.

### 2. Scholarship Hub
- Full database of active scholarships, separated into **Government** and **Non-Government** categories.
- Detailed scholarship profiles including: allowance amount, eligibility criteria, required documents, application steps, application timeline, benefits, service obligations, grant titles, minimum GWA requirements, deadlines, and slots available.
- A **Featured Scholarship** section that highlights top-pick opportunities.
- Tap-to-view scholarship detail pages with a clean, structured layout.
- Save scholarships to a personal list.
- Direct link to the scholarship's official website via `url_launcher`.

### 3. Gabay — AI College Planning Assistant
- Conversational AI chat interface powered by a dedicated AI backend service.
- Personalized greeting that addresses the user by first name.
- Markdown-rendered AI responses for structured, readable answers.
- Pre-built suggestion chips for common questions (entrance exams, scholarships, school recommendations, career paths).
- Full chat history maintained during the session via the `chatMessages` notifier.
- Loading indicators while the AI processes a response.

### 4. Review Center Hub
- Curated list of review centers for college entrance exams.
- Filter by modality: **All**, **On-site**, **Online**, **Hybrid**.
- Search by center name.
- Detailed center profiles: instructor info, ratings, price, exams covered, coverage topics, program overview, who the center is for, offers, and about section.
- Best Seller badges for top-rated centers.

### 5. User Profile & Activity
- Personalized profile with avatar (emoji-based), full name, email, occupation, school, grade level, and a customizable "About Me" bio.
- In-app bio editing with immediate API persistence.
- Saved Schools list with swipe-to-remove.
- Saved Scholarships list with swipe-to-remove.
- Chronological activity log tracking user interactions within the app.

### 6. Authentication & Onboarding
- Animated 5-slide onboarding flow with feature previews.
- 3-step registration wizard: credentials → profile setup → review & confirm.
- JWT-based authentication; token stored securely in a `ValueNotifier` for the session.
- Internet connectivity check before login attempts, with a dedicated offline page (Lottie-animated).

---

## App Flow & Architecture

<div align="center">
    <img src="assets/ppt/HAKBANG-16.png" alt="Hakbang app flow and architecture" width="900"/>
</div>

```
App Launch
│
├── main.dart
│     └── MyApp (MaterialApp)
│           └── MyHomePage (Scaffold)
│                 └── widget_tree.dart
│                       ├── Requests location permission (GPS)
│                       └── Loads StartPage
│
├── StartPage → WelcomeWidget (5-slide onboarding)
│     ├── Slide 1: About App
│     ├── Slide 2: Discover Schools preview
│     ├── Slide 3: Scholarship AI preview
│     ├── Slide 4: Gabay AI preview
│     └── Slide 5: Review Centers preview
│           ├── [Get Started] → SignupPage
│           └── [Sign In]    → LoginPage
│
├── SignupPage (3-step PageController flow)
│     ├── Step 1: Full name, email, password, confirm password
│     ├── Step 2: Avatar, occupation, school name, grade level
│     └── Step 3: Summary, T&C agreement → Database.createUser() → LoginPage
│
├── LoginPage
│     ├── Internet check → NoInternetPage (if offline)
│     ├── Database.userLogin() → JWT token stored in notifier
│     ├── Database.getUserData() → userCredentials notifier populated
│     ├── Initialization.mainInitialization()
│     │     ├── GPS position fetched → userPosition notifier
│     │     ├── Activity log fetched → activityList notifier
│     │     ├── Saved schools fetched → savedSchools notifier
│     │     ├── Saved scholarships fetched → savedScholarships notifier
│     │     ├── Activities sorted by date
│     │     └── Gabay chat initialized with personalized greeting
│     └── MainPage
│
└── MainPage (IndexedStack + bottom nav — 5 tabs)
      ├── Tab 0 — Discover   : College directory + map
      ├── Tab 1 — Scholars   : Scholarship hub
      ├── Tab 2 — Home       : Dashboard (default tab after login)
      ├── Tab 3 — Gabay      : AI chat assistant
      └── Tab 4 — Hubs       : Review center directory
```

---

## Tech Stack

<div align="center">
    <img src="assets/ppt/HAKBANG-17.png" alt="Hakbang tech stack" width="900"/>
</div>

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.11 |
| **State Management** | `ValueNotifier` + `ValueListenableBuilder` (zero external state library) |
| **Networking** | `http` package (REST API communication) |
| **Authentication** | JWT Bearer Token (stored in-memory via `ValueNotifier`) |
| **Maps** | OpenStreetMap via `flutter_map` + `flutter_osm_plugin` |
| **Geolocation** | `geolocator` |
| **Map Tile Caching** | `flutter_map_tile_caching` |
| **Connectivity** | `connectivity_plus` |
| **Fonts** | `google_fonts` |
| **Icons** | `font_awesome_flutter` + Material Icons |
| **Animations** | `lottie` (offline page), `smooth_page_indicator` |
| **Markdown** | `flutter_markdown_plus` (AI chat responses) |
| **URL Handling** | `url_launcher` |
| **Date Formatting** | `intl` |
| **Sharing** | `share_link` |
| **Environment Variables** | `flutter_dotenv` |
| **Scroll Effects** | `faded_scrollable`, `fading_edge_scrollview` |
| **Navigation Bar** | `circle_nav_bar` |
| **Progress Indicators** | `linear_progress_bar` |
| **UI Utilities** | `dotted_border`, `marquee`, `flutter_svg` |
| **App Icons** | `flutter_launcher_icons` |
| **Backend Runtime** | Node.js (hosted on Render) |
| **AI Service** | Separate AI backend (Render) |

---

## Dependencies

<div align="center">
    <img src="assets/ppt/HAKBANG-18.png" alt="Hakbang dependencies" width="900"/>
</div>

### Runtime Dependencies

```yaml
# UI & Design
google_fonts: ^8.0.2
flutter_svg: ^2.2.4
lottie: ^3.3.2
smooth_page_indicator: ^2.0.1
circle_nav_bar: ^2.2.0
font_awesome_flutter: ^11.0.0
linear_progress_bar: ^3.0.0
dotted_border: ^3.1.0
marquee: ^2.3.0
faded_scrollable: ^1.0.1
fading_edge_scrollview: ^4.1.1
flutter_markdown_plus: ^1.0.7

# Networking & APIs
http: ^1.6.0
flutter_dotenv: ^6.0.0

# Maps & Geolocation
flutter_map: ^8.2.2
latlong2: ^0.9.1
flutter_map_tile_caching: ^10.1.1
flutter_osm_plugin: ^1.4.3
geolocator: ^14.0.2

# Connectivity
connectivity_plus: ^7.1.1

# Utilities
url_launcher: ^6.3.2
intl: ^0.20.2
share_link: ^0.3.0
```

### Dev Dependencies

```yaml
flutter_lints: ^6.0.0
flutter_launcher_icons: ^0.14.4
```

---

## State Management

<div align="center">
    <img src="assets/ppt/HAKBANG-19.png" alt="Hakbang state management" width="900"/>
</div>

Hakbang uses a lightweight, dependency-free state management approach built entirely on Flutter's built-in `ValueNotifier` and `ValueListenableBuilder`. All shared application state lives in a single file: `lib/notifiers.dart`.

This approach was deliberately chosen to keep the app lean, avoid dependency lock-in, and ensure that any Flutter developer can read and contribute to state logic without learning an external library.

### Global Notifiers

| Notifier | Type | Purpose |
|---|---|---|
| `userCredentials` | `ValueNotifier<User?>` | Logged-in user's profile data |
| `token` | `ValueNotifier<String?>` | JWT bearer token for authenticated API calls |
| `navigationBarIndex` | `ValueNotifier<int>` | Active bottom navigation tab (default: 2 — Home) |
| `welcomePageIndex` | `ValueNotifier<int>` | Current slide in the onboarding PageView |
| `availableColleges` | `ValueNotifier<List<College>>` | Full college list from API |
| `collegeSection` | `ValueNotifier<List<College>>` | Filtered/displayed college list |
| `availableScholarships` | `ValueNotifier<List<ScholarshipObject>>` | Full scholarship list from API |
| `governmentSection` | `ValueNotifier<List<ScholarshipObject>>` | Government scholarships subset |
| `nonGovernmentSection` | `ValueNotifier<List<ScholarshipObject>>` | Non-government scholarships subset |
| `featuredScholarship` | `ValueNotifier<ScholarshipObject?>` | The top-pick scholarship displayed prominently |
| `availableReviewCenters` | `ValueNotifier<List<ReviewCenter>>` | Full review center list from API |
| `reviewCenterSection` | `ValueNotifier<List<ReviewCenter>>` | Filtered review centers |
| `savedSchools` | `ValueNotifier<List<College>>` | User's personally saved colleges |
| `savedScholarships` | `ValueNotifier<List<ScholarshipObject>>` | User's personally saved scholarships |
| `chatMessages` | `ValueNotifier<List<AiMessage>>` | Gabay AI chat message history |
| `chatLoading` | `ValueNotifier<bool>` | Whether Gabay is waiting for an AI response |
| `activityList` | `ValueNotifier<List<Activity>>` | User activity log, sorted by date |
| `userPosition` | `ValueNotifier<Position?>` | User's current GPS coordinates |
| `selectedSchoolPosition` | `ValueNotifier<LatLng?>` | Map-selected college coordinates |
| `locationEnabled` | `ValueNotifier<bool?>` | Whether device location services are enabled |
| `hasInternetConnection` | `ValueNotifier<bool>` | Current internet connectivity status |
| `agreeToTerms` | `ValueNotifier<bool>` | Terms & conditions checkbox state (signup) |
| `selectedFilter` | `ValueNotifier<List<bool>>` | Active scholarship filter tab |
| `selectedHubFilter` | `ValueNotifier<List<bool>>` | Active review center modality filter |
| `governmentSelected` | `ValueNotifier<bool>` | Which scholarship category tab is active |
| `onSelect` | `ValueNotifier<String>` | Currently selected item identifier |

---

## Data Models

<div align="center">
    <img src="assets/ppt/HAKBANG-20.png" alt="Hakbang data models" width="900"/>
</div>

All models are plain Dart classes located in `lib/models/`.

### `User`
```
name, email, avatar (emoji), grade, institution, occupation, role, aboutMe
```

### `College`
```
id, collegeName, address, email, fbPage, telephone, type,
latitude, longitude, logoLink, collegeImage,
programs (List), tags (List),
rating, programNumbers, about, ranking
```

### `ScholarshipObject`
```
id, scholarshipName, about, allowance, color, scholarshipIcon,
government (bool), topPick, minGwa, deadline, limit, duration,
grantTitle, organizationName, website,
benefits (List), eligibility (List), applicationSteps (List),
applicationTimeline (List), requiredDocuments (List),
serviceObligation (Map), tags (List)
```

### `ReviewCenter`
```
title, subtitle, description, instructor, managedBy,
modalities, location, website, phone, email, exams,
ratingNum, stars, ratingCount, price, originalPrice,
isBestSeller (bool), emoji,
coverage (List), centerOffers (List), whoThisIsFor (List),
programOverview (Map), aboutThisCenter (Map)
```

### `AiMessage`
```
text, role ("user" | "model"), chatTime
```

### `Activity`
```
description, iconName, date
```

---

## Backend & API

<div align="center">
    <img src="assets/ppt/HAKBANG-21.png" alt="Hakbang backend and API" width="900"/>
</div>

Hakbang communicates with two separate hosted backend services, both deployed on **Render**.

### Main API Server
**Base URL:** `https://project-hakbang-server-vif8.onrender.com`

| Method | HTTP | Endpoint | Description |
|---|---|---|---|
| `userLogin` | `POST` | `/user/login` | Authenticates credentials, returns JWT |
| `createUser` | `POST` | `/user/register` | Creates a new user account |
| `getUserData` | `GET` | `/user/...` | Fetches full user profile |
| `getCollege` | `GET` | `/college/auth/available-colleges` | Returns full college directory |
| `getScholarships` | `GET` | `/scholarship/auth/active-scholarships` | Returns all active scholarships |
| `getHubs` | `GET` | *(hub endpoint)* | Returns review center list |
| `getUserActivities` | `GET` | *(activity endpoint)* | Fetches user activity log |
| `getSavedSchools` | `GET` | *(saved endpoint)* | Fetches user's saved colleges |
| `getSavedScholarships` | `GET` | *(saved endpoint)* | Fetches user's saved scholarships |
| `updateUserAboutMe` | `PATCH` | *(user endpoint)* | Updates user bio |

All authenticated endpoints require:
```
Authorization: Bearer <token>
```

### AI Chat Service
**Base URL:** `https://project-hakbang-server.onrender.com`

| Method | HTTP | Endpoint | Description |
|---|---|---|---|
| `sendUsermessage` | `POST` | `/chat/auth/message` | Sends a user message and receives an AI response |

The AI chat service is handled by `lib/server/services/ai_chat.dart` and returns plain text responses that are rendered as Markdown in the UI via `flutter_markdown_plus`.

### Network Layer
All HTTP logic is centralized in `lib/server/database/database.dart`. There is no HTTP interceptor abstraction — each method handles its own request, response parsing, and error signaling to keep API calls explicit and traceable.

Internet availability is checked before every login attempt using `lib/functions/internet.dart`, which uses `connectivity_plus` to detect Wi-Fi or mobile data.

---

## Project Structure

<div align="center">
    <img src="assets/ppt/HAKBANG-22.png" alt="Hakbang project structure" width="900"/>
</div>

```
lib/
├── main.dart                        # App entry point — MaterialApp root
├── widget_tree.dart                 # Location init gate — loads StartPage
├── notifiers.dart                   # All global ValueNotifier state
│
├── pages/                           # Full-screen route destinations
│   ├── start_page.dart              # Shell for WelcomeWidget
│   ├── login_page.dart              # Email/password login
│   ├── signup_page.dart             # 3-step registration flow
│   ├── main_page.dart               # Root shell with bottom nav (IndexedStack)
│   ├── profile_page.dart            # User profile, saved items, logout
│   ├── college_description.dart     # College detail page
│   ├── scholarship_description.dart # Scholarship detail page
│   ├── review_center_description.dart # Review center detail page
│   ├── view_all_scholarships.dart   # Full scholarship listing page
│   └── no_internet_page.dart        # Offline fallback with Lottie animation
│
├── widgets/                         # Reusable and tab-level UI components
│   ├── welcome_widget.dart          # 5-slide onboarding PageView
│   ├── home_widget.dart             # Home dashboard tab
│   ├── discovery.dart               # College discovery tab
│   ├── scholarship.dart             # Scholarships tab
│   ├── ai_gabay.dart                # Gabay AI chat tab
│   ├── review_center.dart           # Review center hubs tab
│   ├── signup_step1.dart            # Signup: credentials step
│   ├── signup_step2.dart            # Signup: profile setup step
│   └── signup_step3.dart            # Signup: review & confirm step
│
├── functions/                       # Business logic helpers
│   ├── initialization.dart          # Post-login data fetch & session clear
│   ├── locations.dart               # GPS permission & position retrieval
│   ├── internet.dart                # Connectivity detection
│   ├── filter.dart                  # List filtering logic (colleges, hubs)
│   ├── sorting_functions.dart       # Activity and list sort helpers
│   ├── scholarship_save.dart        # Save/unsave scholarship logic
│   ├── school_save.dart             # Save/unsave college logic
│   ├── verifications.dart           # Input validation helpers
│   ├── launcher.dart                # url_launcher wrapper
│   └── activity_functions.dart     # Activity log write helpers
│
├── server/
│   ├── database/
│   │   └── database.dart            # All REST API calls (central HTTP layer)
│   └── services/
│       └── ai_chat.dart             # Gabay AI message API call
│
├── models/                          # Dart data classes (no ORM, plain Dart)
│   ├── user.dart
│   ├── college.dart
│   ├── scholarship_object.dart
│   ├── review_center.dart
│   ├── activity.dart
│   ├── ai_message.dart
│   └── occupation_option.dart
│
└── design/                          # App-wide design system constants
    ├── app_colors.dart              # Full color palette (dark theme)
    ├── font_styles.dart             # Typography scale
    ├── button_design.dart           # Shared button styles
    ├── container_design.dart        # Card and container decorations
    ├── input_design.dart            # TextField input decorations
    ├── background_design.dart       # Page background colors
    ├── padding_design.dart          # Spacing constants
    ├── heights_values.dart          # Vertical spacing constants
    ├── width_values.dart            # Horizontal spacing constants
    └── smooth_page_indicator_design.dart  # Dot indicator configuration

assets/
├── hakbang_main_logo.png            # App icon source
├── hakbang_logo.png                 # In-app logo variant
├── noInternet.json                  # Lottie animation for offline page
├── graduation-hat.svg
├── university.svg
├── scholarship.png
├── school.png
├── map.svg
├── robot.svg
├── house.svg
├── exam.svg
└── user.svg
```

---

## Design System

<div align="center">
    <img src="assets/ppt/HAKBANG-23.png" alt="Hakbang design system" width="900"/>
</div>

Hakbang uses a fully custom, centralized design system with a dark theme. All design tokens are defined in `lib/design/` and shared across the entire app — no inline colors or font sizes in widget files.

### Color Palette

The app uses a rich dark theme with a signature **lime accent (`#C8FF4D`)** as the primary brand color.

| Token | Hex | Usage |
|---|---|---|
| `AppColors.bg` | `#0C0D10` | Page backgrounds |
| `AppColors.bodyBg` | `#07080C` | Body/root background |
| `AppColors.surface` | `#13141A` | Cards, bottom nav |
| `AppColors.surface2` | `#1C1E27` | List items, text inputs |
| `AppColors.surface3` | `#23263A` | Inactive states, avatar backgrounds |
| `AppColors.accent` | `#C8FF4D` | Primary brand — buttons, active states |
| `AppColors.onAccent` | `#0C0D10` | Dark text placed on accent color |
| `AppColors.accentLight` | `#D9FE84` | Stat highlights, secondary accents |
| `AppColors.blue` | `#4D8FFF` | Info states, links |
| `AppColors.purple` | `#A855F7` | Scholarship-related UI |
| `AppColors.coral` | `#FF6B4D` | Urgency indicators, deadlines |
| `AppColors.teal` | `#4DFFB8` | Progress, success states |
| `AppColors.border` | `rgba(255,255,255,0.07)` | Subtle dividers |

---

## Getting Started

<div align="center">
    <img src="assets/ppt/HAKBANG-24.png" alt="Hakbang getting started" width="900"/>
</div>

### Prerequisites

- Flutter SDK `^3.x` (with Dart `^3.11.1`)
- Xcode (for iOS builds)
- Android Studio / Android SDK (for Android builds)
- A `.env` file with the required API keys (see [Environment Setup](#environment-setup))

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-org/project_hakbang.git
cd project_hakbang

# 2. Install dependencies
flutter pub get

# 3. Add your .env file (see Environment Setup below)

# 4. Run on a connected device or simulator
flutter run
```

### iOS Setup

```bash
cd ios
pod install
cd ..
flutter run
```

### Android Setup

No additional native setup is required beyond the standard Flutter Android configuration.

---

## Environment Setup

<div align="center">
    <img src="assets/ppt/HAKBANG-25.png" alt="Hakbang environment setup" width="900"/>
</div>

Hakbang uses `flutter_dotenv` to manage environment variables. Create a `.env` file in the project root:

```env
# Example .env structure
# Add any required API keys or base URL overrides here
BASE_URL=https://project-hakbang-server-vif8.onrender.com
AI_BASE_URL=https://project-hakbang-server.onrender.com
```

> **Important:** Never commit the `.env` file to version control. Ensure it is listed in `.gitignore`.

The `.env` file is loaded in `main.dart` via:

```dart
await dotenv.load(fileName: ".env");
```

---

## Roadmap

<div align="center">
    <img src="assets/ppt/HAKBANG-26.png" alt="Hakbang roadmap" width="900"/>
</div>

| Feature | Status |
|---|---|
| College discovery with map | ✅ Live |
| Scholarship hub | ✅ Live |
| Gabay AI chat | ✅ Live |
| Review center hub | ✅ Live |
| User profiles & saved items | ✅ Live |
| 3-step onboarding + auth | ✅ Live |
| Activity log | ✅ Live |
| Offline detection & fallback | ✅ Live |
| Push notifications | 🔜 Planned |
| Entrance exam mock tests | 🔜 Planned |
| Scholarship deadline reminders | 🔜 Planned |
| Community forums | 🔜 Planned |
| College comparison tool | 🔜 Planned |
| Multi-language support (Filipino / English) | 🔜 Planned |

---

## Contributing

<div align="center">
    <img src="assets/ppt/HAKBANG-27.png" alt="Hakbang contributing" width="900"/>
</div>

This is a private project. Contributions are by invitation only. Please contact the maintainers before submitting pull requests.

---

## License

Private and proprietary. All rights reserved. Unauthorized use, reproduction, or distribution of any part of this codebase is strictly prohibited.

---

<div align="center">

Built with ❤️ for Filipino students.

*Hakbang — Every step toward your future starts here.*

</div>

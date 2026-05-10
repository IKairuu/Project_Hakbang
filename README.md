# Project Hakbang — App Walkthrough

A Flutter app that helps students discover colleges, find scholarships, and get AI-powered guidance for their college journey.

---

## App Flow (Start to Finish)

### 1. Entry Point — `lib/main.dart`

The app starts here. It runs `MyApp`, which wraps everything in a `MaterialApp` and sets `MyHomePage` as the root. `MyHomePage` is just a `Scaffold` that loads `WidgetTree` as its body.

---

### 2. Initialization — `lib/widget_tree.dart`

`WidgetTree` is the first real logic gate. On `initState`, it calls `Locations.initializeLocationServices()` from `lib/functions/locations.dart`. This checks if the device has location enabled and requests permission if needed.

After that, it renders `StartPage`.

---

### 3. Welcome Screen — `lib/pages/start_page.dart` → `lib/widgets/welcome_widget.dart`

`StartPage` is thin — it just returns `WelcomeWidget`.

`WelcomeWidget` is the onboarding screen. It shows a **5-slide PageView**:

| Slide | Widget | What it shows |
|---|---|---|
| 1 | `AboutApp` | What Hakbang is |
| 2 | `ExploreContainer` | Discover schools feature preview |
| 3 | `ScholarshipAi` | Scholarships feature preview |
| 4 | `GabayAiSlide` | AI Gabay feature preview |
| 5 | `ReviewCenterSlide` | Review hubs feature preview |

Below the slides are:
- **Dot indicator** — tap to jump to a slide
- **"Get Started →"** button — goes to `SignupPage`
- **"Sign In"** link — initializes location then goes to `LoginPage`

---

### 4. Sign Up — `lib/pages/signup_page.dart`

A 3-step flow controlled by a `PageController`. A progress indicator at the top (`SignupProgressIndicator`) shows which step the user is on.

**Step 1** (`lib/widgets/signup_step1.dart`) — Credentials
- Full name, email, password, confirm password

**Step 2** (`lib/widgets/signup_step2.dart`) — Profile setup
- Pick an avatar emoji (🦁 🦊 🐉 🦅 🐬)
- Pick occupation: Student, Parent, or Counselor
- Enter school name and grade level

**Step 3** (`lib/widgets/signup_step3.dart`) — Review & confirm
- Shows a summary of entered data
- Option to agree to terms
- **"Create Account"** → calls `Database.createUser()` → shows success dialog → redirects to `LoginPage`

---

### 5. Login — `lib/pages/login_page.dart`

The user enters email and password. On submit:

1. Checks internet via `Internet.checkInternetConnection()` — if offline, goes to `NoInternetPage` with a retry wrapper.
2. Calls `Database.userLogin(email, password)` → hits the REST API.
3. On success (`status 200`):
   - Stores the JWT token in the `token` notifier (`"Bearer <token>"`)
   - Fetches full user data via `Database.getUserData()` and stores it in the `userCredentials` notifier
   - Sets the default nav tab to Home (index 2)
   - Calls `Initialization.mainInitialization()` (see below)
   - Navigates to `MainPage`

---

### 6. Main Initialization — `lib/functions/initialization.dart`

Runs once right after login:

```
mainInitialization()
  ├── Gets user's GPS position → userPosition notifier
  ├── Fetches user activity log → activityList notifier
  ├── Fetches saved schools → savedSchools notifier
  ├── Fetches saved scholarships → savedScholarships notifier
  ├── Sorts activities by date
  └── Initializes Gabay chat with a greeting message
```

---

### 7. Main App — `lib/pages/main_page.dart`

A bottom navigation bar with 5 tabs. The active tab is tracked by the `navigationBarIndex` `ValueNotifier` in `lib/notifiers.dart`. Uses `IndexedStack` so switching tabs doesn't reload widgets.

---

#### Tab 0 — Discover (`lib/widgets/discovery.dart`)

- Fetches colleges from API on load (`Database.getCollege()`)
- Shows a searchable list of colleges with a map view using `flutter_map`
- Tapping a college opens `CollegeDescription` page (detailed view)
- Users can save schools

#### Tab 1 — Scholars (`lib/widgets/scholarship.dart`)

- Fetches scholarships from API on load (`Database.getScholarships()`)
- Shows featured scholarship + filtered tabs (Government / Non-Government)
- Search bar filters the list
- Tapping a scholarship opens `ScholarshipDescription` page
- Users can save scholarships
- "View All" opens `ViewAllScholarships` page

#### Tab 2 — Home (`lib/widgets/home_widget.dart`) ← *default tab after login*

- Greets the user by first name and shows their avatar
- Quick-access cards for navigating the app
- Tapping the avatar opens `ProfilePage`

#### Tab 3 — Gabay (`lib/widgets/ai_gabay.dart`)

- AI chat interface
- Messages are stored in `chatMessages` notifier (list of `AiMessage` objects)
- User types a message → calls `AiChat.sendUsermessage()` → hits the AI endpoint on the backend → response rendered as Markdown
- Suggestion chips pre-fill common questions

#### Tab 4 — Hubs (`lib/widgets/review_center.dart`)

- Fetches review centers from API on load (`Database.getHubs()`)
- Filterable by mode: All, On-site, Online, Hybrid
- Search bar filters by name
- Tapping a hub opens `ReviewCenterDescription` page

---

### 8. Profile — `lib/pages/profile_page.dart`

Accessible by tapping the avatar on the Home tab.

- Shows user info: name, email, occupation, school, grade, avatar, about me
- **Edit About Me** — opens a dialog to update the bio, calls `Database.updateUserAboutMe()`
- **Saved Schools** — list of saved colleges with swipe-to-unsave
- **Saved Scholarships** — list of saved scholarships with swipe-to-unsave
- **Logout** — calls `Initialization.clearSessionState()` which resets all notifiers, then navigates back to `LoginPage`

---

## State Management — `lib/notifiers.dart`

All shared state lives here as `ValueNotifier` globals. No external state library is used — widgets listen via `ValueListenableBuilder`.

Key notifiers:

| Notifier | Type | Purpose |
|---|---|---|
| `userCredentials` | `User?` | Logged-in user data |
| `token` | `String?` | JWT bearer token for API calls |
| `navigationBarIndex` | `int` | Which tab is active |
| `availableColleges` | `List<College>` | Colleges from API |
| `availableScholarships` | `List<ScholarshipObject>` | Scholarships from API |
| `availableReviewCenters` | `List<ReviewCenter>` | Hubs from API |
| `savedSchools` | `List<College>` | User's saved schools |
| `savedScholarships` | `List<ScholarshipObject>` | User's saved scholarships |
| `chatMessages` | `List<AiMessage>` | Gabay chat history |
| `userPosition` | `Position?` | User's GPS coordinates |
| `activityList` | `List<Activity>` | User's recent activity |

---

## Backend — `lib/server/`

All HTTP calls go through `lib/server/database/database.dart`.

- **Base URL:** `project-hakbang-server-vif8.onrender.com`
- **Auth:** Bearer token sent in every authenticated request header
- **AI chat URL:** `project-hakbang-server.onrender.com` (separate service)

Key methods:

| Method | Endpoint | What it does |
|---|---|---|
| `userLogin` | `POST /user/login` | Authenticates user, returns token |
| `createUser` | `POST /user/register` | Creates a new account |
| `getUserData` | `GET /user/...` | Fetches user profile |
| `getCollege` | `GET /college/auth/available-colleges` | Loads all colleges |
| `getScholarships` | `GET /scholarship/auth/active-scholarships` | Loads all scholarships |
| `getHubs` | — | Loads review centers |
| `getUserActivities` | — | Fetches activity log |
| `getSavedSchools` | — | Fetches user's saved schools |
| `getSavedScholarships` | — | Fetches user's saved scholarships |
| `updateUserAboutMe` | — | Updates bio |

AI messages go through `lib/server/services/ai_chat.dart` → `POST /chat/auth/message`.

---

## Folder Structure

```
lib/
├── main.dart              # App entry, MaterialApp setup
├── widget_tree.dart       # Location init, loads StartPage
├── notifiers.dart         # All ValueNotifier globals (shared state)
├── pages/                 # Full screens
│   ├── start_page.dart
│   ├── login_page.dart
│   ├── signup_page.dart
│   ├── main_page.dart
│   ├── profile_page.dart
│   ├── college_description.dart
│   ├── scholarship_description.dart
│   ├── review_center_description.dart
│   ├── view_all_scholarships.dart
│   └── no_internet_page.dart
├── widgets/               # Reusable UI pieces & tab content
│   ├── welcome_widget.dart
│   ├── home_widget.dart
│   ├── discovery.dart
│   ├── scholarship.dart
│   ├── ai_gabay.dart
│   ├── review_center.dart
│   ├── signup_step1/2/3.dart
│   └── ...
├── functions/             # Logic helpers
│   ├── locations.dart     # GPS permission & position
│   ├── internet.dart      # Connectivity check
│   ├── initialization.dart# Post-login data fetch
│   ├── filter.dart        # List filtering logic
│   ├── sorting_functions.dart
│   ├── scholarship_save.dart
│   ├── school_save.dart
│   ├── verifications.dart
│   └── activity_functions.dart
├── server/
│   ├── database/database.dart   # All REST API calls
│   └── services/ai_chat.dart   # AI chat API call
├── models/                # Data classes
│   ├── user.dart
│   ├── college.dart
│   ├── scholarship_object.dart
│   ├── review_center.dart
│   ├── activity.dart
│   ├── ai_message.dart
│   └── occupation_option.dart
└── design/                # Shared styles & themes
    ├── app_colors.dart
    ├── font_styles.dart
    ├── button_design.dart
    ├── container_design.dart
    └── ...
```

---

## Quick Flow Summary

```
App launch
  └── main.dart → widget_tree.dart
        └── Request location permission
              └── start_page.dart → welcome_widget.dart
                    ├── [Get Started] → signup_page.dart (3 steps) → login_page.dart
                    └── [Sign In]    → login_page.dart
                                          └── Authenticate via API
                                                └── Initialization (fetch all data)
                                                      └── main_page.dart
                                                            ├── Tab 0: Discover (colleges + map)
                                                            ├── Tab 1: Scholars (scholarships)
                                                            ├── Tab 2: Home (dashboard) ← default
                                                            ├── Tab 3: Gabay (AI chat)
                                                            └── Tab 4: Hubs (review centers)
```

# CHANGELOGS
Documentation for the application's version changes and fixes.

## [v0.2.0-beta] - 02/06/26

### CHANGES
-  **Frontend-to-Backend Integration** with new secure request requirements
-  **Database Migration** from Firebase NoSQL to PostgreSQL with Prisma ORM via Neon
-  **Code Restructuring** for improved maintainability and scalability
-  **Enhanced Security** with improved authentication and authorization patterns
-  **AI Companion Feature** refactored with dedicated data layer
-  **Strong Typing** enforced across all models with proper null-safety
-  **Centralized Repository Pattern** for simplified API interactions
-  **ID-Based State Management** for reduced memory footprint
-  **Star Rating Display** for review centers with visual components
-  **DateTime Handling** standardized across all features

### What's Changed
* Code Restructure and Integrate Updated API Endpoints by @IKairuu in https://github.com/IKairuu/Project_Hakbang/pull/11
**Full Changelog**: https://github.com/IKairuu/Project_Hakbang/compare/v0.1.0-beta...v.0.2.0


## [v0.1.0-beta] - 24/05/26
First Pre-release of Hakbang application
### ADDED
1. Login and Sign-up with google account authentication
2. OTP code verification through email
3. College, Scholarship and Hub navigation
4. AI guidance and conversation
5. Activity tracker
6. Saving Colleges and Scholarships

### KNOWN ISSUES
1. Limited email verification and edge cases for verification are yet to be tested.
2. AI rate limits and edge cases are yet to be tested
3. Saving Review centers are yet to be developed
4. Long loading time may occur on startup due to server hosting issues.
5. iOS google authentication may not work during registration.



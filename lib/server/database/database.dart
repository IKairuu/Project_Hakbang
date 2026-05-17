import 'package:dio/dio.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/features/user/data/models/college.dart';
import 'package:hakbang/features/user/data/models/review_center.dart';
import 'package:hakbang/features/user/data/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';

class Database {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<void> getCollege() async {
    final headers = {"Authorization": token.value!};

    List<College> colleges = [];
    try {
      final response = await dio.get(
        "$mainUrl/auth/college/available-colleges",
        options: Options(headers: headers),
      );
      Map<String, dynamic> data = response.data;
      for (Map<String, dynamic> college in data["data"]) {
        colleges.add(
          College(
            id: college["ID"],
            address: college["address"],
            collegeName: college["college_name"],
            email: college["email"],
            fbPage: college["fb_page"],
            telephone: college["telephone"],
            type: college["type"],
            latitude: college["latitude"],
            longitude: college["longitude"],
            logoLink: college["logo_link"],
            programs: college["program_offered"],
            tags: college["tags"],
            collegeImage: college["college_image"],
            rating: college["rating"],
            programNumbers: college["program_numbers"],
            about: college["about"],
            ranking: college["ranking"],
          ),
        );
      }
      availableColleges.value = colleges;
      collegeSection.value = availableColleges.value;
      Initialization.refreshCollegeSelection();
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> getScholarships() async {
    final headers = {"Authorization": token.value!};
    try {
      List<ScholarshipObject> scholarships = [];
      final response = await dio.get(
        "$mainUrl/auth/scholarship/active-scholarships",
        options: Options(headers: headers),
      );

      final Map<String, dynamic> data = response.data;
      for (Map<String, dynamic> scholars in data["data"]) {
        scholarships.add(
          ScholarshipObject(
            allowance: scholars["Allowance"],
            id: scholars["ID"],
            about: scholars["about"],
            applicationSteps: scholars["application_steps"],
            applicationTimeline: scholars["application_timeline"],
            benefits: scholars["benefits"],
            deadline: scholars["deadline"],
            duration: scholars["duration"],
            eligibility: scholars["eligibility"],
            government: scholars["government"],
            grantTitle: scholars["grant_title"],
            limit: scholars["limit"],
            minGwa: (scholars["min_gwa"] ?? 0).toDouble(),
            organizationName: scholars["organizationName"],
            requiredDocuments: scholars["required_documents"],
            scholarshipName: scholars["scholarshipName"],
            scholarshipIcon: scholars["scholarship_icon"],
            color: scholars["color"],
            serviceObligation: scholars["serviceObligation"],
            tags: scholars["tags"],
            topPick: scholars["top_pick"],
            website: scholars["website"],
          ),
        );
      }
      availableScholarships.value = scholarships;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> signupUser(
    Map<String, dynamic> userData,
  ) async {
    try {
      final data = userData["data"];
      final response = await dio.post("$mainUrl/user/signup", data: data);
      final message = response.data["message"];
      return message;
    } on DioException catch (error) {
      return error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> userLogin(
    String email,
    String password,
  ) async {
    final userMessage = {"email": email, "password": password};

    try {
      final response = await dio.post("$mainUrl/user/login", data: userMessage);
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> updateUserAboutMe(Map<String, dynamic> data) async {
    final headers = {"Authorization": token.value!};
    final message = data;
    try {
      final response = await dio.put(
        "$mainUrl/user/auth/change-about-me",
        data: message,
        options: Options(headers: headers),
      );
      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> getUserActivities(String email) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-activities/$email",
        options: Options(headers: headers),
      );

      List<Activity> activities = [];
      for (Map<String, dynamic> acts in response.data["data"]) {
        activities.add(
          Activity(
            description: acts["description"],
            iconName: acts["iconName"],
            date: acts["date"],
          ),
        );
      }
      activityList.value = activities;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> getSavedScholarships(String email) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-scholarship/$email",
        options: Options(headers: headers),
      );

      final List<Map<String, dynamic>> scholarList = [];
      final data = response.data;
      for (Map<String, dynamic> dataObjs in data["data"]) {
        scholarList.add(dataObjs);
      }
      rawSavedScholarships.value = scholarList;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<String> saveScholarship(String scholarName) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "scholarship_name": scholarName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/post-saved-scholarship",
        data: data,
        options: Options(headers: headers),
      );

      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<String> removeSavedScholarship(String scholarName) async {
    final headers = {"Authorization": token.value!};

    final data = {
      "scholarship_name": scholarName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/remove-saved-scholarship",
        data: data,
        options: Options(headers: headers),
      );

      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> getSavedSchools(String email) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-schools/$email",
        options: Options(headers: headers),
      );
      final List<Map<String, dynamic>> collegeList = [];
      final data = response.data;
      for (Map<String, dynamic> collegeNames in data["data"]) {
        collegeList.add(collegeNames);
      }
      rawSavedSchools.value = collegeList;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<String> saveSchool(String collegeName) async {
    final headers = {"Authorization": token.value!};

    final data = {
      "college_name": collegeName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/post-saved-schools",
        data: data,
        options: Options(headers: headers),
      );

      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<String> removeSavedSchool(String collegeName) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "college_name": collegeName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/remove-saved-school",
        data: data,
        options: Options(headers: headers),
      );

      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> addActivity(Activity activity) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "date": activity.date,
      "description": activity.description,
      "email": userCredentials.value!.email,
      "iconName": activity.iconName,
    };
    try {
      await dio.post(
        "$mainUrl/user/auth/post-activity",
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> removeActivities() async {
    final headers = {"Authorization": token.value!};

    try {
      final response = await dio.delete(
        "$mainUrl/user/auth/remove-activities/${userCredentials.value!.email}",
        options: Options(headers: headers),
      );

      return response.data["message"];
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> getHubs() async {
    final headers = {"Authorization": token.value!};

    try {
      final response = await dio.get(
        "$mainUrl/auth/review-hub/get-review-centers",
        options: Options(headers: headers),
      );
      List<ReviewCenter> hubList = [];
      for (dynamic data in response.data["data"]) {
        hubList.add(
          ReviewCenter(
            title: data["title"],
            instructor: data["instructor"],
            ratingNum: data["rating_num"],
            stars: data["stars"],
            ratingCount: data["rating_count"],
            price: data["price"],
            originalPrice: data["original_price"],
            isBestSeller: data["is_best_seller"],
            emoji: data["emoji"],
            coverage: data["coverage"],
            programOverview: data["program_overview"],
            centerOffers: data["center_offers"],
            whoThisIsFor: data["who_this_is_for"],
            aboutThisCenter: data["about_center"],
            description: data["description"],
            email: data["email"],
            exams: data["exams"],
            location: data["location"],
            managedBy: data["managed_by"],
            modalities: data["modalities"],
            phone: data["phone"],
            subtitle: data["subtitle"],
            website: data["website"],
          ),
        );
      }
      availableReviewCenters.value = hubList;
      reviewCenterSection.value = availableReviewCenters.value;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

import 'dart:convert';

import 'package:hakbang/models/activity.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:http/http.dart' as http;

class Database {
  static String mainUrl = "project-hakbang-server-vif8.onrender.com";
  static Future<void> getCollege() async {
    final url = Uri.https(mainUrl, "college/auth/available-colleges");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token.value!,
    };

    List<College> colleges = [];
    final response = await http.get(url, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
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
  }

  static Future<void> getScholarships() async {
    final url = Uri.https(mainUrl, "scholarship/auth/active-scholarships");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token.value!,
    };

    List<ScholarshipObject> scholarships = [];
    final response = await http.get(url, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
    for (Map<String, dynamic> scholars in data["data"]) {
      scholarships.add(
        ScholarshipObject(
          title: scholars["title"],
          subtitle: scholars["subtitle"],
          tags: scholars["tags"],
          scholarIcon: scholars["icon"],
          description: scholars["description"],
          details: scholars["details"],
          website: scholars["website"],
          limit: scholars["limit"],
          slots: scholars["slots"],
        ),
      );
    }
    availableScholarships.value = scholarships;
  }

  static Future<void> signupUser(Map<String, dynamic> userData) async {
    final url = Uri.https(mainUrl, "user/signup");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final data = jsonEncode(userData["data"]);
    var response = await http.post(url, headers: headers, body: data);
    final message = jsonDecode(response.body);
    return message["message"];
  }

  static Future<Map<String, dynamic>> userLogin(
    String email,
    String password,
  ) async {
    final url = Uri.https(mainUrl, "user/login");
    final userMessage = jsonEncode({"email": email, "password": password});
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.post(url, headers: headers, body: userMessage);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getUserData(String email) async {
    final url = Uri.https(mainUrl, "user/auth/$email/get-user-data");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };
    final response = await http.get(url, headers: headers);
    return jsonDecode(response.body);
  }

  static Future<void> getUserActivities(String email) async {
    final url = Uri.https(mainUrl, "user/auth/get-activities");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };

    final data = jsonEncode({"email": email});
    final response = await http.post(url, headers: headers, body: data);

    List<Activity> activities = [];
    for (Map<String, dynamic> acts in jsonDecode(response.body)["data"]) {
      activities.add(
        Activity(
          description: acts["description"],
          iconName: acts["iconName"],
          date: acts["date"],
        ),
      );
    }
    activityList.value = activities;
  }

  static Future<void> getSavedSchools(String email) async {
    final url = Uri.https(mainUrl, "user/auth/get-saved-schools");

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"email": email}),
    );
    final List<College> collegeList = List.from(savedSchools.value);
    final data = jsonDecode(response.body);
    if (data["status"] == 200) {
      for (Map<String, dynamic> collegeNames in data["data"]) {
        for (College college in availableColleges.value) {
          if (college.collegeName == collegeNames["college_name"]) {
            collegeList.add(college);
          }
        }
      }
    }
    savedSchools.value = collegeList;
  }

  static Future<void> saveSchool(String collegeName) async {
    final url = Uri.https(mainUrl, "user/auth/post-saved-schools");

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };

    final data = jsonEncode({
      "college_name": collegeName,
      "email": userCredentials.value!.email,
    });

    final response = await http.post(url, headers: headers, body: data);

    return jsonDecode(response.body);
  }

  static Future<void> removeSavedSchool(String collegeName) async {
    final url = Uri.https(mainUrl, "user/auth/remove-saved-school");

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };

    final data = jsonEncode({
      "college_name": collegeName,
      "email": userCredentials.value!.email,
    });

    final response = await http.post(url, headers: headers, body: data);

    return jsonDecode(response.body);
  }

  static Future<void> addActivity(Activity activity) async {
    final url = Uri.https(mainUrl, "user/auth/post-activity");

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };
    final data = jsonEncode({
      "date": activity.date,
      "description": activity.description,
      "email": userCredentials.value!.email,
      "iconName": activity.iconName,
    });

    final response = await http.post(url, headers: headers, body: data);

    return jsonDecode(response.body);
  }

  static Future<void> removeActivities() async {
    final url = Uri.https(mainUrl, "user/auth/remove-activities");

    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": token.value!,
    };

    final data = jsonEncode({"email": userCredentials.value!.email});
    final response = await http.post(url, headers: headers, body: data);

    return jsonDecode(response.body);
  }
}

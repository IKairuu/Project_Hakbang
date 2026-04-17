import 'dart:convert';

import 'package:hakbang/models/college.dart';
import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:http/http.dart' as http;

class Database {
  static Future<void> getCollege() async {
    final url = Uri.https(
      "project-hakbang-server.onrender.com",
      "college/auth/available-colleges",
    );
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
    final url = Uri.https(
      "project-hakbang-server.onrender.com",
      "scholarship/auth/active-scholarships",
    );
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
    final url = Uri.https("project-hakbang-server.onrender.com", "user/signup");
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
    final url = Uri.https("project-hakbang-server.onrender.com", "user/login");
    final userMessage = jsonEncode({"email": email, "password": password});
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final response = await http.post(url, headers: headers, body: userMessage);
    return jsonDecode(response.body);
  }
}

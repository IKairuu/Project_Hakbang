import 'dart:convert';

import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:http/http.dart' as http;

class Database {
  static Future<void> getCollege() async {
    final url = Uri.https(
      "project-hakbang-server.onrender.com",
      "college/available-colleges",
    );

    List<College> colleges = [];
    final response = await http.get(url);
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
        ),
      );
    }
    availableColleges.value = colleges;
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
}

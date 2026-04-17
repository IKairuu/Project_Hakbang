import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginSystem {
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

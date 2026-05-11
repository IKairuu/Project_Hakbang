import 'dart:convert';

import 'package:http/http.dart' as http;

class InitializeServer {
  static Future<Map<String, dynamic>> pingServer() async {
    final mainUrl = "project-hakbang-server.onrender.com";
    try {
      final url = Uri.https(mainUrl, "ping");
      final response = await http.get(url);
      final appResponse = {
        "message": jsonDecode(response.body),
        "connected": true,
      };
      return appResponse;
    } catch (error) {
      print(error);
      return {"connected": false};
    }
  }
}

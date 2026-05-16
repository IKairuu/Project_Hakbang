import 'dart:async';

import 'package:dio/dio.dart';

class InitializeServer {
  static Future<Map<String, dynamic>> pingServer() async {
    final dio = Dio();

    try {
      final response = await dio
          .get("https://project-hakbang-server.onrender.com/ping")
          .timeout(Duration(seconds: 30));
      final appResponse = {
        "message": response.data["message"],
        "connected": true,
      };
      return appResponse;
    } on TimeoutException {
      return {"connected": false};
    }
  }
}

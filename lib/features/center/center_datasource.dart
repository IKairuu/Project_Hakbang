import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class CenterDatasource {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<Map<String, dynamic>> getHubsRouter() async {
    final headers = {"Authorization": token.value!};

    try {
      final response = await dio.get(
        "$mainUrl/auth/review-hub/get-review-centers",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

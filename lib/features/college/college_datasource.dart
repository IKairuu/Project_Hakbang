import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class CollegeDatasource {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<Map<String, dynamic>> getCollegeRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await Dio().get(
        "https://project-hakbang-server.onrender.com/auth/college/available-colleges",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

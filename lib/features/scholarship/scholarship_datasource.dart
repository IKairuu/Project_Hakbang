import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class ScholarshipDatasource {
  static Future<Map<String, dynamic>> getScholarshipsRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await Dio().get(
        "https://project-hakbang-server.onrender.com/auth/scholarship/active-scholarships",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response!.data["message"];
    }
  }
}

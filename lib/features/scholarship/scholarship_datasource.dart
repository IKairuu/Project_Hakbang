import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class ScholarshipDatasource {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<Map<String, dynamic>> getScholarshipsRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/auth/scholarship/active-scholarships",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response!.data["message"];
    }
  }

  static Future<Map<String, dynamic>> getSavedScholarshipsRouter(
    String email,
  ) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-scholarship/$email",
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> saveScholarshipRouter(
    String scholarName,
  ) async {
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
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> removeSavedScholarshipRouter(
    String scholarName,
  ) async {
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

      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

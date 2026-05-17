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

  static Future<Map<String, dynamic>> getSavedSchoolsRouter(
    String email,
  ) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-schools/$email",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> saveSchoolRouter(
    String collegeName,
  ) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "college_name": collegeName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/post-saved-schools",
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> removeSavedSchoolRouter(
    String collegName,
  ) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "college_name": collegName,
      "email": userCredentials.value!.email,
    };
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/remove-saved-school",
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

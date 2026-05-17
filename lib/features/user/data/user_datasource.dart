import 'package:dio/dio.dart';
import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/notifiers.dart';

class UserDatasource {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<Map<String, dynamic>> signupUserRouter(
    Map<String, dynamic> userData,
  ) async {
    try {
      final data = userData["data"];
      final response = await dio.post("$mainUrl/user/signup", data: data);
      return response.data;
    } on DioException catch (error) {
      return error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> userLoginRouter(
    String email,
    String password,
  ) async {
    final userMessage = {"email": email, "password": password};
    try {
      final response = await dio.post("$mainUrl/user/login", data: userMessage);
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> updateUserAboutMeRouter(
    Map<String, dynamic> data,
  ) async {
    final headers = {"Authorization": token.value!};
    final message = data;
    try {
      final response = await dio.put(
        "$mainUrl/user/auth/change-about-me",
        data: message,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> getUserActivitiesRouter(
    String email,
  ) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-activities/$email",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<void> addActivityRouter(Activity activity) async {
    final headers = {"Authorization": token.value!};
    final data = {
      "date": activity.date,
      "description": activity.description,
      "email": userCredentials.value!.email,
      "iconName": activity.iconName,
    };
    try {
      await dio.post(
        "$mainUrl/user/auth/post-activity",
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> removeActivitiesRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.delete(
        "$mainUrl/user/auth/remove-activities/${userCredentials.value!.email}",
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

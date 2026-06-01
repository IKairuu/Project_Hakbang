import 'package:dio/dio.dart';
import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/notifiers.dart';

class UserDatasource {
  static final dio = Dio();
  static String mainUrl = "https://project-hakbang-server.onrender.com";
  static Future<void> signupUserRouter(
    Map<String, dynamic> userData,
    String token,
  ) async {
    final headers = {"Authorization": "Bearer $token"};
    try {
      final data = userData["data"];
      await dio.post(
        "$mainUrl/user/auth/signup",
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> requestCodeRouter(String email) async {
    try {
      final response = await dio.post("$mainUrl/user/auth-user-email/$email");
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> verifyCodeRouter(
    String token,
    String code,
  ) async {
    try {
      final data = {"token": token, "code": code};
      final response = await dio.post("$mainUrl/user/verify", data: data);
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
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
    String editedText,
  ) async {
    final headers = {"Authorization": token.value!};
    final message = {"about_me": editedText};
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

  static Future<Map<String, dynamic>> getUserActivitiesRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-activities",
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
      "description": activity.description,
      "icon_name": activity.iconName,
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
        "$mainUrl/user/auth/remove-activities",
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> getSavedSchoolsRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-schools",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> saveSchoolRouter(String collegeId) async {
    final headers = {"Authorization": token.value!};
    final data = {"college_id": collegeId};
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
    String collegeId,
  ) async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.post(
        "$mainUrl/user/auth/remove-saved-school/$collegeId",
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }

  static Future<Map<String, dynamic>> getSavedScholarshipsRouter() async {
    final headers = {"Authorization": token.value!};
    try {
      final response = await dio.get(
        "$mainUrl/user/auth/get-saved-scholarship",
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

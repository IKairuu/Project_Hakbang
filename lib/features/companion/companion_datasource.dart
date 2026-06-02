import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class CompanionDatasource {
  static Future<Map<String, dynamic>> sendUsermessageRouter(
    dynamic chat,
  ) async {
    final dio = Dio();
    final headers = {"Authorization": token.value!};
    final data = {"message": chat["message"]};

    try {
      final response = await dio.post(
        "https://project-hakbang-server.onrender.com/auth/chat/message",
        data: data,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (error) {
      throw error.response?.data["message"];
    }
  }
}

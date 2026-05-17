import 'package:dio/dio.dart';
import 'package:hakbang/notifiers.dart';

class AiChat {
  static Future<String> sendUsermessage(dynamic chat) async {
    final dio = Dio();
    final headers = {"Authorization": token.value!};
    final data = {
      "message": chat["message"],
      "email": userCredentials.value!.email,
    };

    final response = await dio.post(
      "https://project-hakbang-server.onrender.com/auth/chat/message",
      data: data,
      options: Options(headers: headers),
    );

    return response.data["message"];
  }
}

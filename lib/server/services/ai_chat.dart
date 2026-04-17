import 'dart:convert';
import 'package:hakbang/notifiers.dart';
import 'package:http/http.dart' as http;

class AiChat {
  static Future<dynamic> sendUsermessage(dynamic chat) async {
    final url = Uri.https(
      "project-hakbang-server.onrender.com",
      "chat/auth/message",
    );
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token.value!,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"message": chat["message"]}),
    );

    if (response.statusCode == 200) return jsonDecode(response.body)["message"];

    return {"message": jsonDecode(response.body)["message"]};
  }
}

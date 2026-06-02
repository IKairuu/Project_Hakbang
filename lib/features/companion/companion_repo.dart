import 'package:hakbang/features/companion/companion_datasource.dart';

class CompanionRepo {
  static Future<String> sendUserMessage(String chat) async {
    try {
      var messageData = {"message": chat};
      final aiResponse = await CompanionDatasource.sendUsermessageRouter(
        messageData,
      );
      return aiResponse["message"];
    } catch (error) {
      rethrow;
    }
  }
}

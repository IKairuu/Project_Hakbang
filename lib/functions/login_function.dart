import 'package:hakbang/features/user/data/models/user.dart';
import 'package:hakbang/features/user/data/user_repo.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/notifiers.dart';

class LoginFunction {
  static void userLogin(String email, String password) async {
    var userData = await UserRepo.userLogin(email, password);
    userCredentials.value = User(
      id: userData["message"]["id"],
      name: userData["message"]["name"],
      email: userData["message"]["email"],
      avatar: userData["message"]["avatar"],
      grade: userData["message"]["grade"],
      institution: userData["message"]["institution"],
      occupation: userData["message"]["occupation"],
      role: userData["message"]["role"],
      aboutMe: userData["message"]["about_me"],
    );

    token.value = "Bearer ${userData["token"]}";
    navigationBarIndex.value = 2;
    await Initialization.mainInitialization();
  }
}

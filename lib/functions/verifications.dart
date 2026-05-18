import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hakbang/notifiers.dart';

class Verifications {
  static bool verifyCredentials(List<String> credentials) {
    for (String data in credentials) {
      if (data.trim().isEmpty) return false;
    }
    return true;
  }

  static bool checkPasswordLength(String password) {
    if (password.length < 8) {
      return false;
    }
    return true;
  }

  static bool checkPasswordFormat(String password) {
    bool upper = false, lower = false, numbers = false;
    for (String chars in password.split("")) {
      if (int.tryParse(chars) != null) {
        numbers = true;
      }
      if (chars == chars.toUpperCase() && chars != chars.toLowerCase()) {
        upper = true;
      }
      if (chars == chars.toLowerCase() && chars != chars.toUpperCase()) {
        lower = true;
      }
    }
    return upper && lower && numbers;
  }

  static bool checkPasswordMatch(String password, String confirmPassword) {
    if (password != confirmPassword) return false;
    return true;
  }

  static bool checkTerms() {
    if (!agreeToTerms.value) return false;
    return true;
  }

  static Future<void> authentication() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    final GoogleSignInAccount? user = await googleSignIn.authenticate();

    if (user == null) {
      throw "Account not found";
    }

    final GoogleSignInAuthentication auth = user.authentication;
    final credential = GoogleAuthProvider.credential(idToken: auth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

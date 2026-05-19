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

  static Future<Map<String, dynamic>?> authentication() async {
    try {
      final GoogleSignInAccount user = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication auth = user.authentication;
      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final userData = userCredential.user;
      if (userData == null) {
        return null;
      }
      return {"email": userData.email, "fullname": userData.displayName};
    } on GoogleSignInException catch (error) {
      throw error.toString();
    }
  }
}

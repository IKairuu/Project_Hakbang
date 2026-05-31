import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/features/user/data/user_datasource.dart';
import 'package:hakbang/notifiers.dart';

class UserRepo {
  static Future<void> signupUser(
    Map<String, dynamic> userData,
    String token,
  ) async {
    try {
      await UserDatasource.signupUserRouter(userData, token);
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> requestCode(String email) async {
    try {
      var response = await UserDatasource.requestCodeRouter(email);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> verifyCode(
    String token,
    String code,
  ) async {
    try {
      var response = await UserDatasource.verifyCodeRouter(token, code);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> userLogin(
    String email,
    String password,
  ) async {
    try {
      final response = await UserDatasource.userLoginRouter(email, password);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<String> updateUserAboutMe(String editedText) async {
    try {
      final response = await UserDatasource.updateUserAboutMeRouter(editedText);
      return response["message"];
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> getUserActivities() async {
    try {
      final response = await UserDatasource.getUserActivitiesRouter();
      List<Activity> activities = [];
      for (Map<String, dynamic> acts in response["data"]) {
        activities.add(
          Activity(
            description: acts["description"],
            iconName: acts["iconName"],
            date: acts["date"],
          ),
        );
      }
      activityList.value = activities;
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> addActivity(Activity activity) async {
    try {
      await UserDatasource.addActivityRouter(activity);
    } catch (error) {
      rethrow;
    }
  }

  static Future<String> removeActivities() async {
    try {
      final response = await UserDatasource.removeActivitiesRouter();

      return response["message"];
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/features/user/data/user_datasource.dart';
import 'package:hakbang/notifiers.dart';

class UserRepo {
  static Future<Map<String, dynamic>> signupUser(
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await UserDatasource.signupUserRouter(userData);
      return response;
    } catch (error) {
      throw error.toString();
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
      throw error.toString();
    }
  }

  static Future<String> updateUserAboutMe(Map<String, dynamic> data) async {
    try {
      final response = await UserDatasource.updateUserAboutMeRouter(data);
      return response["message"];
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<void> getUserActivities(String email) async {
    try {
      final response = await UserDatasource.getUserActivitiesRouter(email);
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
      throw error.toString();
    }
  }

  static Future<void> addActivity(Activity activity) async {
    try {
      await UserDatasource.addActivityRouter(activity);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<String> removeActivities() async {
    try {
      final response = await UserDatasource.removeActivitiesRouter();

      return response["message"];
    } catch (error) {
      throw error.toString();
    }
  }
}

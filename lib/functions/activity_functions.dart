import 'package:hakbang/features/user/data/models/activity.dart';
import 'package:hakbang/features/user/data/user_repo.dart';
import 'package:hakbang/notifiers.dart';

class ActivityFunctions {
  static void addUserActivity(
    String date,
    String description,
    String iconName,
  ) async {
    Activity activity = Activity(
      description: description,
      iconName: iconName,
      date: date,
    );
    activityList.value.insert(0, activity);
    await UserRepo.addActivity(activity);
  }

  static void removeActivities() async {
    activityList.value = [];
  }
}

import 'package:hakbang/models/activity.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

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
    await Database.addActivity(activity);
  }
}

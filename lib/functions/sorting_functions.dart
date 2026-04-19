import 'package:hakbang/models/activity.dart';
import 'package:hakbang/notifiers.dart';
import 'package:intl/intl.dart';

class SortingFunctions {
  static Future<void> sortASctivities() async {
    final List<Activity> sorted = List.from(activityList.value);
    DateFormat format = DateFormat("MMM dd, yyyy");
    sorted.sort((first, sec) {
      DateTime firstDate = format.parse(first.date);
      DateTime secDate = format.parse(sec.date);

      return secDate.compareTo(firstDate);
    });
    activityList.value = sorted;
  }
}

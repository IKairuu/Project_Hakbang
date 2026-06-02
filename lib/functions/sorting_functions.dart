import 'package:hakbang/notifiers.dart';

class SortingFunctions {
  static Future<void> sortASctivities() async {
    activityList.value.sort((first, sec) {
      return sec.date.compareTo(first.date);
    });
  }
}

import 'package:hakbang/notifiers.dart';
import 'package:intl/intl.dart';

class SortingFunctions {
  static Future<void> sortASctivities() async {
    DateFormat format = DateFormat("MMM dd, yyyy");
    activityList.value.sort((first, sec) {
      DateTime firstDate = format.parse(first.date);
      DateTime secDate = format.parse(sec.date);

      return secDate.compareTo(firstDate);
    });
  }
}

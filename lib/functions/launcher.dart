import 'package:hakbang/functions/activity_functions.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> launchBrowserView(
    Uri url,
    String name,
    String icon,
  ) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception("Could not launch $url");
    }
    ActivityFunctions.addUserActivity(
      DateFormat("MMM dd, yyyy").format(DateTime.now()),
      "Visited $name",
      icon,
    );
  }
}

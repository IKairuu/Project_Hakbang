import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> launchBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception("Could not launch $url");
    }
  }
}

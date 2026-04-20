import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}

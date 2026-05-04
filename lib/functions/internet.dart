import 'package:connectivity_plus/connectivity_plus.dart';

class Internet {
  static Future<bool> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    print(connectivityResult.contains(ConnectivityResult.mobile));

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    }
    return false;
  }
}

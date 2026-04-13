import 'package:geolocator/geolocator.dart';

class Locations {
  static Future<void> initializeLocationservices() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Geolocator.requestPermission();
    }
  }

  static Future<Position> getUserLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}

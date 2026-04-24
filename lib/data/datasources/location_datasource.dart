import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDataSource {
  Future<Position?> getCurrentLocation() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }
    return null;
  }

  Future<void> saveManualLocation(double lat, double lng) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('manual_lat', lat);
    await prefs.setDouble('manual_lng', lng);
  }

  Future<Position?> getManualLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble('manual_lat');
    final lng = prefs.getDouble('manual_lng');
    if (lat != null && lng != null) {
      return Position(longitude: lng, latitude: lat, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0);
    }
    return null;
  }
}
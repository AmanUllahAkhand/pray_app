import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getLocation();
  Future<void> setManualLocation(double lat, double lng);
}
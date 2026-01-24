import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pray_app/domain/usecases/get_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController {
  final currentPosition = Rxn<Position>();

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  LocationController(GetLocation find);

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
  }

  Future<void> loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final lat = prefs.getDouble('lat');
    final lng = prefs.getDouble('lng');

    if (lat != null && lng != null) {
      latitude.value = lat;
      longitude.value = lng;

      currentPosition.value = Position(
        latitude: lat,
        longitude: lng,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );
    }
  }
}

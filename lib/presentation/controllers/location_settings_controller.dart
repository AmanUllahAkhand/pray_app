import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pray_app/core/routes/app_routes.dart';
import 'location_controller.dart';

enum LocationMode { district, gps }

/// 🔹 Simple LatLng class for district mapping
class LatLng {
  final double lat;
  final double lng;
  const LatLng(this.lat, this.lng);
}

class LocationSettingsController extends GetxController {
  /// ================= COUNTRY & DISTRICT =================
  final selectedCountry = 'Bangladesh'.obs;
  final selectedDistrict = 'Dhaka'.obs;

  final List<String> districtsBD = [
    'Dhaka',
    'Chattogram',
    'Rajshahi',
    'Khulna',
    'Sylhet',
    'Barishal',
    'Rangpur',
    'Mymensingh',
  ];

  /// District → LatLng mapping
  final Map<String, LatLng> bdDistrictLatLng = {
    'Dhaka': const LatLng(23.8103, 90.4125),
    'Chattogram': const LatLng(22.3569, 91.7832),
    'Rajshahi': const LatLng(24.3745, 88.6042),
    'Khulna': const LatLng(22.8456, 89.5403),
    'Sylhet': const LatLng(24.8949, 91.8687),
    'Barishal': const LatLng(22.7010, 90.3535),
    'Rangpur': const LatLng(25.7439, 89.2752),
    'Mymensingh': const LatLng(24.7471, 90.4203),
  };

  /// ================= LOCATION MODE =================
  final locationMode = LocationMode.district.obs;

  /// ================= GPS =================
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  bool get isBangladesh => selectedCountry.value == 'Bangladesh';

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    _loadSavedLocation();
  }

  /// ================= LOAD SAVED LOCATION =================
  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    selectedCountry.value = prefs.getString('country') ?? 'Bangladesh';
    selectedDistrict.value = prefs.getString('district') ?? 'Dhaka';

    final mode = prefs.getString('mode');
    if (mode != null) {
      locationMode.value =
          LocationMode.values.firstWhere((e) => e.name == mode,
              orElse: () => LocationMode.district);
    }

    latitude.value = prefs.getDouble('lat') ?? 0.0;
    longitude.value = prefs.getDouble('lng') ?? 0.0;
  }

  /// ================= GPS PERMISSION & LOCATION =================
  Future<void> requestGpsLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("GPS Disabled", "Please enable location services");
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Required",
        "Enable location permission from settings",
      );
      await Geolocator.openAppSettings();
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  /// ================= FORCE GPS WHEN RADIO SELECTED =================
  Future<void> forceGpsPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("GPS Disabled", "Please enable location services");
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Required",
        "Enable location permission from settings",
      );
      await Geolocator.openAppSettings();
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }


  /// ================= SAVE LOCATION =================
  Future<void> saveLocation() async {
    final prefs = await SharedPreferences.getInstance();

    if (locationMode.value == LocationMode.gps) {
      await requestGpsLocation();

      if (latitude.value == 0.0 || longitude.value == 0.0) {
        Get.snackbar("Location Error", "GPS location not available");
        return;
      }
    } else {
      // District mode → convert district to lat/lng
      final latLng = bdDistrictLatLng[selectedDistrict.value];
      if (latLng == null) {
        Get.snackbar("Error", "Invalid district selected");
        return;
      }

      latitude.value = latLng.lat;
      longitude.value = latLng.lng;
    }

    // Save to SharedPreferences
    await prefs.setBool('locationConfigured', true);
    await prefs.setString('country', selectedCountry.value);
    await prefs.setString('district', selectedDistrict.value);
    await prefs.setString('mode', locationMode.value.name);
    await prefs.setDouble('lat', latitude.value);
    await prefs.setDouble('lng', longitude.value);

    // Notify HomeController / LocationController
    if (Get.isRegistered<LocationController>()) {
      Get.find<LocationController>().loadSavedLocation();
    }

    // Navigate to Home
    Get.offAllNamed(AppRoutes.home);
  }
}

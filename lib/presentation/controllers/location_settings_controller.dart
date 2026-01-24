import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pray_app/core/routes/app_routes.dart';

import 'location_controller.dart';

enum LocationMode { district, gps }

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

  /// ================= LOAD SAVED =================
  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    selectedCountry.value =
        prefs.getString('country') ?? 'Bangladesh';

    selectedDistrict.value =
        prefs.getString('district') ?? 'Dhaka';

    final mode = prefs.getString('mode');
    if (mode != null) {
      locationMode.value =
          LocationMode.values.firstWhere(
                (e) => e.name == mode,
            orElse: () => LocationMode.district,
          );
    }

    latitude.value = prefs.getDouble('lat') ?? 0.0;
    longitude.value = prefs.getDouble('lng') ?? 0.0;
  }

  /// ================= GPS HANDLER =================
  Future<void> requestGpsLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Disabled", "Please enable GPS");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Denied",
        "Enable location permission from settings",
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  /// ================= SAVE =================
  Future<void> saveLocation() async {
    if (locationMode.value == LocationMode.gps) {
      await requestGpsLocation();
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('locationConfigured', true);
    await prefs.setString('country', selectedCountry.value);
    await prefs.setString('district', selectedDistrict.value);
    await prefs.setString('mode', locationMode.value.name);
    await prefs.setDouble('lat', latitude.value);
    await prefs.setDouble('lng', longitude.value);

    /// 🔥 Important: notify Home
    if (Get.isRegistered<LocationController>()) {
      Get.find<LocationController>().loadSavedLocation();
    }

    Get.offAllNamed(AppRoutes.home);
  }
}

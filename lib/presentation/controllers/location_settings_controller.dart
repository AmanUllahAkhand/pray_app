import 'package:get/get.dart';

class LocationSettingsController extends GetxController {
  final selectedCountry = 'Bangladesh'.obs;
  final selectedDistrict = 'Dhaka'.obs;

  final countries = ['Bangladesh', 'India', 'Pakistan', 'Saudi Arabia'];
  final districtsBD = [
    'Dhaka',
    'Chattogram',
    'Rajshahi',
    'Khulna',
    'Sylhet'
  ];

  bool get isBangladesh => selectedCountry.value == 'Bangladesh';

  void saveLocation() {
    // TODO: save logic
    print("Country: ${selectedCountry.value}");
    print("District: ${selectedDistrict.value}");
  }
}

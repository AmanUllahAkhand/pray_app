import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home/location_info_model.dart';

class LocationInfoService {
  Future<LocationInfoModel?> fetchLocationInfo({
    required double lat,
    required double lng,
  }) async {
    final url =
        "https://quran-api-production-eeb6.up.railway.app/api/location-info?latitude=$lat&longitude=$lng";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LocationInfoModel.fromJson(data);
      }
    } catch (e) {
      print("Location Info Error: $e");
    }

    return null;
  }
}
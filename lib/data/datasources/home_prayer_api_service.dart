import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home/home_prayer_times_model.dart';

class HomePrayerApiService {
  Future<HomePrayerTimesModel?> fetchPrayerTimes({
    required double lat,
    required double lng,
    required String date,
  }) async {
    final url =
        "https://quran-api-production-eeb6.up.railway.app/api/prayer-times?latitude=$lat&longitude=$lng&date=$date";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return HomePrayerTimesModel.fromJson(jsonData);
      }
    } catch (e) {
      print("API Error: $e");
    }

    return null;
  }
}
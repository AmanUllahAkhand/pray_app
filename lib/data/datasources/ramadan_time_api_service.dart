
import 'package:dio/dio.dart';

class RamadanTimeService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> fetchRamadanTime({
    required double latitude,
    required double longitude,
    required String date,
  }) async {
    try {
      final url =
          "https://quran-api-production-eeb6.up.railway.app/api/ramadan-times"
          "?latitude=$latitude&longitude=$longitude&date=$date";

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      }

      return null;
    } catch (e) {
      print("RamadanTimeService error: $e");
      return null;
    }
  }
}
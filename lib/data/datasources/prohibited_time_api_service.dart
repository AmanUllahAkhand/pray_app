import 'dart:convert';
import 'package:http/http.dart' as http;

class ProhibitedTimeService {
  Future<Map<String, dynamic>?> fetch({
    required double lat,
    required double lng,
    required String date,
  }) async {
    final url = Uri.parse(
      "https://quran-api-production-eeb6.up.railway.app/api/prohibited-prayer-times"
          "?latitude=$lat&longitude=$lng&date=$date",
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    return null;
  }
}
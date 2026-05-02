import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/quran/sura_model.dart';


class QuranApiResponse {
  final int page;
  final int totalPages;
  final List<SuraModel> data;

  QuranApiResponse({
    required this.page,
    required this.totalPages,
    required this.data,
  });
}

class QuranApiService {
  Future<QuranApiResponse> fetchSuraList({
    required int page,
    int limit = 114,
  }) async {
    final url = Uri.parse(
      "https://quran-api-production-eeb6.up.railway.app/api/surah-list?page=$page&limit=$limit",
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);

      final List list = body['data'];

      return QuranApiResponse(
        page: int.parse(body['page']),
        totalPages: body['total_pages'],
        data: list.map((e) => SuraModel.fromJson(e)).toList(),
      );
    } else {
      throw Exception("Failed to load sura list");
    }
  }
}
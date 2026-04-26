import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/models/quran/sura_details_model.dart';

class SuraController extends GetxController {
  final ayahs = <AyahModel>[].obs;

  var isLoading = false.obs;
  var isLoadMore = false.obs;

  var revelation = ''.obs;
  var totalAyah = 0.obs;
  var suraName = ''.obs;

  var arabicOnly = false.obs;

  int page = 1;
  int totalPages = 1;

  int suraId = 1;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    suraId = args['id'];
    suraName.value = args['name'];

    fetchAyahs();
  }

  Future<void> fetchAyahs({bool loadMore = false}) async {
    if (loadMore) {
      if (page > totalPages) return;
      isLoadMore.value = true;
    } else {
      isLoading.value = true;
      page = 1;
      ayahs.clear();
    }

    try {
      final url =
          'https://quran-api-production-eeb6.up.railway.app/api/surah-details?id=$suraId&page=$page';

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        final surah = data['surah'];
        revelation.value = surah['revelation'];
        totalAyah.value = surah['total_ayah'];

        totalPages = data['pagination']['total_pages'] ?? 1;

        final List list = data['data'];

        ayahs.addAll(list.map((e) => AyahModel.fromJson(e)).toList());

        if (page < totalPages) {
          page++;
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    isLoading.value = false;
    isLoadMore.value = false;
  }

  void loadMore() {
    if (!isLoadMore.value && page <= totalPages) {
      fetchAyahs(loadMore: true);
    }
  }
}
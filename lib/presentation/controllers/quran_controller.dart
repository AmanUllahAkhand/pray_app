import 'package:get/get.dart';
import '../../data/datasources/Quran/quran_api_service.dart';
import '../../data/models/quran/sura_model.dart';

class QuranController extends GetxController {
  final searchQuery = ''.obs;

  final suraList = <SuraModel>[].obs;

  final isLoading = false.obs;
  final isLoadMore = false.obs;

  int currentPage = 1;
  int totalPages = 1;

  final QuranApiService apiService = QuranApiService();

  @override
  void onInit() {
    super.onInit();
    fetchSuras(isInitial: true);
  }

  Future<void> fetchSuras({bool isInitial = false}) async {
    try {
      if (isInitial) {
        isLoading.value = true;
        currentPage = 1;
      } else {
        if (currentPage > totalPages) return;
        isLoadMore.value = true;
      }

      final res = await apiService.fetchSuraList(page: currentPage);

      totalPages = res.totalPages;

      if (isInitial) {
        suraList.value = res.data;
      } else {
        suraList.addAll(res.data);
      }

      currentPage++;
    } catch (e) {
      print("Pagination error: $e");
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  void loadMore() {
    if (!isLoadMore.value && currentPage <= totalPages) {
      fetchSuras();
    }
  }

  List<SuraModel> get filteredSuraList {
    if (searchQuery.value.isEmpty) return suraList;

    return suraList.where((s) {
      return s.nameEn.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          s.nameAr.contains(searchQuery.value);
    }).toList();
  }

  void onSearch(String value) {
    searchQuery.value = value;
  }

  void onSuraTap(SuraModel sura) {
    Get.toNamed('/sura-details', arguments: sura);
  }
}

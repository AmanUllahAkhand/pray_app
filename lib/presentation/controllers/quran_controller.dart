import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../data/datasources/Quran/quran_api_service.dart';
import '../../data/models/quran/sura_model.dart';

class QuranController extends GetxController {

  final QuranApiService apiService = QuranApiService();

  final searchQuery = ''.obs;

  final suraList = <SuraModel>[].obs;

  final isLoading = false.obs;
  final isLoadMore = false.obs;

  int currentPage = 1;
  int totalPages = 1;

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

      final response = await apiService.fetchSuraList(
        page: currentPage,
      );

      totalPages = response.totalPages;

      if (isInitial) {
        suraList.assignAll(response.data);
      } else {
        suraList.addAll(response.data);
      }

      currentPage++;

    } catch (e) {

      debugPrint('Quran Fetch Error: $e');

    } finally {

      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  void loadMore() {

    if (!isLoadMore.value &&
        currentPage <= totalPages) {

      fetchSuras();
    }
  }

  List<SuraModel> get filteredSuraList {

    if (searchQuery.value.isEmpty) {
      return suraList;
    }

    return suraList.where((sura) {

      return sura.nameEn
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()) ||

          sura.nameAr
              .contains(searchQuery.value) ||

          sura.id
              .toString()
              .contains(searchQuery.value);

    }).toList();
  }

  void onSearch(String value) {
    searchQuery.value = value;
  }

  void onSuraTap(SuraModel sura) {

    Get.toNamed(
      AppRoutes.sura,
      arguments: {
        'id': sura.id,
        'name': sura.nameEn,
      },
    );
  }
}

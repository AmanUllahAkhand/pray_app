import 'package:get/get.dart';
import '../../data/models/quran/sura_model.dart';

class QuranController extends GetxController {
  final searchQuery = ''.obs;

  final suraList = <SuraModel>[
    SuraModel(id: 1, nameEn: 'Al-Faatiha', nameAr: 'ٱلْفَاتِحَةُ', verses: 7, type: 'Meccan'),
    SuraModel(id: 2, nameEn: 'Al-Baqarah', nameAr: 'ٱلْبَقَرَةُ', verses: 286, type: 'Medinan'),
    SuraModel(id: 3, nameEn: 'Al-Imran', nameAr: 'آلِ عِمْرَانَ', verses: 200, type: 'Medinan'),
    SuraModel(id: 4, nameEn: 'An-Nisa', nameAr: 'ٱلنِّسَاءُ', verses: 176, type: 'Medinan'),
    SuraModel(id: 5, nameEn: 'Al-Ma\'idah', nameAr: 'ٱلْمَائِدَةُ', verses: 120, type: 'Medinan'),
    SuraModel(id: 6, nameEn: 'Al-An\'am', nameAr: 'ٱلْأَنْعَامُ', verses: 165, type: 'Meccan'),
    SuraModel(id: 6, nameEn: 'Al-An\'am', nameAr: 'ٱلْأَنْعَامُ', verses: 165, type: 'Meccan'),
    SuraModel(id: 6, nameEn: 'Al-An\'am', nameAr: 'ٱلْأَنْعَامُ', verses: 165, type: 'Meccan'),
    SuraModel(id: 6, nameEn: 'Al-An\'am', nameAr: 'ٱلْأَنْعَامُ', verses: 165, type: 'Meccan'),
    SuraModel(id: 6, nameEn: 'Al-An\'am', nameAr: 'ٱلْأَنْعَامُ', verses: 165, type: 'Meccan'),
  ].obs;

  List<SuraModel> get filteredSuraList {
    if (searchQuery.value.isEmpty) {
      return suraList;
    }
    return suraList
        .where((s) =>
    s.nameEn.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        s.nameAr.contains(searchQuery.value))
        .toList();
  }

  void onSearch(String value) {
    searchQuery.value = value;
  }

  void onSuraTap(SuraModel sura) {
    // Navigate to Sura details
    Get.toNamed('/sura-details', arguments: sura);
  }
}

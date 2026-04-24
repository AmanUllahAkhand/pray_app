import 'package:get/get.dart';

class TasbihController extends GetxController {
  final count = 0.obs;
  final currentIndex = 0.obs;

  final List<Map<String, String>> duas = [
    {'ar': 'سُبْحَانَ ٱللَّٰهِ', 'en': 'Subhanallah'},
    {'ar': 'ٱلْحَمْدُ لِلَّٰهِ', 'en': 'Alhamdulillah'},
    {'ar': 'ٱللَّٰهُ أَكْبَرُ', 'en': 'Allahu Akbar'},
    {'ar': 'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ', 'en': 'La ilaha illallah'},
    {'ar': 'أَسْتَغْفِرُ ٱللَّٰهَ', 'en': 'Astaghfirullah'},
    {'ar': 'سُبْحَانَ ٱللَّٰهِ وَبِحَمْدِهِ', 'en': 'Subhanallahi wabihamdihi'},
    {'ar': 'حَسْبُنَا ٱللَّٰهُ', 'en': 'Hasbunallahu'},
    {'ar': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِٱللَّٰهِ', 'en': 'La hawla wala quwwata'},
    {'ar': 'يَا رَبِّ', 'en': 'Ya Rabbi'},
    {'ar': 'رَبِّ ٱغْفِرْ لِي', 'en': 'Rabbi ghfir li'},
    {'ar': 'ٱللَّهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ', 'en': 'Salawat'},
    {'ar': 'سُبْحَانَ ٱللَّٰهِ ٱلْعَظِيمِ', 'en': 'Subhanallahil azeem'},
  ];

  void increment() => count.value++;

  void reset() => count.value = 0;

  void nextDua() {
    if (currentIndex.value < duas.length - 1) {
      currentIndex.value++;
      reset();
    }
  }

  void previousDua() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      reset();
    }
  }
}

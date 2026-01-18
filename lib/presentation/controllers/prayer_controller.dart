import 'package:get/get.dart';

import '../../core/constants/app_icons.dart';

class PrayerController extends GetxController {
  final currentPrayer = 'Isha'.obs;

  /// Map prayer → SVG background
  final prayerBgMap = {
    'Fajr': AppIcons.fajrBg,
    'Dhuhr': AppIcons.dhuhrBg,
    'Asr': AppIcons.asrBg,
    'Maghrib': AppIcons.maghribBg,
    'Isha': AppIcons.ishaBg,
  };

  String get currentBg =>
      prayerBgMap[currentPrayer.value] ?? prayerBgMap['Isha']!;
}

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/usecases/get_prayer_times.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';

import '../../core/constants/app_icons.dart';

class HomeController extends GetxController {
  final GetPrayerTimes getPrayerTimesUseCase;

  HomeController(this.getPrayerTimesUseCase);

  // Observables
  var prayerTime = Rxn<PrayerTime>();
  var hijriDate = ''.obs;
  var currentPrayer = 'Isha'.obs;
  var timeLeft = ''.obs;
  var prohibitedTimes = <String, String>{}.obs;
  var prayerRanges = <String, String>{}.obs;
  // Navigation
  final selectedIndex = 0.obs;
  final currentTime = ''.obs;
  final cityName = ''.obs;
  final countryName = ''.obs;


  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final locationCtrl = Get.find<LocationController>();

    ever(locationCtrl.currentPosition, (pos) {
      if (pos != null) {
        setLocationFromLatLng(pos.latitude, pos.longitude);
        fetchPrayerTimes();
      }
    });

    _startCountdownTimer();
  }



  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchPrayerTimes() async {
    final position = Get.find<LocationController>().currentPosition.value;
    if (position == null) return;

    print("Latitude: ${position.latitude}");
    print("Longitude: ${position.longitude}");

    try {
      final date = DateTime.now();
      final times = await getPrayerTimesUseCase.call(position, date);
      prayerTime.value = times;

      hijriDate.value =
          getPrayerTimesUseCase.getHijri() ?? "Hijri date unavailable";

      prohibitedTimes.value =
          getPrayerTimesUseCase.getProhibited(position, date);

      _calculatePrayerRanges(times);

      updateCurrentPrayerAndTimeLeft();
    } catch (e) {
      print("Prayer times error: $e");
    }
  }
  void _calculatePrayerRanges(PrayerTime times) {
    final prayerList = [
      {'name': 'Fajr', 'time': times.fajr},
      {'name': 'Dhuhr', 'time': times.dhuhr},
      {'name': 'Asr', 'time': times.asr},
      {'name': 'Maghrib', 'time': times.maghrib},
      {'name': 'Isha', 'time': times.isha},
    ];

    final Map<String, String> ranges = {};

    for (int i = 0; i < prayerList.length; i++) {
      final start = prayerList[i]['time'] as DateTime;

      final end = i < prayerList.length - 1
          ? prayerList[i + 1]['time'] as DateTime
          : (prayerList.first['time'] as DateTime)
          .add(const Duration(days: 1));

      ranges[prayerList[i]['name'] as String] =
          formatPrayerRange(start, end);
    }

    prayerRanges.value = ranges;
  }

  void updateCurrentPrayerAndTimeLeft() {
    final now = DateTime.now();
    final times = prayerTime.value;
    if (times == null) return;

    final prayers = [
      {'name': 'Fajr', 'time': times.fajr},
      {'name': 'Dhuhr', 'time': times.dhuhr},
      {'name': 'Asr', 'time': times.asr},
      {'name': 'Maghrib', 'time': times.maghrib},
      {'name': 'Isha', 'time': times.isha},
    ];

    DateTime? nextTime;
    String? nextName;

    for (final p in prayers) {
      if (now.isBefore(p['time'] as DateTime)) {
        nextTime = p['time'] as DateTime;
        nextName = p['name'] as String;
        break;
      }
    }

    if (nextTime == null) {
      nextTime = (prayers.first['time'] as DateTime).add(const Duration(days: 1));
      nextName = 'Fajr';
    }

    currentPrayer.value = nextName ?? 'Isha';

    final diff = nextTime.difference(now);
    timeLeft.value =
    "${diff.inHours.toString().padLeft(2, '0')}:${(diff.inMinutes % 60).toString().padLeft(2, '0')}:${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  // String formatTime(DateTime time) {
  //   return DateFormat('h:mm a').format(time);
  // }

  String formatPrayerRange(DateTime start, DateTime end) {
    final startTime = DateFormat('h:mm').format(start);
    final endTime = DateFormat('h:mm').format(end);
    return "$startTime–$endTime";
  }


  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateCurrentPrayerAndTimeLeft();
      _updateCurrentTime();
    });
  }
  String formatHijriDate(String rawHijri) {
    // Example input: "7 18, 1447 AH"
    try {
      final cleaned = rawHijri.replaceAll(',', '');
      final parts = cleaned.split(' ');

      final monthNumber = int.parse(parts[0]);
      final day = parts[1];
      final year = parts[2];

      final monthName = tr('hijri_month_$monthNumber');
      final ahText = tr('ah');

      return "$monthName $day, $year $ahText";
    } catch (e) {
      return rawHijri;
    }
  }

  String getPrayerIcon(String prayerName) {
    switch (prayerName.toLowerCase()) {
      case 'fajr':
        return AppIcons.fajr;
      case 'dhuhr':
        return AppIcons.dhuhr;
      case 'asr':
        return AppIcons.asr;
      case 'maghrib':
        return AppIcons.maghrib;
      case 'isha':
        return AppIcons.isha;
      default:
        return AppIcons.fajr; // fallback
    }
  }

  void _updateCurrentTime() {
    currentTime.value = DateFormat('hh:mm a').format(DateTime.now());
  }

  Future<void> setLocationFromLatLng(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        cityName.value = place.locality ?? '';
        countryName.value = place.country ?? '';
      }
    } catch (e) {
      print("Location name error: $e");
    }
  }

}
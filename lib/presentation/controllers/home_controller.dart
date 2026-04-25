import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/usecases/get_prayer_times.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../data/datasources/home_prayer_api_service.dart';
import '../../data/datasources/location_info_service.dart';
import '../../data/datasources/prohibited_time_api_service.dart';
import '../../data/datasources/ramadan_time_api_service.dart';
import '../../data/models/home/home_prayer_times_model.dart';
import '../../data/models/home/prohibited_time_model.dart';
import '../../data/models/home/ramadan_time_model.dart';

class HomeController extends GetxController {
  final GetPrayerTimes getPrayerTimesUseCase;

  HomeController(this.getPrayerTimesUseCase);

  // Observables
  var prayerTime = Rxn<PrayerTime>();
  var hijriDate = ''.obs;
  var currentPrayer = 'Isha'.obs;
  var timeLeft = ''.obs;
  // var prohibitedTimes = <String, String>{}.obs;
  var prayerRanges = <String, String>{}.obs;
  var prayerDateRanges = <String, Map<String, DateTime>>{}.obs;
  // Navigation
  final selectedIndex = 0.obs;
  final currentTime = ''.obs;
  final cityName = ''.obs;
  final countryName = ''.obs;
  var gregorianDate = ''.obs;
  var currentPrayerStartTime = ''.obs;
  var ramadanTime = Rxn<RamadanTimeModel>();
  var remainingSehriTime = ''.obs;
  var remainingTimeText = ''.obs;
  var remainingLabel = ''.obs;
  final RamadanTimeService ramadanTimeService = RamadanTimeService();
  final locationInfoService = LocationInfoService();
  final homePrayerApi = HomePrayerApiService();
  var homePrayerTimes = Rxn<HomePrayerTimesModel>();
  final prohibitedTimeService = ProhibitedTimeService();
  var prohibitedTimes = <String, ProhibitedTimeModel>{}.obs;


  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final locationCtrl = Get.find<LocationController>();

    ever(locationCtrl.currentPosition, (pos) {
      if (pos != null) {
        setLocationFromLatLng(pos.latitude, pos.longitude);
        fetchLocationInfo(pos.latitude, pos.longitude);
        fetchRamadanTime(pos.latitude, pos.longitude);
        fetchProhibitedTimes(pos.latitude, pos.longitude);
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

    try {
      final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // 🔥 API CALL
      final apiData = await homePrayerApi.fetchPrayerTimes(
        lat: position.latitude,
        lng: position.longitude,
        date: date,
      );

      if (apiData != null) {
        homePrayerTimes.value = apiData;

        prayerRanges.value = {
          "Fajr":
          "${formatToAmPm(apiData.fajr.start)} – ${formatToAmPm(apiData.fajr.end)}",
          "Dhuhr":
          "${formatToAmPm(apiData.dhuhr.start)} – ${formatToAmPm(apiData.dhuhr.end)}",
          "Asr":
          "${formatToAmPm(apiData.asr.start)} – ${formatToAmPm(apiData.asr.end)}",
          "Maghrib":
          "${formatToAmPm(apiData.maghrib.start)} – ${formatToAmPm(apiData.maghrib.end)}",
          "Isha":
          "${formatToAmPm(apiData.isha.start)} – ${formatToAmPm(apiData.isha.end)}",
        };

        // ✅ NEW: store actual DateTime ranges
        prayerDateRanges.value = {
          "Fajr": {
            "start": parseToDateTime(apiData.fajr.start),
            "end": parseToDateTime(apiData.fajr.end),
          },
          "Dhuhr": {
            "start": parseToDateTime(apiData.dhuhr.start),
            "end": parseToDateTime(apiData.dhuhr.end),
          },
          "Asr": {
            "start": parseToDateTime(apiData.asr.start),
            "end": parseToDateTime(apiData.asr.end),
          },
          "Maghrib": {
            "start": parseToDateTime(apiData.maghrib.start),
            "end": parseToDateTime(apiData.maghrib.end),
          },
          "Isha": {
            "start": parseToDateTime(apiData.isha.start),
            "end": parseToDateTime(apiData.isha.end),
          },
        };
      }

      // OPTIONAL: keep existing logic
      final times = await getPrayerTimesUseCase.call(position, DateTime.now());
      prayerTime.value = times;

      updateCurrentPrayerAndTimeLeft();

    } catch (e) {
      print("Prayer times error: $e");
    }
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

    String current = 'Asr';
    DateTime? nextPrayerTime;
    DateTime? currentStart;

    for (int i = 0; i < prayers.length; i++) {
      final start = prayers[i]['time'] as DateTime;

      final end = i < prayers.length - 1
          ? prayers[i + 1]['time'] as DateTime
          : (prayers[0]['time'] as DateTime).add(const Duration(days: 1));

      if (now.isAfter(start) && now.isBefore(end)) {
        current = prayers[i]['name'] as String;
        currentStart = start;
        nextPrayerTime = end;
        break;
      }
    }

    if (nextPrayerTime == null) {
      current = 'Isha';
      currentStart = times.isha;
      nextPrayerTime = (times.fajr).add(const Duration(days: 1));
    }

    currentPrayer.value = current;

    // ✅ set START TIME
    if (currentStart != null) {
      currentPrayerStartTime.value =
          DateFormat('hh:mm a').format(currentStart);
    }

    final diff = nextPrayerTime.difference(now);

    timeLeft.value =
    "${diff.inHours.toString().padLeft(2, '0')}:"
        "${(diff.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }


  String formatPrayerRange(DateTime start, DateTime end) {
    final startTime = DateFormat('h:mm').format(start);
    final endTime = DateFormat('h:mm').format(end);
    return "$startTime–$endTime";
  }


  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateCurrentPrayerAndTimeLeft();
      _updateCurrentTime();
      _calculateRemainingSehri();
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
  Future<void> fetchLocationInfo(double lat, double lng) async {
    try {
      final result = await locationInfoService.fetchLocationInfo(
        lat: lat,
        lng: lng,
      );

      if (result != null) {
        cityName.value = result.city;
        countryName.value = result.country;
        hijriDate.value = result.hijriDate;
        gregorianDate.value = result.gregorianDate;
      }
    } catch (e) {
      print("Location Info fetch error: $e");
    }
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

  Future<void> fetchRamadanTime(double lat, double lng) async {
    try {
      final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final data = await ramadanTimeService.fetchRamadanTime(
        latitude: lat,
        longitude: lng,
        date: date,
      );

      if (data != null) {
        ramadanTime.value = RamadanTimeModel.fromJson(data);

        _calculateRemainingSehri();
      }
    } catch (e) {
      print("Controller Ramadan fetch error: $e");
    }
  }

  DateTime parseToDateTime(String time) {
    final now = DateTime.now();
    final parsed = DateFormat("HH:mm").parse(time);

    return DateTime(
      now.year,
      now.month,
      now.day,
      parsed.hour,
      parsed.minute,
    );
  }

  bool isPrayerTimeActive(String name) {
    final range = prayerDateRanges[name];
    if (range == null) return false;

    final now = DateTime.now();
    final start = range["start"]!;
    final end = range["end"]!;

    return now.isAfter(start) && now.isBefore(end);
  }
  String getActivePrayerName() {
    final now = DateTime.now();

    for (final entry in prayerDateRanges.entries) {
      final start = entry.value["start"]!;
      final end = entry.value["end"]!;

      if (now.isAfter(start) && now.isBefore(end)) {
        return entry.key;
      }
    }

    return "Prohibited Time";
  }
  String getActivePrayerStartTime() {
    final now = DateTime.now();

    for (final entry in prayerDateRanges.entries) {
      final start = entry.value["start"]!;
      final end = entry.value["end"]!;

      if (now.isAfter(start) && now.isBefore(end)) {
        return DateFormat('hh:mm a').format(start);
      }
    }

    return "--:--";
  }
  Color getActivePrayerColor() {
    return getActivePrayerName() == "Prohibited Time"
        ? Colors.red
        : backgroundColor;
  }

  void _calculateRemainingSehri() {
    final data = ramadanTime.value;
    if (data == null) return;

    try {
      final now = DateTime.now();

      final sehriTime = _parseTime(data.sehriLast);
      final iftarTime = _parseTime(data.iftarStart);

      /// =========================
      /// 1. BEFORE SEHRI ENDS
      /// =========================
      if (now.isBefore(sehriTime)) {
        final diff = sehriTime.difference(now);

        remainingLabel.value = "Remaining Sehri";
        remainingTimeText.value =
        "${_formatDuration(diff)}";
        return;
      }

      /// =========================
      /// 2. AFTER SEHRI → BEFORE IFTAR
      /// =========================
      if (now.isAfter(sehriTime) && now.isBefore(iftarTime)) {
        final diff = iftarTime.difference(now);

        remainingLabel.value = "Remaining Iftar";
        remainingTimeText.value =
        "${_formatDuration(diff)}";
        return;
      }

      /// =========================
      /// 3. AFTER IFTAR → NEXT SEHRI
      /// =========================
      final nextSehri = sehriTime.add(const Duration(days: 1));
      final diff = nextSehri.difference(now);

      remainingLabel.value = "Remaining Sehri";
      remainingTimeText.value =
      "Sehri Tomorrow In: ${_formatDuration(diff)}";

    } catch (e) {
      print("Remaining calc error: $e");
    }
  }
  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final parsed = DateFormat("hh:mm a").parse(time);

    return DateTime(
      now.year,
      now.month,
      now.day,
      parsed.hour,
      parsed.minute,
    );
  }
  String _formatDuration(Duration diff) {
    return "${diff.inHours.toString().padLeft(2, '0')}:"
        "${(diff.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(diff.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  Future<void> fetchProhibitedTimes(double lat, double lng) async {
    try {
      final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final data = await prohibitedTimeService.fetch(
        lat: lat,
        lng: lng,
        date: date,
      );

      if (data != null) {
        prohibitedTimes.value = {
          "Dawn": ProhibitedTimeModel.fromJson(data["dawn"]),
          "Afternoon": ProhibitedTimeModel.fromJson(data["afternoon"]),
          "Evening": ProhibitedTimeModel.fromJson(data["evening"]),
        };
      }
    } catch (e) {
      print("Prohibited API error: $e");
    }
  }

}
String formatToAmPm(String time24) {
  try {
    final parsedTime = DateFormat("HH:mm").parse(time24);
    return DateFormat("h:mma").format(parsedTime);
  } catch (e) {
    return time24;
  }
}
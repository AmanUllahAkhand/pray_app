import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/location_controller.dart';
import '../../data/models/home/home_prayer_times_model.dart';

class PrayerController extends GetxController {
  // Observables
  final isLoading = false.obs;
  final currentDate = DateTime.now().obs;
  final prayers = <Prayer>[].obs;

  final currentPrayer = '...'.obs;
  final currentPrayerRange = '...'.obs;
  final nextPrayerName = '...'.obs;
  final nextPrayerCountdown = '00:00:00'.obs;
  final allNotification = false.obs;

  Timer? _timer;
  HomePrayerTimesModel? _cachedModel;

  @override
  void onInit() {
    super.onInit();

    final locationCtrl = Get.find<LocationController>();

    // Initial fetch
    if (locationCtrl.currentPosition.value != null) {
      fetchPrayerTimes();
    }

    // Listen for location changes
    ever(locationCtrl.currentPosition, (pos) {
      if (pos != null) fetchPrayerTimes();
    });

    // Start background timer for countdown and "Now" updates
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_cachedModel != null) {
        _updateRealtimeLogic(_cachedModel!);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// ==========================================
  /// API DATA FETCHING
  /// ==========================================
  Future<void> fetchPrayerTimes() async {
    final locationCtrl = Get.find<LocationController>();
    final pos = locationCtrl.currentPosition.value;
    if (pos == null) return;

    isLoading.value = true;
    try {
      String dateStr = DateFormat('yyyy-MM-dd').format(currentDate.value);
      final url = "https://quran-api-production-eeb6.up.railway.app/api/prayer-times?latitude=${pos.latitude}&longitude=${pos.longitude}&date=$dateStr";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cachedModel = HomePrayerTimesModel.fromJson(data);

        _updateUIList(_cachedModel!);
        _updateRealtimeLogic(_cachedModel!);
      }
    } catch (e) {
      print("Prayer fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _updateUIList(HomePrayerTimesModel model) {
    prayers.assignAll([
      Prayer(name: "Fajr", svgIcon: AppIcons.fajr, time: _format12h(model.fajr.start), endTime: model.fajr.end),
      Prayer(name: "Dhuhr", svgIcon: AppIcons.dhuhr, time: _format12h(model.dhuhr.start), endTime: model.dhuhr.end),
      Prayer(name: "Asr", svgIcon: AppIcons.asr, time: _format12h(model.asr.start), endTime: model.asr.end),
      Prayer(name: "Maghrib", svgIcon: AppIcons.maghrib, time: _format12h(model.maghrib.start), endTime: model.maghrib.end),
      Prayer(name: "Isha", svgIcon: AppIcons.isha, time: _format12h(model.isha.start), endTime: model.isha.end),
    ]);
  }

  /// ==========================================
  /// REALTIME LOGIC (Countdown & Active Prayer)
  /// ==========================================
  void _updateRealtimeLogic(HomePrayerTimesModel model) {
    final now = DateTime.now();

    // Create actual DateTime objects from strings
    final fajrStart = _parse(model.fajr.start);
    final dhuhrStart = _parse(model.dhuhr.start);
    final asrStart = _parse(model.asr.start);
    final maghribStart = _parse(model.maghrib.start);
    final ishaStart = _parse(model.isha.start);
    final nextFajr = fajrStart.add(const Duration(days: 1));

    List<Map<String, dynamic>> schedule = [
      {'name': 'Fajr', 'start': fajrStart, 'range': "${_format12h(model.fajr.start)} - ${_format12h(model.fajr.end)}"},
      {'name': 'Dhuhr', 'start': dhuhrStart, 'range': "${_format12h(model.dhuhr.start)} - ${_format12h(model.dhuhr.end)}"},
      {'name': 'Asr', 'start': asrStart, 'range': "${_format12h(model.asr.start)} - ${_format12h(model.asr.end)}"},
      {'name': 'Maghrib', 'start': maghribStart, 'range': "${_format12h(model.maghrib.start)} - ${_format12h(model.maghrib.end)}"},
      {'name': 'Isha', 'start': ishaStart, 'range': "${_format12h(model.isha.start)} - ${_format12h(model.isha.end)}"},
      {'name': 'Fajr', 'start': nextFajr},
    ];

    for (int i = 0; i < schedule.length - 1; i++) {
      if (now.isAfter(schedule[i]['start']) && now.isBefore(schedule[i+1]['start'])) {
        currentPrayer.value = schedule[i]['name'];
        currentPrayerRange.value = schedule[i]['range'] ?? "";
        nextPrayerName.value = schedule[i+1]['name'];

        // Calculate Countdown
        final diff = schedule[i+1]['start'].difference(now);
        nextPrayerCountdown.value = _formatDuration(diff);
        break;
      }
    }
  }

  /// ==========================================
  /// HELPERS & DATE NAV
  /// ==========================================
  DateTime _parse(String time) {
    final parts = time.split(':');
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  String _format12h(String time24) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final period = hour >= 12 ? "PM" : "AM";
    final h12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "$h12:${parts[1]} $period";
  }

  String _formatDuration(Duration d) {
    String h = d.inHours.toString().padLeft(2, '0');
    String m = (d.inMinutes % 60).toString().padLeft(2, '0');
    String s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "-$h:$m:$s";
  }

  void nextDate() {
    currentDate.value = currentDate.value.add(const Duration(days: 1));
    fetchPrayerTimes();
  }

  void previousDate() {
    currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    fetchPrayerTimes();
  }

  String get formattedGregorianDate => DateFormat('EEE, d MMMM yyyy').format(currentDate.value);

  String get formattedHijriDate {
    final hDate = HijriCalendar.fromDate(currentDate.value);
    return "${hDate.longMonthName} ${hDate.hDay}, ${hDate.hYear} AH";
  }

  String get currentBg => {
    'Fajr': AppIcons.fajrBg,
    'Dhuhr': AppIcons.dhuhrBg,
    'Asr': AppIcons.asrBg,
    'Maghrib': AppIcons.maghribBg,
    'Isha': AppIcons.ishaBg,
  }[currentPrayer.value] ?? AppIcons.ishaBg;

  /// ==========================================
  /// TOGGLES
  /// ==========================================
  void toggleCheck(int index) {
    prayers[index].isChecked = !prayers[index].isChecked;
    prayers.refresh();
  }

  void toggleNotification(int index) {
    prayers[index].isNotificationActive = !prayers[index].isNotificationActive;
    allNotification.value = prayers.every((p) => p.isNotificationActive);
    prayers.refresh();
  }

  void toggleAllNotification(bool value) {
    allNotification.value = value;
    for (var p in prayers) { p.isNotificationActive = value; }
    prayers.refresh();
  }
}
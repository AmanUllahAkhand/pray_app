import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/usecases/get_prayer_times.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';

class HomeController extends GetxController {
  final GetPrayerTimes getPrayerTimesUseCase;

  HomeController(this.getPrayerTimesUseCase);

  // Observables
  var prayerTime = Rxn<PrayerTime>();
  var hijriDate = ''.obs;
  var currentPrayer = 'Isha'.obs;
  var timeLeft = ''.obs;
  var prohibitedTimes = <String, String>{}.obs;

  // Navigation
  final selectedIndex = 0.obs;

  Timer? _timer;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchPrayerTimes();
  //   _startCountdownTimer();
  // }

  @override
  void onInit() {
    super.onInit();

    final locationCtrl = Get.find<LocationController>();

    ever(locationCtrl.currentPosition, (pos) {
      if (pos != null) {
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
      final date = DateTime.now();
      prayerTime.value = await getPrayerTimesUseCase.call(position, date);

      // Assuming your usecase has these helper methods
      hijriDate.value = getPrayerTimesUseCase.getHijri() ?? "Hijri date unavailable";
      prohibitedTimes.value = getPrayerTimesUseCase.getProhibited(position, date);

      updateCurrentPrayerAndTimeLeft();
      print("Prayer times ${prohibitedTimes.value}");
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

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateCurrentPrayerAndTimeLeft();
    });
  }
}
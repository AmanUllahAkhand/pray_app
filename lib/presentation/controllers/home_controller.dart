import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/usecases/get_prayer_times.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';

class HomeController extends GetxController {
  final GetPrayerTimes getPrayerTimesUseCase;

  HomeController(this.getPrayerTimesUseCase);

  var prayerTime = Rxn<PrayerTime>();
  var hijriDate = ''.obs;
  var prohibitedTimes = <String, String>{}.obs;
  var currentPrayer = 'Isha'.obs;  // Example, calculate based on time
  var timeLeft = '03:58:47'.obs;  // Calculate countdown

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final position = Get.find<LocationController>().currentPosition.value;
    if (position != null) {
      prayerTime.value = await getPrayerTimesUseCase.call(position, DateTime.now());
      hijriDate.value = getPrayerTimesUseCase.getHijri();
      prohibitedTimes.value = getPrayerTimesUseCase.getProhibited(position, DateTime.now());
      // Calculate current prayer and time left
      updateCurrentPrayer();
    }
  }

  void updateCurrentPrayer() {
    // Logic to find next prayer and countdown
    // For example:
    final now = DateTime.now();
    // Compare with prayerTime.value times
    timeLeft.value = 'Calculated time left';
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
}
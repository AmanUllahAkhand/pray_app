import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/prayer_controller.dart';

class PrayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerController>(() => PrayerController());
  }
}

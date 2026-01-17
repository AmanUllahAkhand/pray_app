import 'package:get/get.dart';
import 'package:pray_app/data/datasources/location_datasource.dart';
import 'package:pray_app/data/datasources/prayer_datasource.dart';
import 'package:pray_app/data/repositories/location_repository_impl.dart';
import 'package:pray_app/data/repositories/prayer_repository_impl.dart';
import 'package:pray_app/domain/usecases/get_location.dart';
import 'package:pray_app/domain/usecases/get_prayer_times.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';

import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/prayer_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationDataSource>(() => LocationDataSource());
    Get.lazyPut<PrayerDataSource>(() => PrayerDataSource());
    Get.lazyPut<LocationRepository>(() => LocationRepositoryImpl(Get.find<LocationDataSource>()));
    Get.lazyPut<PrayerRepository>(() => PrayerRepositoryImpl(Get.find<PrayerDataSource>()));
    Get.lazyPut<GetLocation>(() => GetLocation(Get.find<LocationRepository>()));
    Get.lazyPut<GetPrayerTimes>(() => GetPrayerTimes(Get.find<PrayerRepository>()));
    Get.lazyPut<LocationController>(() => LocationController(Get.find<GetLocation>()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find<GetPrayerTimes>()));
  }
}
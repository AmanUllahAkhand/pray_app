import 'package:get/get.dart';
import 'package:pray_app/core/routes/app_routes.dart';
import 'package:pray_app/presentation/bindings/home_binding.dart';
import 'package:pray_app/presentation/views/home_screen.dart';
import 'package:pray_app/presentation/views/more_screen.dart';
import 'package:pray_app/presentation/views/prayer_screen.dart';
import 'package:pray_app/presentation/views/quran_screen.dart';
import 'package:pray_app/presentation/views/splash_screen.dart';
import 'package:pray_app/presentation/views/tasbih_screen.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.prayer,
      page: () => const PrayerScreen(),
    ),
    GetPage(
      name: AppRoutes.quran,
      page: () => const QuranScreen(),
    ),
    GetPage(
      name: AppRoutes.tasbih,
      page: () => const TasbihScreen(),
    ),
    GetPage(
      name: AppRoutes.more,
      page: () => const MoreScreen(),
    ),
  ];
}
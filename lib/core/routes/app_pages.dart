import 'package:get/get.dart';
import 'package:pray_app/core/routes/app_routes.dart';
import 'package:pray_app/presentation/bindings/home_binding.dart';
import 'package:pray_app/presentation/views/home_screen.dart';
import 'package:pray_app/presentation/views/more_screen.dart';
import 'package:pray_app/presentation/views/prayer_screen.dart';
import 'package:pray_app/presentation/views/quran_screen.dart';
import 'package:pray_app/presentation/views/splash_screen.dart';
import 'package:pray_app/presentation/views/tasbih_screen.dart';
import '../../presentation/bindings/about_qalam_binding.dart';
import '../../presentation/bindings/calendar_binding.dart';
import '../../presentation/bindings/language_binding.dart';
import '../../presentation/bindings/more_binding.dart';
import '../../presentation/bindings/prayer_binding.dart';
import '../../presentation/bindings/privacy_policy_binding.dart';
import '../../presentation/bindings/quran_binding.dart';
import '../../presentation/bindings/support_binding.dart';
import '../../presentation/bindings/tasbhi_binding.dart';
import '../../presentation/views/about_qalam_screen.dart';
import '../../presentation/views/calendar_screen.dart';
import '../../presentation/views/language_screen.dart';
import '../../presentation/views/privacy_policy_screen.dart';
import '../../presentation/views/support_screen.dart';

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
      binding: PrayerBinding(),
    ),
    GetPage(
      name: AppRoutes.quran,
      page: () => QuranScreen(),
      binding: QuranBinding(),
    ),
    GetPage(
      name: AppRoutes.tasbih,
      page: () =>  TasbihScreen(),
      binding: TasbihBinding(),
    ),
    GetPage(
      name: AppRoutes.more,
      page: () => MoreScreen(),
      binding: MoreBinding(),
    ),
    GetPage(
      name: AppRoutes.support,
      page: () => const SupportScreen(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: AppRoutes.aboutQalam,
      page: () => const AboutQalamScreen(),
      binding: AboutQalamBinding(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: AppRoutes.calendar,
      page: () => const CalendarScreen(),
      binding: CalendarBinding(),
    ),
  ];
}
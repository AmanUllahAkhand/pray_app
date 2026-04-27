import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

class MoreController extends GetxController {
  void onDonateTap() {
    Get.toNamed(AppRoutes.support);
  }
  void onLanguageTap() {
    Get.toNamed(AppRoutes.language);
  }
  void onFaqTap() {}
  void onAboutTap() {Get.toNamed(AppRoutes.aboutQalam);}
  void onPrivacyTap() {Get.toNamed(AppRoutes.privacyPolicy);}
  void onRateTap() {}
  // void onRateTap() {Get.toNamed(AppRoutes.calendar);}
  void onShareTap() {}
}

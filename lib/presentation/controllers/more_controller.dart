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
  void onAboutTap() {}
  void onPrivacyTap() {}
  void onRateTap() {}
  void onShareTap() {}
}

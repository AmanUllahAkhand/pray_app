import 'package:get/get.dart';
import '../controllers/about_qalam_controller.dart';

class AboutQalamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutQalamController>(() => AboutQalamController());
  }
}

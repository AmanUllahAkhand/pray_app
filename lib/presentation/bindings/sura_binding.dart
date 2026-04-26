import 'package:get/get.dart';
import '../controllers/sura_controller.dart';


class SuraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuraController());
  }
}
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pray_app/domain/usecases/get_location.dart';
import '../../domain/repositories/location_repository.dart';

class LocationController extends GetxController {
  final GetLocation getLocationUseCase;

  LocationController(this.getLocationUseCase);

  var currentPosition = Rxn<Position>();

  @override
  void onInit() {
    super.onInit();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    currentPosition.value = await getLocationUseCase.call();
  }

  Future<void> setManual(double lat, double lng) async {
    await Get.find<LocationRepository>().setManualLocation(lat, lng);
    fetchLocation();
  }
}
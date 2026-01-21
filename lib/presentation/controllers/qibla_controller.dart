import 'dart:async';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class QiblaController extends GetxController {
  final locationStatus = Rxn<LocationStatus>();
  final qiblahDirection = Rxn<QiblahDirection>();

  StreamSubscription<QiblahDirection>? _qiblahStream;

  @override
  void onInit() {
    super.onInit();
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    final status = await FlutterQiblah.checkLocationStatus();
    if (status.enabled && status.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final newStatus = await FlutterQiblah.checkLocationStatus();
      locationStatus.value = newStatus;
    } else {
      locationStatus.value = status;
    }

    if (status.enabled &&
        (status.status == LocationPermission.always ||
            status.status == LocationPermission.whileInUse)) {
      _qiblahStream = FlutterQiblah.qiblahStream.listen((direction) {
        qiblahDirection.value = direction;
      });
    }
  }

  @override
  void onClose() {
    _qiblahStream?.cancel();
    FlutterQiblah().dispose();
    super.onClose();
  }

  void retry() {
    _checkLocationStatus();
  }
}

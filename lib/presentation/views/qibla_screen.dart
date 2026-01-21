import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/qibla_controller.dart';
import '../widgets/qiblaScreen/location_error_widget.dart';


class QiblaScreen extends StatelessWidget {
  final QiblaController controller = Get.put(QiblaController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mauiMist,
      appBar: AppBar(title: const Text("Qibla Compass")),
      body: Stack(
        children: [
          // Bottom background image
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              AppIcons.qiblaBg,
              width: screenWidth,
            ),
          ),

          // Main content (centered)
          Center(
            child: Obx(() {
              final status = controller.locationStatus.value;

              if (status == null) {
                return const CircularProgressIndicator();
              }

              if (!status.enabled) {
                return LocationErrorWidget(
                  error: "Please enable Location service",
                  callback: controller.retry,
                );
              }

              switch (status.status) {
                case LocationPermission.denied:
                  return LocationErrorWidget(
                    error: "Location permission denied",
                    callback: controller.retry,
                  );
                case LocationPermission.deniedForever:
                  return LocationErrorWidget(
                    error: "Location permission denied forever",
                    callback: controller.retry,
                  );
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  final direction = controller.qiblahDirection.value;
                  if (direction == null) {
                    return const CircularProgressIndicator();
                  }
                  return Center(
                  child: Transform.translate(
                  offset: const Offset(0, -80), // move up by 20 pixels
              child: _buildCompass(direction),
              ),
              );

              default:
                  return Container();
              }
            }),
          ),
        ],
      ),
    );
  }


  Widget _buildCompass(QiblahDirection direction) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Compass background stays centered
        Transform.rotate(
          angle: -direction.direction * (pi / 180),
          child: SvgPicture.asset(
            AppIcons.compass,
          ),
        ),

        Transform.rotate(
          angle: -direction.qiblah * (pi / 180),
          child: Transform.translate(
            offset: const Offset(-15, -170), // move up by 40 pixels
            child: SvgPicture.asset(
              AppIcons.qiblaNeedle,
            ),
          ),
        ),
      ],
    );
  }

}


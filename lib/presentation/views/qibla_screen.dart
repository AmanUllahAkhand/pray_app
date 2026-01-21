import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
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
              // 🚫 No sensor case
              if (!controller.hasSensor.value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -120), // move up by 20px
                      child: SvgPicture.asset(
                        AppIcons.compass,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CustomText(
                      text: "Your device does not support compass sensor",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }


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

                  return Transform.translate(
                    offset: const Offset(0, -80),
                    child: _buildCompass(direction),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔵 Compass area
        Stack(
          alignment: Alignment.center,
          children: [
            // Compass background
            Transform.rotate(
              angle: -direction.direction * (pi / 180),
              child: SvgPicture.asset(
                AppIcons.compass,
              ),
            ),

            // Qibla needle
            Transform.rotate(
              angle: -direction.qiblah * (pi / 180),
              child: Transform.translate(
                offset: const Offset(-15, -170),
                child: SvgPicture.asset(
                  AppIcons.qiblaNeedle,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 📝 Instruction text
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: CustomText(
            text: "To determine the Qibla direction, slowly rotate your phone left and right and keep it steady, parallel to the ground.",
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          )
        ),

      ],
    );
  }
}


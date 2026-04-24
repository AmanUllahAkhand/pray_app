import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

import '../../../core/constants/app_icons.dart';

class ProhibitedTimesSection extends StatelessWidget {
  const ProhibitedTimesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.prohibitedTimes.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                /// Background SVG
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SvgPicture.asset(
                      AppIcons.mosqueBg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Prohibited times for prayer",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                      SizedBox(height: 10),
                      _row(
                        title: "Dawn",
                        time: "05:00 am - 06:00 am",
                      ),
                      const SizedBox(height: 12),

                      _row(
                        title: "Afternoon",
                        time: "12:00 pm - 01:00 pm",
                      ),
                      const SizedBox(height: 12),

                      _row(
                        title: "Evening",
                        time: "05:00 pm - 06:00 pm",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _row({
    required String title,
    required String time,
  }) {
    // Example input: "05:00 am - 06:00 am"
    final parts = time.split(' - ');

    final start = parts[0].split(' ');
    final end = parts[1].split(' ');

    return Row(
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        const Spacer(),

        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              // Start time
              TextSpan(
                text: '${start[0]} ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: start[1],
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),

              const TextSpan(
                text: ' - ',
                style: TextStyle(fontSize: 14),
              ),

              // End time
              TextSpan(
                text: '${end[0]} ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: end[1],
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
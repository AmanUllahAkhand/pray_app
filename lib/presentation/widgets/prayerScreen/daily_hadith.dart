import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../controllers/home_controller.dart';
import '../custom_text.dart';

class DailyHadithSection extends StatelessWidget {
  const DailyHadithSection({super.key});

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
                    children: [
                      SvgPicture.asset(
                        AppIcons.quote_icon, // replace with your SVG asset
                        width: 30,
                        height: 30,
                      ),

                      const SizedBox(width: 12), // spacing between image and text

                      // Column for CustomText + Text
                      const Padding(
                        padding: EdgeInsets.only(left:30),
                        child: CustomText(
                          text: 'Daily Hadith',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const CustomText(
                        text: "Hadith, corpus of the sayings or traditions of the Prophet Muhammad, revered by Muslims as a major source of religious law and moral guidance. It comprises many reports of.",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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

}
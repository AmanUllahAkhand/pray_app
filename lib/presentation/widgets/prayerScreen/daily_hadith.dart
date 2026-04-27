import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../controllers/prayer_controller.dart';
import '../custom_text.dart';

class DailyHadithSection extends StatelessWidget {
  const DailyHadithSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the PrayerController instance
    final controller = Get.find<PrayerController>();

    return Obx(() {
      // If data is still loading or null, return empty
      if (controller.dailyHadith.value == null) {
        return const SizedBox.shrink();
      }

      final data = controller.dailyHadith.value!;

      return Container(
        width: double.infinity,
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
                  // Quote Icon
                  SvgPicture.asset(
                    AppIcons.quote_icon,
                    width: 30,
                    height: 30,
                  ),

                  const SizedBox(height: 12),

                  // Header
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: CustomText(
                      text: 'Daily Hadith',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Dynamic Hadith Content
                  CustomText(
                    text: data.hadith,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),

                  const SizedBox(height: 12),

                  // Dynamic Source Content
                  if (data.source.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: "— ${data.source}",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
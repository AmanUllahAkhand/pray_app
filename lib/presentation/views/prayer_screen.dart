import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/prayer_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
import '../../core/constants/app_colors.dart';

class PrayerScreen extends GetView<PrayerController> {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PrayerController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const CustomText(
          text: 'Prayer Time',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// =======================
            /// TOP PRAYER CARD
            /// =======================
            Obx(() {
              return Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    /// SVG Background (Dynamic)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: SvgPicture.asset(
                          controller.currentBg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Now Prayer Time',
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 6),

                          CustomText(
                            text: controller.currentPrayer.value,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),

                          const SizedBox(height: 4),

                          const CustomText(
                            text: '06:53 PM - 05:21 AM',
                            fontSize: 14,
                            color: Colors.white70,
                          ),

                          const Spacer(),

                          const Center(
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'Next Prayer in Fajr',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 8),
                                CustomText(
                                  text: '-05:45:45',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 6),
                                CustomText(
                                  text: 'Dhaka Bangladesh',
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            /// =======================
            /// DATE BAR
            /// =======================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                  Column(
                    children: [
                      CustomText(
                        text: 'Thursday, 14 January 2026',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4),
                      CustomText(
                        text: 'Rajab 16, 1447 AH',
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// =======================
            /// PRAYER LIST (UI ONLY)
            /// =======================
            _prayerTile('Fajr', '06:24 am'),
            _prayerTile('Dhuhr', '12:34 pm'),
            _prayerTile('Asr', '04:45 pm'),
            _prayerTile('Maghrib', '06:12 pm'),
            _prayerTile('Isha', '07:45 pm', isNow: true),
          ],
        ),
      ),
    );
  }

  Widget _prayerTile(
      String name,
      String time, {
        bool isNow = false,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isNow ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle_outlined,
            color: isNow ? Colors.white : primaryColor,
          ),
          const SizedBox(width: 12),
          CustomText(
            text: name,
            fontWeight: FontWeight.w600,
            color: isNow ? Colors.white : Colors.black,
          ),
          const Spacer(),
          if (isNow)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const CustomText(
                text: 'Now',
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          const SizedBox(width: 8),
          CustomText(
            text: time,
            color: isNow ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}

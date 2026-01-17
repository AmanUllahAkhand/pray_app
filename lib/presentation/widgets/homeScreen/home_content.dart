import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prayer_time_card.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prohibited_times_section.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import 'feature_button.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    return Obx(() {
      if (ctrl.prayerTime.value == null) {
        return Center(
          child: CircularProgressIndicator(color: primaryColor),
        );
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left part: SVG + Text
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.locationPin,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const CustomText(
                      text: "Dhaka, Bangladesh",
                      fontSize: 14 ,
                      fontWeight: FontWeight.w400,
                      color: backgroundColor,
                    )
                  ],
                ),

                // Right part: Button
                ElevatedButton(
                  onPressed: () {
                    // Button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dragonBayColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.donate,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const CustomText(
                        text: "Support Us",
                        fontSize: 14 ,
                        fontWeight: FontWeight.w400,
                        color: backgroundColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Hijri date
            CustomText(
              text: ctrl.formatHijriDate(ctrl.hijriDate.value),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: backgroundColor,
            ),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Prayer info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current / Next prayer
                    Row(
                      children: [
                        CustomText(
                          text: ctrl.currentPrayer.value,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: backgroundColor,
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          ctrl.getPrayerIcon(ctrl.currentPrayer.value),
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Current Time (Live) + Start time label
                    Obx(() {
                      final parts = ctrl.currentTime.value.split(' '); // ["03:11", "PM"]
                      return Row(
                        children: [
                          CustomText(
                            text: parts.isNotEmpty ? parts[0] : '',
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: backgroundColor,
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: parts.length > 1 ? parts[1] : '',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: backgroundColor,
                          ),
                          const SizedBox(width: 5),
                          const CustomText(
                            text: "(Start Time)",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: backgroundColor,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 4),

                    // Time Left
                    CustomText(
                      text: "Time Left: ${ctrl.timeLeft.value} (Approx)",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: backgroundColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                // Right side: SVG image
                SvgPicture.asset(
                  AppIcons.boy,
                ),
                SizedBox(width: 20,)
              ],
            ),


            // Prayer times horizontal cards
            _buildPrayerTimesRow(ctrl),

            const SizedBox(height: 24),

            // Feature buttons grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureButton(
                  title: "Record Your Prayer",
                  icon: Icons.calendar_today,
                  onTap: () {
                    // TODO: navigate or open bottom sheet
                  },
                ),
                FeatureButton(
                  title: "Qibla Finder",
                  icon: Icons.compass_calibration,
                  onTap: () {
                    // TODO: Get.toNamed('/qibla');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureButton(
                  title: "Tasbih Counter",
                  icon: Icons.pan_tool,
                  onTap: () {
                    // TODO: navigate to tasbih or open counter
                  },
                ),
                const SizedBox(width: 80), // placeholder for spacing
              ],
            ),

            const SizedBox(height: 32),

            // Prohibited times
            const ProhibitedTimesSection(),
            const SizedBox(height: 80),
          ],
        ),
      );
    });
  }

  Widget _buildPrayerTimesRow(HomeController ctrl) {
    final times = ctrl.prayerTime.value!;
    final names = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    final icons = [
      AppIcons.fajr,
      AppIcons.dhuhr,
      AppIcons.asr,
      AppIcons.maghrib,
      AppIcons.isha,

    ];


    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dragonBayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final isActive = ctrl.currentPrayer.value == names[index];
          return PrayerTimeCard(
            name: names[index],
            time: ctrl.prayerRanges[names[index]] ?? '',
            icon: icons[index],
            isActive: isActive,
          );
        }),
      ),
    );
  }
}
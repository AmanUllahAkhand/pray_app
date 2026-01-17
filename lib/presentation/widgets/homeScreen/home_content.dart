import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prayer_time_card.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prohibited_times_section.dart';
import '../../../core/constants/app_colors.dart';
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
            const SizedBox(height: 8),

            // Hijri date
            CustomText(
              text: ctrl.hijriDate.value,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 4),

            // Current / Next prayer
            CustomText(
              text: ctrl.currentPrayer.value,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            const SizedBox(height: 4),

            // Time left
            CustomText(
              text: "Time Left: ${ctrl.timeLeft.value} (Approx)",
              fontSize: 16,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),

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
      Icons.nightlight_round,
      Icons.wb_sunny,
      Icons.wb_twilight,
      Icons.nights_stay,
      Icons.dark_mode,
    ];

    final timeValues = [
      times.fajr,
      times.dhuhr,
      times.asr,
      times.maghrib,
      times.isha,
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade700.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final isActive = ctrl.currentPrayer.value == names[index];
          return PrayerTimeCard(
            name: names[index],
            time: ctrl.formatTime(timeValues[index]),
            icon: icons[index],
            isActive: isActive,
          );
        }),
      ),
    );
  }
}
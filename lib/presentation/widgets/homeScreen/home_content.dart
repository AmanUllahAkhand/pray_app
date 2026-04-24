import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prayer_time_card.dart';
import 'package:pray_app/presentation/widgets/homeScreen/prohibited_times_section.dart';
import 'package:pray_app/presentation/widgets/homeScreen/sehri_iftarInfo_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/routes/app_routes.dart';
import '../../controllers/home_controller.dart';
import '../custom_text.dart';
import 'feature_button_grid.dart';
import 'image_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    return Obx(() {
      if (ctrl.prayerTime.value == null) {
        return const Center(
          child: CircularProgressIndicator(color: primaryColor),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            // ================= TOP GREEN SECTION =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location + Support
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.location);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.locationPin,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Obx(() => CustomText(
                              text: ctrl.cityName.value.isNotEmpty
                                  ? "${ctrl.cityName.value}, ${ctrl.countryName.value}"
                                  : "Set location",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            )),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dragonBayColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Hijri Date
                  CustomText(
                    text: ctrl.formatHijriDate(ctrl.hijriDate.value),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: backgroundColor,
                  ),

                  const SizedBox(height: 6),

                  // Prayer + Boy
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  ctrl.getPrayerIcon(
                                      ctrl.currentPrayer.value),
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Obx(() {
                              final parts =
                              ctrl.currentTime.value.split(' ');
                              return Row(
                                children: [
                                  CustomText(
                                    text:
                                    parts.isNotEmpty ? parts[0] : '',
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: backgroundColor,
                                  ),

                                  CustomText(
                                    text:
                                    parts.length > 1 ? parts[1] : '',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400,
                                    color: backgroundColor,
                                  ),
                                  const CustomText(
                                    text: "(Start Time)",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: backgroundColor,
                                  ),
                                ],
                              );
                            }),

                            const SizedBox(height: 6),

                            CustomText(
                              text:
                              "Time Left: ${ctrl.timeLeft.value} (Approx)",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                          flex: 4,
                          child: SvgPicture.asset(AppIcons.boy)
                      ),
                    ],
                  ),
                  // Prayer Times Card
                  _buildPrayerTimesRow(ctrl),
                ],
              ),
            ),

            // ================= WHITE CARD SECTION =================
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Feature Buttons
                  const FeatureButtonGrid(),
                  SehriIftarInfoCard(
                    sehriEnd: "05:24 AM",
                    iftarStart: "05:38 PM",
                    remainingSehri: "09:08:49",
                    onSehriAlarmTap: () {},
                    onIftarAlarmTap: () {},
                  ),
                  const SizedBox(height: 20),
                  // ImageFeatureCardsSection
                  const ImageFeatureCardsSection(),
                  const SizedBox(height: 20),
                  // Prohibited Times
                  const ProhibitedTimesSection(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPrayerTimesRow(HomeController ctrl) {
    final names = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dragonBayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(names.length, (index) {
          final name = names[index];
          final isActive = ctrl.currentPrayer.value == name;

          return PrayerTimeCard(
            name: name,
            time: ctrl.prayerRanges[name] ?? '',
            icon: ctrl.getPrayerIcon(name),
            isActive: isActive,
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/prayer_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_switch.dart';
import '../widgets/prayerScreen/daily_hadith.dart';

class PrayerScreen extends GetView<PrayerController> {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(PrayerController());
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const CustomText(
          text: 'Prayer Time',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        // Show loading indicator while API data is being fetched
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// =======================
              /// TOP PRAYER CARD
              /// =======================
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: SvgPicture.asset(
                          controller.currentBg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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
                          // Displaying the range for the current prayer
                          CustomText(
                            text: controller.currentPrayerRange.value,
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          const Spacer(),
                          Center(
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'Next Prayer in ${controller.nextPrayerName.value}',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                                const SizedBox(height: 8),
                                CustomText(
                                  text: controller.nextPrayerCountdown.value,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 6),
                                Obx(() => CustomText(
                                  text: '${homeController.cityName.value}, ${homeController.countryName.value}',
                                  fontSize: 12,
                                  color: Colors.white70,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// =======================
              /// DATE BAR (English & Hijri)
              /// =======================
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: primaryColor, // Using primaryColor for the date bar
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous date button
                    GestureDetector(
                      onTap: controller.previousDate,
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                    ),

                    // Date Column
                    Column(
                      children: [
                        CustomText(
                          text: controller.formattedGregorianDate,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: controller.formattedHijriDate,
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ],
                    ),

                    // Next date button
                    GestureDetector(
                      onTap: controller.nextDate,
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ALL PRAYER NOTIFICATION SWITCH
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: gramsHair,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFC7E3DD)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'All Prayer Notification',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    StyledSwitch(
                      // FIX: .value turns RxBool into a regular bool
                      isToggled: controller.allNotification,
                      onToggled: (val) => controller.toggleAllNotification(val),
                      size: 28,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// =======================
              /// PRAYER LIST (From API)
              /// =======================
              Column(
                children: List.generate(controller.prayers.length, (index) {
                  final prayer = controller.prayers[index];
                  final isNow = controller.currentPrayer.value == prayer.name;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isNow ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        if(!isNow) BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // Manual check icon
                        GestureDetector(
                          onTap: () => controller.toggleCheck(index),
                          child: SvgPicture.asset(
                            prayer.isChecked ? AppIcons.checkbox_icon : AppIcons.roundbox_icon,
                            width: 24,
                            height: 24,
                            color: isNow ? backgroundColor : textColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Name + Icon
                        Row(
                          children: [
                            CustomText(
                              text: prayer.name,
                              fontWeight: FontWeight.w600,
                              color: isNow ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              prayer.svgIcon,
                              width: 24,
                              height: 24,
                              color: isNow ? backgroundColor : primaryColor,
                            ),
                          ],
                        ),
                        const Spacer(),

                        // Time + "Now" Badge
                        Row(
                          children: [
                            if (isNow) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                margin: const EdgeInsets.only(right: 8),
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
                            ],
                            CustomText(
                              text: prayer.time,
                              color: isNow ? Colors.white : Colors.black,
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Notification Icon
                        GestureDetector(
                          onTap: () => controller.toggleNotification(index),
                          child: Icon(
                            prayer.isNotificationActive
                                ? Icons.notifications_active
                                : Icons.notifications_off,
                            color: isNow
                                ? Colors.white
                                : (prayer.isNotificationActive ? Colors.green : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // DAILY HADITH
              const DailyHadithSection()
            ],
          ),
        );
      }),
    );
  }
}

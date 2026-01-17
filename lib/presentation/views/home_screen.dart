import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/core/routes/app_routes.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';
import 'package:pray_app/presentation/widgets/prayer_time_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    final locCtrl = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Dhaka, Bangladesh'),  // Update with actual location
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              // Open manual location selector (dialog or page)
              // For example: showDialog to input lat/lng
            },
          ),
        ],
      ),
      body: Obx(() {
        if (homeCtrl.prayerTime.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomText(text: homeCtrl.hijriDate.value),
              CustomText(text: homeCtrl.currentPrayer.value),
              CustomText(text: homeCtrl.formatTime(DateTime.now())),  // Current time example
              CustomText(text: 'Time Left ${homeCtrl.timeLeft.value}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrayerTimeCard(name: 'Fajr', time: homeCtrl.formatTime(homeCtrl.prayerTime.value!.fajr), icon: 'fajr_icon.svg'),
                  // Add for Dhuhr, Asr, Maghrib, Isha
                ],
              ),
              // Sections for Prayer Time, Quran, Qibla, Tasbih, Cale (Calendar?)
              // Prohibited times section
              const CustomText(text: 'Prohibited times for prayer'),
              // List dawn, afternoon, evening from homeCtrl.prohibitedTimes
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,  // Home
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed(AppRoutes.home);
              break;
            case 1:
              Get.toNamed(AppRoutes.prayer);
              break;
            case 2:
              Get.toNamed(AppRoutes.quran);
              break;
            case 3:
              Get.toNamed(AppRoutes.tasbih);
              break;
            case 4:
              Get.toNamed(AppRoutes.more);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/home_icon.svg'), label: 'Home'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/prayer_icon.svg'), label: 'Prayer'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/quran_icon.svg'), label: 'Quran'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/tasbih_icon.svg'), label: 'Tasbih'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/more_icon.svg'), label: 'More'),
        ],
      ),
    );
  }
}
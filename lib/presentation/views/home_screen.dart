import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/controllers/location_controller.dart';
import 'package:pray_app/presentation/widgets/homeScreen/bottom_nav_bar.dart';
import '../widgets/homeScreen/home_content.dart';
import 'prayer_screen.dart';
import 'quran_screen.dart';
import 'tasbih_screen.dart';
import 'more_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationCtrl = Get.find<LocationController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                switch (controller.selectedIndex.value) {
                  case 0:
                    return const HomeContent();
                  case 1:
                    return const PrayerScreen();
                  case 2:
                    return const QuranScreen();
                  case 3:
                    return const TasbihScreen();
                  case 4:
                    return const MoreScreen();
                  default:
                    return const HomeContent();
                }
              }),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

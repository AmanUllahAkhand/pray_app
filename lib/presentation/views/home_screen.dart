import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pray_app/presentation/views/prayer_screen.dart';
import 'package:pray_app/presentation/views/quran_screen.dart';
import 'package:pray_app/presentation/views/tasbih_screen.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/home_controller.dart';
import '../widgets/homeScreen/bottom_nav_bar.dart';
import '../widgets/homeScreen/home_content.dart';
import 'more_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ FULL SCREEN BACKGROUND (no SafeArea)
          Positioned.fill(
            child: SvgPicture.asset(
              AppIcons.splashBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Content respects SafeArea
          SafeArea(
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
                        return QuranScreen();
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
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

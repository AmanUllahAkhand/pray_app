import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/core/constants/app_icons.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColor,           // Active item = Red
          unselectedItemColor: textColor,       // Inactive item = Green/Teal
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          items: [
            _buildNavItem(
              iconPath: AppIcons.home,
              label: 'Home'.tr,
              index: 0,
              currentIndex: currentIndex,
            ),
            _buildNavItem(
              iconPath: AppIcons.prayer,
              label: 'Prayer'.tr,
              index: 1,
              currentIndex: currentIndex,
            ),
            _buildNavItem(
              iconPath: AppIcons.quran,
              label: 'Quran'.tr,
              index: 2,
              currentIndex: currentIndex,
            ),
            _buildNavItem(
              iconPath: AppIcons.tasbih,
              label: 'Tasbih'.tr,
              index: 3,
              currentIndex: currentIndex,
            ),
            _buildNavItem(
              iconPath: AppIcons.more,
              label: 'More'.tr,
              index: 4,
              currentIndex: currentIndex,
            ),
          ],
        ),
      );
    });
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
    required int currentIndex,
  }) {
    final isActive = index == currentIndex;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          iconPath,
          width: 26,
          height: 26,
          colorFilter: ColorFilter.mode(
            isActive ? primaryColor : textColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}
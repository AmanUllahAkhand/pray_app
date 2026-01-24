import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/routes/app_routes.dart';
import '../../controllers/home_controller.dart';
import '../custom_text.dart';

class FeatureButtonGrid extends StatelessWidget {
  const FeatureButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeController>();

    final items = [
      _FeatureItem("Prayer Time", AppIcons.prayerTime, 1), // bottom nav index 2
      _FeatureItem("Quran", AppIcons.quranIcon, 2), // bottom nav index 3
      _FeatureItem("Qibla", AppIcons.qiblaIcon, null, route: AppRoutes.qibla),
      _FeatureItem("Tasbih", AppIcons.tasbihIcon, 3), // bottom nav index 4
      _FeatureItem("Calendar", AppIcons.calanderIcon, null, route: AppRoutes.calendar),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return FeatureButtonItem(
            title: item.title,
            icon: item.icon,
            onTap: () {
              if (item.navIndex != null) {
                ctrl.changeTab(item.navIndex!);
              } else if (item.route != null) {
                Get.toNamed(item.route!);
              }
            },
          );
        },
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String icon;
  final int? navIndex; // index of BottomNavBar
  final String? route; // optional route

  _FeatureItem(this.title, this.icon, this.navIndex, {this.route});
}

class FeatureButtonItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const FeatureButtonItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: tranquilColor,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              icon,
              width: 26,
              height: 26,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
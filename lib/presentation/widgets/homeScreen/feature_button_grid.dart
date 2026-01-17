import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../custom_text.dart';

class FeatureButtonGrid extends StatelessWidget {
  const FeatureButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _FeatureItem("Prayer Time", AppIcons.prayerTime),
      _FeatureItem("Quran", AppIcons.quranIcon),
      _FeatureItem("Qibla", AppIcons.qiblaIcon),
      _FeatureItem("Tasbih", AppIcons.tasbihIcon),
      _FeatureItem("Calendar", AppIcons.calanderIcon),
    ];

    return SizedBox(
      height: 110, // enough for icon + title
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
              // handle tap
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

  _FeatureItem(this.title, this.icon);
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
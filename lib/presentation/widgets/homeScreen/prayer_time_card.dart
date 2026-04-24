import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

import '../../../core/constants/app_colors.dart';

class PrayerTimeCard extends StatelessWidget {
  final String name;
  final String time; // e.g. 4:45 AM – 5:25 AM
  final String icon; // SVG path
  final bool isActive;

  const PrayerTimeCard({
    super.key,
    required this.name,
    required this.time,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isActive ? prohibitedColor : backgroundColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Prayer Name
        CustomText(
          text: name,
          color: activeColor,
          fontSize: 13,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
        const SizedBox(height: 6),
        // SVG Icon
        SvgPicture.asset(
          icon,
          width: 28,
          height: 28,
          colorFilter: ColorFilter.mode(
            activeColor,
            BlendMode.srcIn,
          ),
        ),

        const SizedBox(height: 6),

        // Time Range
        CustomText(
          text: time,
          color: activeColor,
          fontSize:8,
          fontWeight:isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ],
    );
  }
}

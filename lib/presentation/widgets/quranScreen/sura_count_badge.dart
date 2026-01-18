import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_icons.dart';
import '../custom_text.dart';


class SuraCountBadge extends StatelessWidget {
  final String count;

  const SuraCountBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// SVG Background
          SvgPicture.asset(
            AppIcons.suraCount,
            width: 42,
            height: 42,
            fit: BoxFit.contain,
          ),

          /// Number in center
          CustomText(
            text: count,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

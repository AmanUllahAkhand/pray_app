import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/custom_text.dart';
import '../../../core/constants/app_colors.dart';

class MoreListTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const MoreListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: CustomText(
                    text: title,
                    fontSize: 14,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: textColor,
                ),
              ],
            ),
          ),

          /// 🔽 Bottom line
          const Divider(
            height: 2,
            thickness: 1,
            color: bashful,
          ),
        ],
      ),
    );
  }
}

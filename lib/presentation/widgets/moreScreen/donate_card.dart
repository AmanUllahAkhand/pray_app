import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pray_app/core/constants/app_colors.dart';

import '../../../core/constants/app_icons.dart';
import '../../controllers/more_controller.dart';
import '../custom_text.dart';

class DonateCard extends GetView<MoreController> {
  const DonateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            AppIcons.more_bgi,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset(AppIcons.donateIcon, height: 70,width: 70,)),
                const SizedBox(height: 12),
                const CustomText(
                  text: "Support Qalam – Spread the Light of Faith",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: backgroundColor,
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CustomText(
                    text: "By supporting Qalam, you help us maintain, improve, and share this app with Muslims around the world.",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: backgroundColor,
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.onDonateTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      foregroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppIcons.donateimage,
                        ),
                        const SizedBox(width: 8),
                        const CustomText(
                          text: "Donate Now",
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../controllers/more_controller.dart';
import '../../core/constants/app_icons.dart';
import '../widgets/custom_text.dart';
import '../widgets/moreScreen/donate_card.dart';
import '../widgets/moreScreen/more_list_tile.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});

  final MoreController controller = Get.put(MoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DonateCard(),
              const SizedBox(height: 24),

              MoreListTile(
                title: "FAQ",
                icon: AppIcons.faq,
                onTap: controller.onFaqTap,
              ),
              MoreListTile(
                title: "Language",
                icon: AppIcons.language,
                onTap: controller.onLanguageTap,
              ),

              const SizedBox(height: 16),
              const CustomText(
                text: "ABOUT APP",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),

              MoreListTile(
                title: "About Us",
                icon: AppIcons.about,
                onTap: controller.onAboutTap,
              ),
              MoreListTile(
                title: "Privacy Policy",
                icon: AppIcons.privacy,
                onTap: controller.onPrivacyTap,
              ),
              MoreListTile(
                title: "Rate Us",
                icon: AppIcons.rate,
                onTap: controller.onRateTap,
              ),
              MoreListTile(
                title: "Share App",
                icon: AppIcons.share,
                onTap: controller.onShareTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

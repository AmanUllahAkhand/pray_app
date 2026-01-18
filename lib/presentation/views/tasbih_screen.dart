import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/tasbih_controller.dart';
import '../widgets/custom_text.dart';

class TasbihScreen extends StatelessWidget {
  TasbihScreen({super.key});

  final TasbihController controller = Get.put(TasbihController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Tasbih'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          /// 🔝 TOP CARD
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
                  () => Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.transparent, // fallback color
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      /// 🔹 SVG BACKGROUND
                      SvgPicture.asset(
                        AppIcons.splashBackground, // your SVG path
                        fit: BoxFit.cover,
                      ),

                      /// 🔹 CENTER CONTENT
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: controller.count.value.toString(),
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: backgroundColor,
                            ),

                            const SizedBox(height: 8),
                            CustomText(
                              text: controller.duas[controller.currentIndex.value]['ar']!,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            ),

                            const SizedBox(height: 6),
                            CustomText(
                              text: controller.duas[controller.currentIndex.value]['en']!,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text:  '${controller.currentIndex.value + 1}/12',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: backgroundColor,
                            ),
                          ],
                        ),
                      ),

                      /// ◀ ▶ Buttons
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.white),
                          onPressed: controller.previousDua,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.white),
                          onPressed: controller.nextDua,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔄 RESET BUTTON
          ElevatedButton(
            onPressed: controller.reset,
            child: const CustomText(
              text: "Reset",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: backgroundColor,
            )
          ),

          const Spacer(),

          /// ➕ PLUS BUTTON (SVG)
          GestureDetector(
            onTap: controller.increment,
            child: SvgPicture.asset(
              AppIcons.tasbihCountBtn,
              width: 200,
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}

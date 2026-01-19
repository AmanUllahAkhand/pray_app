import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/language_controller.dart';
import '../widgets/custom_text.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: 'Choose preferred language',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: controller.languages.length,
          itemBuilder: (_, index) {
            final lang = controller.languages[index];

            return Obx(() {
              final isActive =
                  controller.selectedLanguage.value == lang['code'];

              return GestureDetector(
                onTap: () =>
                    controller.changeLanguage(lang['code']!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bashful,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive
                          ? primaryColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset(
                          isActive
                              ? AppIcons.checkbox_icon
                              : AppIcons.roundbox_icon,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomText(
                          text: lang['title']!,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: SvgPicture.asset(
                          lang['flag']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

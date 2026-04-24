import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';

import '../../core/constants/app_icons.dart';
import '../controllers/support_controller.dart';
import '../widgets/custom_text.dart';


class SupportScreen extends GetView<SupportController> {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const CustomText(
          text: 'Support Qalam',
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Top SVG Card
          Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                /// 🔹 Background SVG
                Positioned.fill(
                  child: SvgPicture.asset(
                    AppIcons.more_bgi,
                    fit: BoxFit.cover,
                  ),
                ),

                /// 🔹 Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcons.donateIcon,
                        height: 70,
                      ),
                      const SizedBox(height: 12),
                      const CustomText(
                        text:
                        'Qalam is free for everyone. Our mission is to make Islamic knowledge, prayer guidance, and spiritual tools easily accessible to all. By supporting Qalam, you help us maintain the app, add new features, and reach Muslims around the world. Every contribution, big or small, is a form of Sadaqah Jariyah — continuous charity that brings spiritual reward.',
                        color: backgroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),


          const SizedBox(height: 24),

            const CustomText(
              text: 'To support us:',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: primaryColor,
            ),

            const SizedBox(height: 12),

            /// 🔹 Support List
            Expanded(
              child: ListView.builder(
                itemCount: controller.supportList.length,
                itemBuilder: (_, index) {
                  final item = controller.supportList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: bashful,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: SvgPicture.asset(
                            item['icon']!,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: item['title']!,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 10,),
                              CustomText(
                                text: item['subtitle']!,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              controller.copyText(item['subtitle']!),
                          child: SvgPicture.asset(
                            AppIcons.copyIcon,
                            height: 22,
                          ),
                        ),
                        const SizedBox(width: 5,)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

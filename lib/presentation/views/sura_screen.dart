import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/sura_controller.dart';
import '../widgets/custom_text.dart';

class SuraScreen extends GetView<SuraController> {
  const SuraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: 'Al-Faatiha',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: menu action
            },
            icon: SvgPicture.asset(
              AppIcons.menuBook,
              height: 22,
              width: 22,
            ),
          ),
        ],

      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/quran_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: const [
                CustomText(
                  text: 'Surah Al-Fatihah',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0A8F79),
                ),
                SizedBox(height: 4),
                CustomText(
                  text: 'Meccan | 7 Ayahs',
                  fontSize: 12,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                CustomText(
                  text: 'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.ayahs.length,
              itemBuilder: (context, index) {
                final ayah = controller.ayahs[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // play action
                            },
                            child: SvgPicture.asset(
                              AppIcons.play,
                              height: 22,
                              width: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              // bookmark action
                            },
                            child: SvgPicture.asset(
                              AppIcons.bookmark,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch, // ⭐ important
                        children: [
                          // Arabic (Right)
                          CustomText(
                            text: ayah['arabic']!,
                            fontSize: 22,
                            textAlign: TextAlign.right,
                          ),

                          const SizedBox(height: 6),

                          // Latin (Left)
                          CustomText(
                            text: ayah['latin']!,
                            fontSize: 13,
                            textAlign: TextAlign.left,
                          ),

                          const SizedBox(height: 4),

                          // Bangla (Left)
                          CustomText(
                            text: ayah['bn']!,
                            fontSize: 13,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

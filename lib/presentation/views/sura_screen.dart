import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

      /// ================= APP BAR =================
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => CustomText(
          text: controller.suraName.value,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        )),
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.menuBook,
              height: 22,
              width: 22,
            ),
          ),
        ],
      ),

      /// ================= BODY =================
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              controller.loadMore();
            }
            return false;
          },

          child: ListView.builder(
            itemCount: controller.ayahs.length +
                (controller.isLoadMore.value ? 1 : 0) +
                1,

            itemBuilder: (context, index) {

              /// ================= BANNER =================
              if (index == 0) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/sura_details.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Surah ${controller.suraName}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0A8F79),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        text:
                        '${controller.revelation} | ${controller.totalAyah} Ayahs',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12),

                      /// Bismillah
                      const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Amiri',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// ================= INDEX FIX =================
              final realIndex = index - 1;

              /// ================= LOADER =================
              if (realIndex == controller.ayahs.length) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final ayah = controller.ayahs[realIndex];

              /// ================= AYAH ITEM =================
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ACTIONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(AppIcons.play, height: 22),
                        const SizedBox(width: 12),
                        SvgPicture.asset(AppIcons.bookmark, height: 20),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// ================= ARABIC =================
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          '${ayah.arabic}  ۝ ${ayah.ayah}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'Amiri',
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// ================= TRANSLITERATION =================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: ayah.transliteration,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// ================= BANGLA =================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: ayah.bangla,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
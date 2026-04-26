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
            onPressed: () {
              controller.arabicOnly.value =
              !controller.arabicOnly.value;
            },
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

        // Use a shared listener to avoid code duplication
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
              controller.loadMore();
            }
            return false;
          },
          child: controller.arabicOnly.value
              ? _buildArabicOnlyMode()
              : _buildNormalMode(),
        );
      }),
    );
  }
  Widget _buildArabicOnlyMode() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildBanner(), // Banner added here
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              controller.ayahs
                  .map((e) => '${e.arabic} ۝ ${e.ayah}')
                  .join('   '),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Amiri',
                height: 2.2,
              ),
            ),
          ),
          // Show loader at bottom during pagination
          if (controller.isLoadMore.value)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildNormalMode() {
    return ListView.builder(
      itemCount: controller.ayahs.length + (controller.isLoadMore.value ? 1 : 0) + 1,
      itemBuilder: (context, index) {

        /// ================= 1. BANNER =================
        if (index == 0) {
          return _buildBanner();
        }

        final realIndex = index - 1;

        /// ================= 2. LOADER =================
        if (realIndex == controller.ayahs.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final ayah = controller.ayahs[realIndex];

        /// ================= 3. AYAH ITEM =================
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
                  SvgPicture.asset(AppIcons.play, height: 22),
                  const SizedBox(width: 12),
                  SvgPicture.asset(AppIcons.bookmark, height: 20),
                ],
              ),

              const SizedBox(height: 12),

              /// ================= ARABIC (Aligned Right) =================
              Align(
                alignment: Alignment.centerRight, // Forces the block to the right
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    '${ayah.arabic} ۝ ${ayah.ayah}',
                    textAlign: TextAlign.right, // Aligns text inside the block to the right
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Amiri',
                      height: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// ================= TRANSLITERATION =================
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: ayah.transliteration,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 4),

              /// ================= BANGLA =================
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: ayah.bangla,
                  fontSize: 13,
                  color: Colors.teal.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildBanner() {
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
            text: 'Surah ${controller.suraName.value}',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xff0A8F79),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: '${controller.revelation.value} | ${controller.totalAyah.value} Ayahs',
            fontSize: 12,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              style: TextStyle(fontSize: 20, fontFamily: 'Amiri'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

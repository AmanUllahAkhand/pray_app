import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../controllers/quran_controller.dart';
import '../widgets/custom_text.dart';
import '../widgets/quranScreen/sura_count_badge.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({super.key});

  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
        ),

        title: const CustomText(
          text: 'Al-Quran',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),

              onTap: () {
                Get.toNamed(AppRoutes.bookmark);
              },

              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color(0xff0E8B72),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [

          /// Search Field
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: TextField(
                onChanged: controller.onSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search by surah name or number',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          /// Sura List Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: 'Sura List',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 100) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.filteredSuraList.length +
                      (controller.isLoadMore.value ? 1 : 0),
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
                  itemBuilder: (context, index) {

                    if (index == controller.filteredSuraList.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final sura = controller.filteredSuraList[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => controller.onSuraTap(sura),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAF1EF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            SuraCountBadge(count: sura.id.toString()),
                            const SizedBox(width: 12),

                            const SizedBox(width: 14),

                            /// Sura Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: sura.nameEn,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    text:
                                    'Verses: ${sura.verses} | ${sura.type}',
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),

                            /// Arabic Name
                            CustomText(
                              text: sura.nameAr,
                              color: Colors.teal,
                              fontFamily: 'Amiri',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
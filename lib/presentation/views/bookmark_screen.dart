import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/bookmark_controller.dart';
import '../widgets/custom_text.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});

  final BookmarkController controller = Get.put(BookmarkController());

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
            color: Colors.black,
          ),
        ),
        title: const CustomText(
          text: 'Bookmarks',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),

      body: Obx(() {

        if (controller.bookmarks.isEmpty) {
          return const Center(
            child: CustomText(
              text: 'No bookmarks added',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.bookmarks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {

            final ayah = controller.bookmarks[index];

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            CustomText(
                              text: ayah.arabic,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),

                            const SizedBox(height: 4),

                            CustomText(
                              text: 'Ayah ${ayah.ayah}',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          controller.removeBookmark(ayah);
                        },
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xff0A8F79),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '${ayah.arabic} ۝ ${ayah.ayah}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Amiri',
                          height: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  CustomText(
                    text: ayah.transliteration,
                    fontSize: 13,
                    color: Colors.black87,
                  ),

                  const SizedBox(height: 8),

                  CustomText(
                    text: ayah.bangla,
                    fontSize: 14,
                    color: const Color(0xff0A8F79),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
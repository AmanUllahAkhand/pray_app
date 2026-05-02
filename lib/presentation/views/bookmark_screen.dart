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

  final BookmarkController controller =
  Get.find<BookmarkController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),

      body: Obx(() {

        if (controller.bookmarks.isEmpty) {

          return const Center(
            child: Text('No bookmarks added'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {

            final ayah = controller.bookmarks[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          ayah.suraName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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

                  const SizedBox(height: 12),

                  Text(
                    ayah.transliteration,
                    style: const TextStyle(fontSize: 13),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    ayah.bangla,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A8F79),
                    ),
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
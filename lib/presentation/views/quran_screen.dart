import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/quran_controller.dart';
import '../widgets/custom_text.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({super.key});

  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Al-Quran',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const CustomText(
                      text:'Search Sura'
                  ),
                  content: TextField(
                    onChanged: controller.onSearch,
                    decoration: const InputDecoration(
                      hintText: 'Type sura name...',
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// SVG Banner
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SvgPicture.asset(
                'assets/svg/quran_banner.svg',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text:'Sura List',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// TableView (ListView)
          Expanded(
            child: Obx(
                  () => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredSuraList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sura = controller.filteredSuraList[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => controller.onSuraTap(sura),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF5F2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          /// Index
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CustomText(
                              text:sura.id.toString(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 12),

                          /// Name & Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:sura.nameEn,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                  text:'Verses: ${sura.verses} | ${sura.type}',
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),

                          /// Arabic Name
                          CustomText(
                            text:sura.nameAr,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/core/constants/app_icons.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class ProhibitedTimesSection extends StatelessWidget {
  const ProhibitedTimesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final data = controller.prohibitedTimes;

      if (data.isEmpty) return const SizedBox.shrink();

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            /// ================= BACKGROUND =================
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SvgPicture.asset(
                  AppIcons.mosqueBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Prohibited times for prayer",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),

                  const SizedBox(height: 10),

                  /// Dynamic rows from API
                  ...data.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _row(
                        title: entry.key,
                        start: entry.value.start,
                        end: entry.value.end,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// ================= ROW =================
  Widget _row({
    required String title,
    required String start,
    required String end,
  }) {
    final startFormatted = _formatToAmPm(start);
    final endFormatted = _formatToAmPm(end);

    final startParts = startFormatted.split(' ');
    final endParts = endFormatted.split(' ');

    return Row(
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        const Spacer(),

        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              /// START TIME
              TextSpan(
                text: '${startParts[0]} ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: startParts.length > 1 ? startParts[1] : '',
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),

              const TextSpan(text: ' - '),

              /// END TIME
              TextSpan(
                text: '${endParts[0]} ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: endParts.length > 1 ? endParts[1] : '',
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ================= FORMAT TIME =================
  String _formatToAmPm(String time24) {
    try {
      final parsed = DateFormat("HH:mm").parse(time24);
      return DateFormat("hh:mm a").format(parsed); // → 05:25 AM
    } catch (e) {
      return time24;
    }
  }
}
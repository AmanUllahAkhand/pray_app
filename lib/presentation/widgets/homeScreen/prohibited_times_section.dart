import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/presentation/controllers/home_controller.dart';

class ProhibitedTimesSection extends StatelessWidget {
  const ProhibitedTimesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      // If you didn't fetch prohibited times yet, show a minimal placeholder
      if (controller.prohibitedTimes.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Prohibited times for prayer",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200, width: 1),
            ),
            child: Column(
              children: [
                _buildProhibitedRow(
                  title: "Dawn (Sunrise period)",
                  time: controller.prohibitedTimes['Dawn'] ?? "05:00 am - 06:00 am",
                  icon: Icons.wb_sunny_outlined,
                ),
                const Divider(height: 24, color: Colors.redAccent),

                _buildProhibitedRow(
                  title: "Afternoon (Sun at zenith)",
                  time: controller.prohibitedTimes['Afternoon'] ?? "12:00 pm - 01:00 pm",
                  icon: Icons.wb_sunny,
                ),
                const Divider(height: 24, color: Colors.redAccent),

                _buildProhibitedRow(
                  title: "Evening (Sunset period)",
                  time: controller.prohibitedTimes['Evening'] ?? "05:00 pm - 06:00 pm",
                  icon: Icons.nights_stay_outlined,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildProhibitedRow({
    required String title,
    required String time,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.redAccent,
          size: 26,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
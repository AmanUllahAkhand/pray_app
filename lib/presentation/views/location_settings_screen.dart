import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/location_settings_controller.dart';
import '../widgets/custom_text.dart';


class LocationSettingsScreen extends StatelessWidget {
  const LocationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LocationSettingsController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const CustomText(
          text: "Location Settings",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: ctrl.saveLocation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const CustomText(
            text: "Save",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text:
              "Please set your location to get the correct prayer, sehri, and iftar times.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),

            /// COUNTRY
            const CustomText(
              text: "Select Country",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 8),

            Obx(() => _dropdown(
              value: ctrl.selectedCountry.value,
              items: ctrl.countries,
              onChanged: (v) {
                ctrl.selectedCountry.value = v!;
                if (!ctrl.isBangladesh) {
                  ctrl.selectedDistrict.value = '';
                }
              },
            )),

            const SizedBox(height: 16),

            /// DISTRICT (ONLY FOR BANGLADESH)
            Obx(() => ctrl.isBangladesh
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Select District",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                _dropdown(
                  value: ctrl.selectedDistrict.value,
                  items: ctrl.districtsBD,
                  onChanged: (v) =>
                  ctrl.selectedDistrict.value = v!,
                ),
              ],
            )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F1EC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: CustomText(
                text: e,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/location_settings_controller.dart';
import '../widgets/custom_text.dart';

class LocationSettingsScreen extends StatelessWidget {
  const LocationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LocationSettingsController());

    return SafeArea(
      child: Scaffold(
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
      
        /// SAVE BUTTON
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
              color: Colors.white,
            ),
          ),
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text:
                  "Please set your location to get the correct prayer, sehri, and iftar times.",
                  fontSize: 14,
                ),
                const SizedBox(height: 20),
      
                /// ================= COUNTRY PICKER =================
                const CustomText(
                  text: "Select Country",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
      
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        ctrl.selectedCountry.value = country.name;
      
                        /// If not Bangladesh → force GPS
                        if (!ctrl.isBangladesh) {
                          ctrl.locationMode.value = LocationMode.gps;
                          ctrl.requestGpsLocation();
                        }
                      },
                    );
                  },
                  child: _pickerField(ctrl.selectedCountry.value),
                ),
      
                /// ================= BANGLADESH OPTIONS =================
                if (ctrl.isBangladesh) ...[
                  const SizedBox(height: 16),
                  const CustomText(
                    text: "Location Method",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
      
                  /// DISTRICT MODE
                  _radioTile(
                    title: "District based (Islamic Foundation)",
                    value: LocationMode.district,
                    group: ctrl.locationMode.value,
                    onChanged: (v) {
                      ctrl.locationMode.value = v!;
                    },
                  ),
      
                  /// GPS MODE
                  _radioTile(
                    title: "GPS based (More accurate)",
                    value: LocationMode.gps,
                    group: ctrl.locationMode.value,
                    onChanged: (v) async {
                      ctrl.locationMode.value = v!;
                      await ctrl.requestGpsLocation(); // 👈 permission popup
                    },
                  ),
      
                  /// DISTRICT DROPDOWN
                  if (ctrl.locationMode.value == LocationMode.district) ...[
                    const SizedBox(height: 12),
                    const CustomText(
                      text: "Select District",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 6),
                    _districtDropdown(ctrl),
                  ],
                ],
      
                /// ================= NON-BD GPS BUTTON =================
                if (!ctrl.isBangladesh) ...[
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: ctrl.requestGpsLocation,
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const CustomText(
                      text: "Use My Current Location",
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= UI HELPERS =================

  Widget _pickerField(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F1EC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: value),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _districtDropdown(LocationSettingsController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F1EC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: ctrl.selectedDistrict.value,
          isExpanded: true,
          items: ctrl.districtsBD
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: CustomText(text: e),
            ),
          )
              .toList(),
          onChanged: (v) => ctrl.selectedDistrict.value = v!,
        ),
      ),
    );
  }

  Widget _radioTile({
    required String title,
    required LocationMode value,
    required LocationMode group,
    required ValueChanged<LocationMode?> onChanged,
  }) {
    return RadioListTile<LocationMode>(
      value: value,
      groupValue: group,
      activeColor: primaryColor,
      onChanged: onChanged,
      title: CustomText(
        text: title,
        fontSize: 14,
      ),
    );
  }
}

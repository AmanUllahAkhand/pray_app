import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../custom_text.dart';

class SehriIftarInfoCard extends StatelessWidget {
  final String sehriEnd;
  final String iftarStart;
  final String remainingSehri;
  final VoidCallback onSehriAlarmTap;
  final VoidCallback onIftarAlarmTap;

  const SehriIftarInfoCard({
    super.key,
    required this.sehriEnd,
    required this.iftarStart,
    required this.remainingSehri,
    required this.onSehriAlarmTap,
    required this.onIftarAlarmTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: tranquilColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildItem(
            title: sehriEnd,
            subtitle: "Today Sehri Last",
            actionText: "Set Alarm",
            onTap: onSehriAlarmTap,
          ),
          _divider(),
          _buildItem(
            title: iftarStart,
            subtitle: "Today Iftar Start",
            actionText: "Set Alarm",
            onTap: onIftarAlarmTap,
          ),
          _divider(),
          _buildItem(
            title: remainingSehri,
            subtitle: "Remaining Sehri",
            actionText: "",
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required String actionText,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: Column(
        children: [
          CustomText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          const SizedBox(height: 6),
          CustomText(
            text: subtitle,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          const SizedBox(height: 6),
          if (actionText.isNotEmpty)
            GestureDetector(
              onTap: onTap,
              child: CustomText(
                text: actionText,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 60,
      width: 1,
      color: explosiveGrey,
    );
  }
}

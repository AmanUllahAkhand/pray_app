import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class PrayerTimeCard extends StatelessWidget {
  final String name;
  final String time;
  final IconData icon;
  final bool isActive;

  const PrayerTimeCard({
    super.key,
    required this.name,
    required this.time,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: isActive ? primaryColor : Colors.white70, size: 28),
        const SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(
            color: isActive ? primaryColor : Colors.white,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: isActive ? primaryColor : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class PrayerTimeCard extends StatelessWidget {
  final String name;
  final String time;
  final String icon;

  const PrayerTimeCard({
    super.key,
    required this.name,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SvgPicture.asset('assets/images/$icon'),
          CustomText(text: name),
          CustomText(text: time),
        ],
      ),
    );
  }
}
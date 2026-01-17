import 'package:flutter/material.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: 'Record Your Prayer')),
      body: const Center(child: CustomText(text: 'Prayer recording feature here')),
    );
  }
}
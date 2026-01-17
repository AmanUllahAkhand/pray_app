import 'package:flutter/material.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: 'Quran')),
      body: const Center(child: CustomText(text: 'Quran reader here')),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: 'More')),
      body: const Center(child: CustomText(text: 'Calendar and other features here')),
    );
  }
}
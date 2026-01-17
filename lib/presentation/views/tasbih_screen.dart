import 'package:flutter/material.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(text: 'Tasbih Counter')),
      body: const Center(child: CustomText(text: 'Tasbih counter feature here')),
    );
  }
}
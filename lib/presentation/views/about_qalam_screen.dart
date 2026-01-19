import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../controllers/about_qalam_controller.dart';
import '../widgets/custom_text.dart';

class AboutQalamScreen extends GetView<AboutQalamController> {
  const AboutQalamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Qalam"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            /// Logo
            SvgPicture.asset(
              AppIcons.appLogo,
              height: 90,
            ),

            const SizedBox(height: 24),

            /// Our Mission
            _sectionTitle("Our Mission"),
            const SizedBox(height: 8),
            const CustomText(
              text:
                  "Our mission is to make Islamic knowledge, guidance, and spiritual tools accessible to every Muslim, everywhere. We aim to empower users to strengthen their faith, practice daily worship with ease, and grow spiritually in a modern, user-friendly environment.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            /// About Us
            _sectionTitle("About Us"),
            const SizedBox(height: 8),
            const CustomText(
              text:
                  "Qalam is your all-in-one Islamic companion, designed to help Muslims connect with their faith effortlessly. From reading the Holy Quran, tracking prayer times, finding the Qibla direction, to counting daily dhikr, Qalam brings everything you need in one simple, easy-to-use app. Our mission is to make Islamic knowledge and spiritual tools accessible to everyone, everywhere.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            /// Contact Us
            _sectionTitle("Contact Us"),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: primaryColor,
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: 120,
          color: primaryColor,
        ),
      ],
    );
  }
}

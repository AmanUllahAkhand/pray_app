import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import 'package:pray_app/core/constants/app_icons.dart';
import 'package:pray_app/core/routes/app_routes.dart';
import 'package:pray_app/presentation/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.offNamed(AppRoutes.home));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background SVG
          SvgPicture.asset(
            AppIcons.splashBackground,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // App Name Text
          const CustomText(
            text: 'Pray App',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: backgroundColor,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pray_app/core/constants/app_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: textColor, fontSize: 16),
    // Add more styles as needed
  ),
  // Define other theme properties
);
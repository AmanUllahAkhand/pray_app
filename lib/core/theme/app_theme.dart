import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
final ThemeData appTheme = ThemeData(
  useMaterial3: true, // <-- enable Material 3
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryColor,
  fontFamily: 'Roboto', // optional: default font
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);

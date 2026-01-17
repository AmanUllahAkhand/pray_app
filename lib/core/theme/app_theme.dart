// import 'package:flutter/material.dart';
// import 'package:pray_app/core/constants/app_colors.dart';
//
// final ThemeData appTheme = ThemeData(
//   useMaterial3: true, // <-- enable Material 3
//   colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
//   primaryColor: primaryColor,
//   scaffoldBackgroundColor: backgroundColor,
//   textTheme: const TextTheme(
//     bodyLarge: TextStyle(color: textColor, fontSize: 16),
//     // Add more styles as needed
//   ),
//   // Define other theme properties
// );

import 'package:flutter/material.dart';

final Color primaryColor = Colors.teal; // example
final Color backgroundColor = Colors.white; // example

final ThemeData appTheme = ThemeData(
  useMaterial3: true, // <-- enable Material 3
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
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

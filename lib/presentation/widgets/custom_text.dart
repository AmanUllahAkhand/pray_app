import 'package:flutter/material.dart';
import 'package:pray_app/core/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final FontStyle fontStyle;
  final TextDecoration decoration;
  final Color decorationColor;
  final double? height; // added line height

  const CustomText({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.maxLines,
    this.color = Colors.black,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Poppins',
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
    this.decorationColor = Colors.black,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        height: height,
      ).merge(textStyle),
    );
  }
}
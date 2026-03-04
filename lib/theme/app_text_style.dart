import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class AppTextStyle {
  static TextStyle getDisplayLarge({Color color = Colors.black}) => TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
    letterSpacing: -1.0,
  );

  static TextStyle getDisplayMedium({Color color = Colors.black}) => TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
    letterSpacing: -0.5,
  );

  static TextStyle getHeadlineLarge({Color color = Colors.black}) => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
  );

  static TextStyle getHeadlineMedium({Color color = Colors.black}) => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
  );

  static TextStyle getTitleLarge({Color color = Colors.black}) => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightManager.medium,
    color: color,
  );

  static TextStyle getBodyLarge({Color color = Colors.black}) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightManager.regular,
    color: color,
  );

  static TextStyle getBodyMedium({Color color = Colors.black}) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightManager.regular,
    color: color,
  );

  static TextStyle getMonospace({
    Color color = Colors.black,
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeightManager.regular,
    double letterSpacing = 0.0,
  }) => TextStyle(
    fontFamily: 'monospace',
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
  );
}

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
  /// Nếu [color] == null → không set color → text sẽ kế thừa từ DefaultTextStyle / Theme.
  /// Điều này giúp dark mode hoạt động tự động.

  static TextStyle getDisplayLarge({Color? color}) => TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
    letterSpacing: -1.0,
  );

  static TextStyle getDisplayMedium({Color? color}) => TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
    letterSpacing: -0.5,
  );

  static TextStyle getHeadlineLarge({Color? color}) => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
  );

  static TextStyle getHeadlineMedium({Color? color}) => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeightManager.bold,
    color: color,
  );

  static TextStyle getTitleLarge({Color? color}) => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightManager.medium,
    color: color,
  );

  static TextStyle getBodyLarge({Color? color}) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightManager.regular,
    color: color,
  );

  static TextStyle getBodyMedium({Color? color}) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightManager.regular,
    color: color,
  );

  static TextStyle getMonospace({
    Color? color,
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

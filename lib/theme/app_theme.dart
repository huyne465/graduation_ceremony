import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
      ),
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      textTheme: GoogleFonts.spaceGroteskTextTheme().copyWith(
        displayLarge: GoogleFonts.anton(color: AppColors.secondary),
        displayMedium: GoogleFonts.anton(color: AppColors.secondary),
        displaySmall: GoogleFonts.anton(color: AppColors.secondary),
        headlineLarge: GoogleFonts.anton(color: AppColors.secondary),
        headlineMedium: GoogleFonts.anton(color: AppColors.secondary),
        headlineSmall: GoogleFonts.anton(color: AppColors.secondary),
        titleLarge: GoogleFonts.anton(color: AppColors.secondary),
        titleMedium: GoogleFonts.spaceGrotesk(color: AppColors.textMain),
        bodyLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textMain,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: GoogleFonts.spaceGrotesk(color: AppColors.textMain),
      ),
    );
  }
}

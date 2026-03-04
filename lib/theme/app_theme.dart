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
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
          ).copyWith(
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

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dmBackground,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.dark,
          ).copyWith(
            primary: AppColors.primary,
            secondary: AppColors.dmTextSecondary,
            surface: AppColors.dmSurface,
          ),
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      textTheme: GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            displayMedium: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            displaySmall: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            headlineLarge: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            headlineMedium: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            headlineSmall: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            titleLarge: GoogleFonts.anton(color: AppColors.dmTextPrimary),
            titleMedium: GoogleFonts.spaceGrotesk(
              color: AppColors.dmTextPrimary,
            ),
            bodyLarge: GoogleFonts.spaceGrotesk(
              color: AppColors.dmTextPrimary,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: GoogleFonts.spaceGrotesk(
              color: AppColors.dmTextPrimary,
              fontWeight: FontWeight.w400,
            ),
            labelLarge: GoogleFonts.spaceGrotesk(
              color: AppColors.dmTextPrimary,
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ──
  static const Color primary = Color(0xFFD90429); // Deep Red
  static const Color secondary = Color(0xFF000000); // Solid Black
  static const Color accent = Color(0xFFFFFFFF); // White

  // ── Light Mode ──
  static const Color backgroundLight = Color(0xFFEEF2F6);
  static const Color backgroundDark = Color(0xFFE2E8F0); // slate-200 (scaffold)
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textMain = Color(0xFF0F172A);

  // ── Dark Mode ──
  static const Color dmBackground = Color(0xFF0A0E17); // Near-black blue
  static const Color dmSurface = Color(0xFF111827); // Card / section bg
  static const Color dmSurfaceAlt = Color(0xFF1A2235); // Slightly lighter
  static const Color dmBorder = Color(0xFF1F2937); // Borders
  static const Color dmTextPrimary = Color(0xFFE5E7EB); // Primary text
  static const Color dmTextSecondary = Color(0xFF9CA3AF); // Secondary text

  // ── Cyberpunk Hover ──
  static const Color neonBlue = Color(0xFF00F0FF);
  static const Color neonRed = Color(0xFFFF003C);
}

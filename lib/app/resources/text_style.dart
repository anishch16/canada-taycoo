import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    displayMedium: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    displaySmall: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineLarge: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineMedium: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineSmall: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleLarge: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleMedium: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleSmall: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodyLarge: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodyMedium: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodySmall: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelLarge: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelMedium: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelSmall: GoogleFonts.manrope(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
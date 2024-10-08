import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    displayMedium: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    displaySmall: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineLarge: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineMedium: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    headlineSmall: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleLarge: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleMedium: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    titleSmall: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodyLarge: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodyMedium: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bodySmall: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelLarge: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelMedium: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    labelSmall: GoogleFonts.nanumMyeongjo(
      textStyle: const TextStyle(
        letterSpacing: 0.72,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
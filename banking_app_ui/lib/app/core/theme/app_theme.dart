import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return _buildTheme(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColor.white,
      colorScheme: const ColorScheme.light(
        primary: AppColor.accentBlue,
        secondary: AppColor.paymentsMint,
        surface: AppColor.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF232427),
      colorScheme: const ColorScheme.dark(
        primary: AppColor.heroGlow,
        secondary: AppColor.paymentsMint,
        surface: Color(0xFF2B2E34),
      ),
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required ColorScheme colorScheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: GoogleFonts.roboto().fontFamily,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightSeed = Color(0xFF5FB8FF);
  static const _darkSeed = Color(0xFF0B2D5C);

  static ThemeData light() {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _lightSeed,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFEAF6FF),
      textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _darkSeed,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1630),
      textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF20BEE6);
  static const Color primaryDark = Color(0xFF1AA4C7);
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textLight = Color(0xFFF5F7FA);
  static const Color liveRed = Color(0xFFFF5C5C);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF151A1E);

  static LinearGradient backgroundGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1B2430),
          Color(0xFF16202B),
          Color(0xFF0F1A24),
        ],
      );
    }
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFF6D2B8),
        Color(0xFFAED4F3),
        Color(0xFFF1C7AA),
        Color(0xFFB7DDF6),
        Color(0xFF9CCAEF),
      ],
      stops: [0.0, 0.28, 0.52, 0.72, 1.0],
    );
  }

  static LinearGradient glassGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1E2A38).withAlpha(200),
          const Color(0xFF18222E).withAlpha(180),
        ],
      );
    }
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFFFFFFFF).withAlpha(220),
        const Color(0xFFEAF3FA).withAlpha(210),
      ],
    );
  }

  static Color glassBorder(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const Color(0xFF6D7A8A).withAlpha(90);
    }
    return const Color(0xFFFFFFFF).withAlpha(180);
  }

  static Color mutedIcon(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const Color(0xFFC6D2DF).withAlpha(200);
    }
    return const Color(0xFF1E1E1E).withAlpha(170);
  }

  static Color pillBackground(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const Color(0xFF223040).withAlpha(210);
    }
    return const Color(0xFFFFFFFF).withAlpha(190);
  }

  static Color chipBackground(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const Color(0xFF1C2631).withAlpha(220);
    }
    return const Color(0xFFF1F6FB).withAlpha(220);
  }
}

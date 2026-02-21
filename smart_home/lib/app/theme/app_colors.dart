import 'package:flutter/material.dart';

class AppColors {
  // Main background (lighter than cards in the new design)
  static const Color background = Color(0xFF262626); // Lighter dark gray

  // Cards (darker than background)
  static const Color cardGlass = Color(0x33000000); // Darker glass
  static const Color cardGlassSolid = Color(0xFF1E1E1E); // Darker solid

  static const Color primaryText = Colors.white;
  static const Color secondaryText = Color(0xFFAAAAAA);

  static const Color accentGreen = Color(0xFF88C86A);
  static const Color accentRed = Color(0xFFC35454);
  static const Color accentBlue = Color(0xFF5BA4E6);
  static const Color accentOrange = Color(0xFFE6885B);

  // Specific card backgrounds (very dark)
  static const Color lockCard = Color(0xFF1C201E);
  static const Color thermostatCard = Color(0xFF1C1E20);
  static const Color vacuumCard = Color(0xFF20201C);
  static const Color leakCard = Color(0xFF1C2020);

  // Bottom Nav (slightly lighter or matches background)
  static const Color bottomNavBackground = Color(0xAA2A2A2A);
}

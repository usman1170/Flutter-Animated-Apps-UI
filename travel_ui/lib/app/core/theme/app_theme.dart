import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'SF Pro Display',
      scaffoldBackgroundColor: AppColor.background,
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.primary,
        surface: AppColor.surface,
      ),
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.background,
        elevation: 0,
      ),
    );
  }
}

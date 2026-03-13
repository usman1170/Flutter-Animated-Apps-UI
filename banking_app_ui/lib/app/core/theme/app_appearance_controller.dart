import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppAppearance { system, light, dark }

class AppAppearanceController extends GetxController {
  AppAppearanceController(this._prefs);

  static const _preferenceKey = 'app_appearance';

  final SharedPreferences _prefs;

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  AppAppearance get appearance {
    switch (themeMode.value) {
      case ThemeMode.light:
        return AppAppearance.light;
      case ThemeMode.dark:
        return AppAppearance.dark;
      case ThemeMode.system:
        return AppAppearance.system;
    }
  }

  Future<void> init() async {
    final value = _prefs.getString(_preferenceKey);
    themeMode.value = switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> updateAppearance(AppAppearance appearance) async {
    final nextMode = switch (appearance) {
      AppAppearance.light => ThemeMode.light,
      AppAppearance.dark => ThemeMode.dark,
      AppAppearance.system => ThemeMode.system,
    };

    if (themeMode.value == nextMode) {
      return;
    }

    themeMode.value = nextMode;
    await _prefs.setString(_preferenceKey, nextMode.name);
  }
}

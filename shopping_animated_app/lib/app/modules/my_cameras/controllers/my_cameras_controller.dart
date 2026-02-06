import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCamerasController extends GetxController {
  final selectedTab = 0.obs;
  final selectedBottomIndex = 0.obs;
  final isDarkTheme = false.obs;

  final cameraTabs = <String>['Camera 01', 'Camera 02', 'Camera 03'].obs;

  void setTab(int index) {
    selectedTab.value = index;
  }

  void setBottomIndex(int index) {
    selectedBottomIndex.value = index;
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }
}

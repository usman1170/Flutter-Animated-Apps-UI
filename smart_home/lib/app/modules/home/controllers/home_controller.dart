import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentCategoryIndex = 0.obs;
  final categories = ['Doorbell', 'Living room', 'Kitchen', 'Backyard'].obs;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentCategoryIndex.value);

    ever(currentCategoryIndex, (int index) {
      if (pageController.hasClients && pageController.page?.round() != index) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  final isSmartLockOn = true.obs;
  final isThermostatOn = true.obs;
  final isVacuumOn = true.obs;
  final isWaterLeakOn = true.obs;

  void toggleSmartLock() => isSmartLockOn.value = !isSmartLockOn.value;
  void toggleThermostat() => isThermostatOn.value = !isThermostatOn.value;
  void toggleVacuum() => isVacuumOn.value = !isVacuumOn.value;
  void toggleWaterLeak() => isWaterLeakOn.value = !isWaterLeakOn.value;
}

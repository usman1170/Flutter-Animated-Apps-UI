import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void onInit() {
    super.onInit();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 2600), () {
      Get.offAllNamed(Routes.LOCATION);
    });
  }

  @override
  void onClose() {
    animation.dispose();
    super.onClose();
  }
}

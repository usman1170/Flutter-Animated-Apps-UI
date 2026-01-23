import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/location_service.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animation;
  final LocationService _locationService = LocationService();

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
    Future.delayed(const Duration(milliseconds: 2600), () async {
      final status = await _locationService.checkPermission();
      Get.offAllNamed(
        status == LocationStatus.granted ? Routes.HOME : Routes.LOCATION,
      );
    });
  }

  @override
  void onClose() {
    animation.dispose();
    super.onClose();
  }
}

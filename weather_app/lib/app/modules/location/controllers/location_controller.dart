import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/services/location_service.dart';
import '../../../routes/app_pages.dart';

class LocationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  LocationController({LocationService? locationService})
      : _locationService = locationService ?? LocationService();

  final LocationService _locationService;
  final status = LocationStatus.denied.obs;
  final isChecking = false.obs;
  late final AnimationController pulseController;

  @override
  void onInit() {
    super.onInit();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    isChecking.value = true;
    status.value = await _locationService.checkPermission();
    isChecking.value = false;
    if (status.value == LocationStatus.granted) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.offAllNamed(Routes.HOME);
      });
    }
  }

  Future<void> requestPermission() async {
    if (status.value == LocationStatus.deniedForever) {
      await Geolocator.openAppSettings();
    }
    if (status.value == LocationStatus.serviceDisabled) {
      await Geolocator.openLocationSettings();
    }
    await _checkPermission();
  }

  @override
  void onClose() {
    pulseController.dispose();
    super.onClose();
  }
}

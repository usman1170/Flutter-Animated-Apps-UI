import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/city_models.dart';
import '../../../data/services/location_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/weather_service.dart';
import '../../../routes/app_pages.dart';

class LocationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  LocationController({
    LocationService? locationService,
    WeatherService? weatherService,
    StorageService? storageService,
  }) : _locationService = locationService ?? LocationService(),
       _weatherService = weatherService ?? WeatherService(),
       _storageService = storageService ?? StorageService();

  final LocationService _locationService;
  final WeatherService _weatherService;
  final StorageService _storageService;

  final status = LocationStatus.denied.obs;
  final isChecking = false.obs;
  final isSearching = false.obs;
  final query = ''.obs;
  final results = <CityLocation>[].obs;
  final saved = <CityLocation>[].obs;

  late final AnimationController pulseController;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _loadSaved();
    _checkPermission(navigate: false);
  }

  Future<void> _loadSaved() async {
    saved.value = await _storageService.loadCities();
  }

  Future<void> _checkPermission({required bool navigate}) async {
    isChecking.value = true;
    status.value = await _locationService.checkPermission();
    isChecking.value = false;
    if (navigate && status.value == LocationStatus.granted) {
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
    await _checkPermission(navigate: true);
  }

  Future<void> searchCity(String value) async {
    query.value = value;
    if (value.trim().isEmpty) {
      results.clear();
      return;
    }
    isSearching.value = true;
    try {
      results.value = await _weatherService.searchCities(value.trim());
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> selectCity(CityLocation city) async {
    Get.offAllNamed(Routes.HOME, arguments: {'city': city});
  }

  Future<void> removeCity(CityLocation city) async {
    await _storageService.removeCity(city);
    await _loadSaved();
  }

  @override
  void onClose() {
    pulseController.dispose();
    searchController.dispose();
    super.onClose();
  }
}

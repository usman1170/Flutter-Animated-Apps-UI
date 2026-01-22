import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/location_models.dart';
import '../../../data/models/weather_models.dart';
import '../../../data/services/location_service.dart';
import '../../../data/services/weather_service.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/weather_kind.dart';

class HomeController extends GetxController {
  HomeController({
    WeatherService? weatherService,
    LocationService? locationService,
  })  : _weatherService = weatherService ?? WeatherService(),
        _locationService = locationService ?? LocationService();

  final WeatherService _weatherService;
  final LocationService _locationService;

  final weather = Rxn<WeatherResponse>();
  final location = Rxn<LocationInfo>();
  final airQuality = Rxn<AirQuality>();
  final isLoading = true.obs;
  final error = ''.obs;
  final kind = WeatherKind.sunnyDay.obs;

  @override
  void onInit() {
    super.onInit();
    loadWeather();
  }

  Future<void> loadWeather() async {
    isLoading.value = true;
    error.value = '';

    final status = await _locationService.checkPermission();
    if (status != LocationStatus.granted) {
      isLoading.value = false;
      Get.offAllNamed(Routes.LOCATION);
      return;
    }

    try {
      final position = await _locationService.getCurrentPosition();
      final results = await Future.wait([
        _weatherService.fetchWeather(
          lat: position.latitude,
          lon: position.longitude,
        ),
        _weatherService.fetchLocationName(
          lat: position.latitude,
          lon: position.longitude,
        ),
        _weatherService.fetchAirQuality(
          lat: position.latitude,
          lon: position.longitude,
        ),
      ]);

      weather.value = results[0] as WeatherResponse;
      location.value = results[1] as LocationInfo;
      airQuality.value = results[2] as AirQuality?;
      _updateThemeAndKind();
    } catch (err) {
      error.value = 'Unable to load forecast. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateThemeAndKind() {
    final data = weather.value;
    if (data == null) return;
    final current = data.current;
    final isDay = current.dt >= current.sunrise && current.dt < current.sunset;
    Get.changeThemeMode(isDay ? ThemeMode.light : ThemeMode.dark);

    final main = current.weather.isNotEmpty
        ? current.weather.first.main.toLowerCase()
        : '';

    if (main.contains('rain') || main.contains('drizzle')) {
      kind.value = WeatherKind.rain;
    } else if (main.contains('fog') || main.contains('mist')) {
      kind.value = WeatherKind.fog;
    } else if (main.contains('cloud')) {
      kind.value = isDay ? WeatherKind.cloudyDay : WeatherKind.cloudyNight;
    } else {
      kind.value = isDay ? WeatherKind.sunnyDay : WeatherKind.clearNight;
    }
  }
}

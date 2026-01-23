import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/location_models.dart';
import '../../../data/models/weather_models.dart';
import '../../../data/models/city_models.dart';
import '../../../data/services/location_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/services/weather_service.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/weather_kind.dart';

class HomeController extends GetxController {
  HomeController({
    WeatherService? weatherService,
    LocationService? locationService,
    StorageService? storageService,
  }) : _weatherService = weatherService ?? WeatherService(),
       _locationService = locationService ?? LocationService(),
       _storageService = storageService ?? StorageService();

  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  final weather = Rxn<WeatherResponse>();
  final location = Rxn<LocationInfo>();
  final airQuality = Rxn<AirQuality>();
  final savedCities = <CityLocation>[].obs;
  final isLoading = true.obs;
  final isRefreshing = false.obs;
  final error = ''.obs;
  final kind = WeatherKind.clearDay.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSaved();
    final args = Get.arguments as Map<String, dynamic>?;
    final city = args?['city'] as CityLocation?;
    if (city != null) {
      loadWeatherForCity(city);
    } else {
      loadWeather();
    }
  }

  @override
  void onReady() {
    super.onReady();
    final args = Get.arguments as Map<String, dynamic>?;
    final city = args?['city'] as CityLocation?;
    if (city != null) {
      loadWeatherForCity(city);
    }
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
      await _loadSaved();
      _updateThemeAndKind();
    } catch (err) {
      error.value = 'Unable to load forecast. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshWeather() async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;
    error.value = '';
    try {
      final city = currentCity();
      if (city != null) {
        await loadWeatherForCity(city);
      } else {
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
        await _loadSaved();
        _updateThemeAndKind();
      }
    } catch (err) {
      error.value = 'Unable to refresh forecast.';
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> loadWeatherForCity(
    CityLocation city, {
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      isLoading.value = true;
    }
    error.value = '';
    try {
      final results = await Future.wait([
        _weatherService.fetchWeather(lat: city.lat, lon: city.lon),
        _weatherService.fetchLocationName(lat: city.lat, lon: city.lon),
        _weatherService.fetchAirQuality(lat: city.lat, lon: city.lon),
      ]);
      weather.value = results[0] as WeatherResponse;
      location.value = results[1] as LocationInfo;
      airQuality.value = results[2] as AirQuality?;
      await _loadSaved();
      _updateThemeAndKind();
    } catch (err) {
      error.value = 'Unable to load forecast. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void changeLocation() {
    Get.toNamed(Routes.LOCATION);
  }

  Future<void> _loadSaved() async {
    savedCities.value = await _storageService.loadCities();
  }

  CityLocation? currentCity() {
    final loc = location.value;
    final data = weather.value;
    if (loc == null || data == null) return null;
    return CityLocation(
      name: loc.city,
      country: loc.country,
      lat: data.lat,
      lon: data.lon,
    );
  }

  bool isCurrentSaved() {
    final city = currentCity();
    if (city == null) return false;
    return savedCities.any((c) => c.lat == city.lat && c.lon == city.lon);
  }

  Future<void> saveCurrentCity() async {
    final city = currentCity();
    if (city == null) return;
    await _storageService.saveCity(city);
    await _loadSaved();
  }

  void _updateThemeAndKind() {
    final data = weather.value;
    if (data == null) return;
    final current = data.current;
    var isDay = current.dt >= current.sunrise && current.dt < current.sunset;
    if (current.weather.isNotEmpty) {
      final icon = current.weather.first.icon;
      if (icon.endsWith('n')) isDay = false;
      if (icon.endsWith('d')) isDay = true;
    }
    Get.changeThemeMode(isDay ? ThemeMode.light : ThemeMode.dark);

    final main = current.weather.isNotEmpty
        ? current.weather.first.main.toLowerCase()
        : '';

    if (main.contains('thunder')) {
      kind.value = WeatherKind.thunderstorm;
    } else if (main.contains('snow')) {
      kind.value = WeatherKind.snow;
    } else if (main.contains('rain') || main.contains('drizzle')) {
      kind.value = WeatherKind.rain;
    } else if (main.contains('fog') || main.contains('mist')) {
      kind.value = WeatherKind.fog;
    } else if (main.contains('cloud')) {
      kind.value = isDay ? WeatherKind.cloudyDay : WeatherKind.cloudyNight;
    } else {
      kind.value = isDay ? WeatherKind.clearDay : WeatherKind.clearNight;
    }
  }
}

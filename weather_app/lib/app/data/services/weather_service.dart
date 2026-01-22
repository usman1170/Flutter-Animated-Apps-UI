import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/location_models.dart';
import '../models/weather_models.dart';

class WeatherService {
  static const _oneCallBase = 'https://api.openweathermap.org/data/3.0/onecall';
  static const _geoBase = 'https://api.openweathermap.org/geo/1.0/reverse';
  static const _airBase =
      'https://api.openweathermap.org/data/2.5/air_pollution';

  String get _apiKey => dotenv.env['WEATHER_API_KEY'] ?? '';

  Future<LocationInfo> fetchLocationName({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse('$_geoBase?lat=$lat&lon=$lon&limit=1&appid=$_apiKey');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch location info');
    }
    final decoded = json.decode(response.body) as List<dynamic>;
    if (decoded.isEmpty) {
      return LocationInfo(city: 'Unknown', country: '');
    }
    return LocationInfo.fromJson(decoded.first as Map<String, dynamic>);
  }

  Future<WeatherResponse> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      '$_oneCallBase?lat=$lat&lon=$lon&units=metric&appid=$_apiKey',
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather');
    }
    log("[WeatherData] ${response.body}");
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    return WeatherResponse.fromJson(decoded);
  }

  Future<AirQuality?> fetchAirQuality({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse('$_airBase?lat=$lat&lon=$lon&appid=$_apiKey');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    }
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final list = decoded['list'] as List<dynamic>?;
    if (list == null || list.isEmpty) {
      return null;
    }
    return AirQuality.fromJson(list.first as Map<String, dynamic>);
  }
}

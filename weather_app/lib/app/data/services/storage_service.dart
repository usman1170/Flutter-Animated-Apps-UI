import 'package:hive/hive.dart';

import '../models/city_models.dart';

class StorageService {
  static const _boxName = 'saved_cities';

  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return Hive.openBox(_boxName);
  }

  Future<List<CityLocation>> loadCities() async {
    final box = await _openBox();
    return box.values
        .map((e) => CityLocation.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveCity(CityLocation city) async {
    final box = await _openBox();
    final exists = box.values.any((e) {
      final map = Map<String, dynamic>.from(e);
      return map['lat'] == city.lat && map['lon'] == city.lon;
    });
    if (!exists) {
      await box.add(city.toJson());
    }
  }

  Future<void> removeCity(CityLocation city) async {
    final box = await _openBox();
    final keys = box.keys.toList();
    for (final key in keys) {
      final map = Map<String, dynamic>.from(box.get(key));
      if (map['lat'] == city.lat && map['lon'] == city.lon) {
        await box.delete(key);
      }
    }
  }
}

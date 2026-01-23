import 'package:get/get.dart';

import '../../../data/models/weather_models.dart';
import '../../../utils/weather_kind.dart';

class ForecastDetailController extends GetxController {
  late final List<DailyWeather> daily;
  late final String locationLabel;
  late final WeatherKind kind;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    daily = (args['daily'] as List<dynamic>? ?? [])
        .cast<DailyWeather>();
    locationLabel = args['location'] as String? ?? 'Forecast';
    kind = args['kind'] as WeatherKind? ?? WeatherKind.clearDay;
  }
}

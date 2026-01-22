import 'package:get/get.dart';

import '../../../data/models/weather_models.dart';

class ForecastDetailController extends GetxController {
  late final List<DailyWeather> daily;
  late final String locationLabel;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    daily = (args['daily'] as List<dynamic>? ?? [])
        .cast<DailyWeather>();
    locationLabel = args['location'] as String? ?? 'Forecast';
  }
}

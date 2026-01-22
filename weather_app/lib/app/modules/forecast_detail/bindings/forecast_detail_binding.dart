import 'package:get/get.dart';

import '../controllers/forecast_detail_controller.dart';

class ForecastDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForecastDetailController>(() => ForecastDetailController());
  }
}

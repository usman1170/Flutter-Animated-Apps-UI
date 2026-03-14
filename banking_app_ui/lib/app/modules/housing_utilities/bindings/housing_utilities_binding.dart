import 'package:get/get.dart';

import '../controllers/housing_utilities_controller.dart';

class HousingUtilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HousingUtilitiesController>(() => HousingUtilitiesController());
  }
}

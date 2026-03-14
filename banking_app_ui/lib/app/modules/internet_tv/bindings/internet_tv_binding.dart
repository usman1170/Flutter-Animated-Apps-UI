import 'package:get/get.dart';

import '../controllers/internet_tv_controller.dart';

class InternetTvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetTvController>(() => InternetTvController());
  }
}

import 'package:get/get.dart';

import '../controllers/my_cameras_controller.dart';

class MyCamerasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCamerasController>(
      () => MyCamerasController(),
    );
  }
}

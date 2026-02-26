import 'package:get/get.dart';

import '../../lobby/controllers/lobby_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LobbyController>(
      () => LobbyController(),
    );
  }
}

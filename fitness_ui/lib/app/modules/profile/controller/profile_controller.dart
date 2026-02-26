import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isGoalMode = false.obs;

  void toggleGoalMode(bool mode) {
    isGoalMode.value = mode;
  }
}

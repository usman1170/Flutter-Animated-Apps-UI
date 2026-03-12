import 'package:get/get.dart';

class TabsController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    if (index == 0) {
      currentIndex.value = 0;
      return;
    }
    currentIndex.value = currentIndex.value == index ? 0 : index;
  }

  void closeSheet() {
    currentIndex.value = 0;
  }
}

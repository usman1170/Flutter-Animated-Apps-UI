import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 3.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

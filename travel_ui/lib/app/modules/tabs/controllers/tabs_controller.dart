import 'package:get/get.dart';

class TabsController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void onTabChanged(int index) {
    selectedIndex.value = index;
  }
}

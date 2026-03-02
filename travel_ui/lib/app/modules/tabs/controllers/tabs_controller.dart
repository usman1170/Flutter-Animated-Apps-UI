import 'package:get/get.dart';

class TabsController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isBottomBarVisible = true.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onTabChanged(int index) {
    changeTab(index);
  }

  void showBottomBar() {
    if (!isBottomBarVisible.value) {
      isBottomBarVisible.value = true;
      update();
    }
  }

  void hideBottomBar() {
    if (isBottomBarVisible.value) {
      isBottomBarVisible.value = false;
      update();
    }
  }
}

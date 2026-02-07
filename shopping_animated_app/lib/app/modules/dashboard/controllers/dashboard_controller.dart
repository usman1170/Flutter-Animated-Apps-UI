import 'package:get/get.dart';

class DashboardController extends GetxController {
  final tabIndex = 0.obs;
  final homeChipIndex = 0.obs;
  final libraryChipIndex = 0.obs;

  void setTab(int index) {
    if (tabIndex.value == index) return;
    tabIndex.value = index;
  }

  void setHomeChip(int index) {
    homeChipIndex.value = index;
  }

  void setLibraryChip(int index) {
    libraryChipIndex.value = index;
  }
}

import 'package:get/get.dart';

class DashboardController extends GetxController {
  final tabIndex = 0.obs;
  final homeChipIndex = 0.obs;
  final libraryChipIndex = 0.obs;

  final offlineMode = false.obs;
  final highQualityStreaming = true.obs;
  final explicitFilter = false.obs;
  final crossfade = true.obs;
  final cellularDownload = false.obs;
  final volumeBoost = 0.6.obs;
  final sleepTimer = 30.obs;

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

  void toggleOfflineMode() => offlineMode.toggle();
  void toggleHighQuality() => highQualityStreaming.toggle();
  void toggleExplicitFilter() => explicitFilter.toggle();
  void toggleCrossfade() => crossfade.toggle();
  void toggleCellularDownload() => cellularDownload.toggle();

  void setVolumeBoost(double value) {
    volumeBoost.value = value.clamp(0, 1);
  }

  void setSleepTimer(int minutes) {
    sleepTimer.value = minutes;
  }
}

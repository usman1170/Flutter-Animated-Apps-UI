import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(milliseconds: 1800), () {
      if (!isClosed) {
        Get.offNamed(Routes.TABS);
      }
    });
  }
}

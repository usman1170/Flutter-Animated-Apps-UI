import 'package:get/get.dart';

import '../controllers/phone_bills_controller.dart';

class PhoneBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneBillsController>(() => PhoneBillsController());
  }
}

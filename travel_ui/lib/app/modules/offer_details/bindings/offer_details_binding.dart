import 'package:get/get.dart';

import '../controllers/offer_details_controller.dart';

class OfferDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferDetailsController>(() => OfferDetailsController());
  }
}

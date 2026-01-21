import 'package:get/get.dart';

import '../../../data/demo_data.dart';

class HomeController extends GetxController {
  final cartCount = 0.obs;
  final restaurants = demoRestaurants;

  void addToCart() => cartCount.value++;
}

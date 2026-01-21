import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../restaurant_list/data/restaurant_data.dart';

class RestaurantDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController menuController;
  final headerVisible = false.obs;
  final titleVisible = false.obs;
  late final Restaurant restaurant;
  late final String heroTag;

  List<Product> get products => restaurant.products;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Restaurant) {
      restaurant = args;
      heroTag = 'restaurant_${restaurant.id}';
    } else if (args is Map<String, dynamic>) {
      restaurant = args['restaurant'] as Restaurant;
      heroTag = (args['heroTag'] as String?) ??
          'restaurant_${restaurant.id}';
    } else {
      throw ArgumentError('RestaurantDetailController requires restaurant args');
    }
    menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    Future.delayed(const Duration(milliseconds: 120), () {
      headerVisible.value = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      titleVisible.value = true;
    });
  }

  @override
  void onClose() {
    menuController.dispose();
    super.onClose();
  }
}

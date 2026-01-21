import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../restaurant_list/data/restaurant_data.dart';

class ProductDetailController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController buttonController;
  late final AnimationController flyController;
  late final AnimationController cartBounceController;

  final added = false.obs;
  final showFlyImage = false.obs;
  final contentVisible = false.obs;
  final lastTappedAddon = ''.obs;
  final selectedAddons = <String>{}.obs;

  late final AnimationController relatedController;
  late final AnimationController addonPulseController;

  late final Restaurant restaurant;
  late final Product product;
  late final String heroTag;
  late final List<Addon> addons;
  late final List<Product> relatedProducts;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    restaurant = args['restaurant'] as Restaurant;
    product = args['product'] as Product;
    heroTag = args['heroTag'] as String;

    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );
    flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    cartBounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    relatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    addonPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    addons = [
      Addon(
        id: 'a1',
        name: 'Extra chili',
        price: 1.2,
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80',
      ),
      Addon(
        id: 'a2',
        name: 'Cheese melt',
        price: 1.8,
        imageUrl:
            'https://images.unsplash.com/photo-1481931098730-318b6f776db0?auto=format&fit=crop&w=400&q=80',
      ),
      Addon(
        id: 'a3',
        name: 'Herb dip',
        price: 1.4,
        imageUrl:
            'https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=400&q=80',
      ),
      Addon(
        id: 'a4',
        name: 'Crunch topping',
        price: 1.0,
        imageUrl:
            'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=400&q=80',
      ),
    ];
    relatedProducts = restaurant.products
        .where((item) => item.id != product.id)
        .take(6)
        .toList(growable: false);

    Future.delayed(const Duration(milliseconds: 120), () {
      contentVisible.value = true;
    });
  }

  void toggleAddon(Addon addon) {
    lastTappedAddon.value = addon.id;
    if (selectedAddons.contains(addon.id)) {
      selectedAddons.remove(addon.id);
    } else {
      selectedAddons.add(addon.id);
    }
    selectedAddons.refresh();
    addonPulseController.forward(from: 0).then((_) {
      addonPulseController.reverse();
    });
  }

  Future<void> handleAddToCart(VoidCallback onComplete) async {
    if (added.value) return;
    added.value = true;
    showFlyImage.value = true;

    await buttonController.forward();
    await buttonController.reverse();

    // Fly the product image toward the cart icon.
    flyController.forward(from: 0);
    await cartBounceController.forward(from: 0);
    await cartBounceController.reverse();

    onComplete();
    showFlyImage.value = false;
  }

  @override
  void onClose() {
    buttonController.dispose();
    flyController.dispose();
    cartBounceController.dispose();
    relatedController.dispose();
    addonPulseController.dispose();
    super.onClose();
  }
}

class Addon {
  Addon({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
}

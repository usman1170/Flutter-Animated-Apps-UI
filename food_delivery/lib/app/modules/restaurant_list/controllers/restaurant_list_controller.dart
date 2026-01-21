import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/restaurant_data.dart';

class RestaurantListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController listController;
  late final PageController bannerController;
  Timer? _bannerTimer;

  final currentBanner = 0.obs;
  final restaurants = demoRestaurants;
  final banners = demoBanners;

  @override
  void onInit() {
    super.onInit();
    listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    bannerController = PageController(viewportFraction: 0.88);
    bannerController.addListener(_handleBannerScroll);
    _startBannerAutoScroll();
  }

  void _handleBannerScroll() {
    final page = bannerController.page?.round() ?? 0;
    if (page != currentBanner.value) {
      currentBanner.value = page;
    }
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!bannerController.hasClients || banners.isEmpty) return;
      final nextPage = (currentBanner.value + 1) % banners.length;
      bannerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    listController.dispose();
    bannerController.removeListener(_handleBannerScroll);
    bannerController.dispose();
    _bannerTimer?.cancel();
    super.onClose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CheckoutStage { loading, success }

class CheckoutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final stage = CheckoutStage.loading.obs;
  late final AnimationController pulseController;
  bool _started = false;

  @override
  void onInit() {
    super.onInit();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    startCheckout();
  }

  Future<void> startCheckout() async {
    if (_started) return;
    _started = true;
    await Future.delayed(const Duration(milliseconds: 1400));
    stage.value = CheckoutStage.success;
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  void onClose() {
    pulseController.dispose();
    super.onClose();
  }
}

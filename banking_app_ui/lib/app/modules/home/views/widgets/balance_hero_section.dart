import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';
import 'balance_expanded_scene.dart';
import 'balance_hidden_scene.dart';

class BalanceHeroSection extends GetView<HomeController> {
  const BalanceHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppColor.secondaryText,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Usman Ghani',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w700,
              color: AppColor.textStrong,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 34),
          Obx(
            () => SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  IgnorePointer(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 420),
                      curve: Curves.easeOutCubic,
                      opacity: controller.isBalanceVisible.value ? 1 : 0.18,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeOutCubic,
                        scale: controller.isBalanceVisible.value ? 1 : 0.86,
                        child: Transform.translate(
                          offset: const Offset(0, 14),
                          child: Container(
                            width: 290,
                            height: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColor.heroGlow.withAlpha(116),
                                  AppColor.paymentsBlueSoft.withAlpha(76),
                                  AppColor.surfaceMint.withAlpha(68),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.heroGlow.withAlpha(74),
                                  blurRadius: 70,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: controller.isBalanceVisible.value,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOutCubic,
                      opacity: controller.isBalanceVisible.value ? 0 : 1,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        offset: controller.isBalanceVisible.value
                            ? const Offset(0, -0.04)
                            : Offset.zero,
                        child: GestureDetector(
                          onTap: controller.toggleBalance,
                          child: const BalanceHiddenScene(),
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: !controller.isBalanceVisible.value,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 360),
                      curve: Curves.easeOutCubic,
                      opacity: controller.isBalanceVisible.value ? 1 : 0,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 460),
                        curve: Curves.easeOutCubic,
                        offset: controller.isBalanceVisible.value
                            ? Offset.zero
                            : const Offset(0, 0.04),
                        child: const BalanceExpandedScene(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

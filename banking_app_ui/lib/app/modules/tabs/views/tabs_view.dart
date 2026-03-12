import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../home/views/home_view.dart';
import '../controllers/tabs_controller.dart';
import 'widgets/payments_sheet.dart';
import 'widgets/profile_sheet.dart';
import 'widgets/tabs_bottom_bar.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.82;

    return Scaffold(
      backgroundColor: AppColor.homeBg,
      extendBody: true,
      body: Obx(
        () => Stack(
          children: [
            const Positioned.fill(child: HomeView()),
            if (controller.currentIndex.value != 0)
              Positioned.fill(
                child: GestureDetector(
                  onTap: controller.closeSheet,
                  child: Container(color: AppColor.overlayScrim),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                ignoring: controller.currentIndex.value == 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  offset: controller.currentIndex.value == 0
                      ? const Offset(0, 1.1)
                      : Offset.zero,
                  child: SizedBox(
                    height: sheetHeight,
                    width: double.infinity,
                    child: controller.currentIndex.value == 2
                        ? const ProfileSheet()
                        : const PaymentsSheet(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => TabsBottomBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}

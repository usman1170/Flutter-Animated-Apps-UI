import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../home/views/home_view.dart';
import '../../../theme/app_colors.dart';
import 'dart:ui';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Obx(() {
            return IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                const Center(
                  child: Text(
                    "Camera View",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const HomeView(),
                const Center(
                  child: Text(
                    "Settings View",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          }),

          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.bottomNavBackground,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(0, Icons.videocam_outlined),
                        _buildNavHomeItem(1),
                        _buildNavItem(2, Icons.lightbulb_outline),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.secondaryText,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildNavHomeItem(int index) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.lock_outline, color: Colors.white, size: 28),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';

class CustomBottomNavBar extends GetView<HomeController> {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBarBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border(top: BorderSide(color: Color(0xFF1A2B3C), width: 1)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 26, left: 10, right: 10),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, 'LOBBY', Icons.sports_esports_outlined),
            _buildNavItem(1, 'WORKOUT', Icons.fitness_center_outlined),
            _buildNavItem(2, 'HISTORY', Icons.history_rounded),
            _buildNavItem(3, 'PROFILE', Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    final bool isSelected = controller.selectedIndex.value == index;
    final Color color = isSelected ? AppColors.accent : const Color(0xFF7E8997);

    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 23),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/water_ripple_tap.dart';
import '../../controllers/dashboard_controller.dart';

class MusicBottomNavBar extends StatelessWidget {
  const MusicBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final width = MediaQuery.of(context).size.width;
    final barWidth = width * 0.62;

    return Obx(() {
      final selected = controller.tabIndex.value;
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: barWidth,
            child: LiquidGlass.withOwnLayer(
              shape: const LiquidRoundedSuperellipse(borderRadius: 32),
              settings: LiquidGlassSettings(
                blur: 18,
                thickness: 16,
                glassColor: Colors.white.withAlpha(36),
                lightIntensity: 1.1,
                ambientStrength: 0.7,
                saturation: 1.35,
                chromaticAberration: 0.02,
              ),
              glassContainsChild: true,
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 66,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withAlpha(56),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withAlpha(12),
                      Colors.white.withAlpha(6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NavIcon(
                      icon: Icons.home_rounded,
                      isActive: selected == 0,
                      onTap: () => controller.setTab(0),
                    ),
                    _NavIcon(
                      icon: Icons.headphones_rounded,
                      isActive: selected == 1,
                      onTap: () => controller.setTab(1),
                    ),

                    _NavIcon(
                      icon: Icons.settings_outlined,
                      isActive: selected == 2,
                      onTap: () => controller.setTab(2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WaterRippleTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 56,
        width: 56,
        decoration: isActive
            ? BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(89),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              )
            : const BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          icon,
          color: isActive ? Colors.white : AppColors.textMuted,
          size: 22,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../../../theme/app_colors.dart';
import '../../../theme/app_fonts.dart';
import '../controllers/home_controller.dart';
import 'package:gap/gap.dart';

class HomeCameraCard extends GetView<HomeController> {
  const HomeCameraCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (index) => controller.currentCategoryIndex.value = index,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return _buildCameraView('assets/images/house.png');
        },
      ),
    );
  }

  Widget _buildCameraView(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentRed,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(6),
                Text(
                  'Live',
                  style: AppFonts.textStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                _buildGlassIconButton(Icons.mic_none),
                const Gap(12),
                _buildGlassIconButton(Icons.fullscreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassIconButton(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

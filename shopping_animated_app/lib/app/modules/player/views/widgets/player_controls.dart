import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/water_ripple_tap.dart';
import '../../../dashboard/views/widgets/glass_container.dart';
import '../../controllers/player_controller.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Obx(() {
      final playing = controller.isPlaying.value;
      return GlassContainer(
        borderRadius: 36,
        opacity: 0.12,
        borderOpacity: 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _IconButton(
              icon: Icons.shuffle,
              isActive: controller.isShuffle.value,
              onTap: controller.toggleShuffle,
            ),
            _IconButton(
              icon: Icons.skip_previous_rounded,
              size: 28,
              onTap: controller.previous,
            ),
            WaterRippleTap(
              onTap: controller.togglePlay,
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withAlpha(70),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: AppColors.bgBottom,
                  size: 28,
                ),
              ),
            ),
            _IconButton(
              icon: Icons.skip_next_rounded,
              size: 28,
              onTap: controller.next,
            ),
            _IconButton(
              icon: Icons.repeat_rounded,
              isActive: controller.isRepeat.value,
              onTap: controller.toggleRepeat,
            ),
          ],
        ),
      );
    });
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    this.size = 22,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final double size;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WaterRippleTap(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? AppColors.textPrimary : AppColors.textMuted,
        size: size,
      ),
    );
  }
}

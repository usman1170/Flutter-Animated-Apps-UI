import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/views/widgets/glass_container.dart';
import '../../controllers/player_controller.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Obx(() {
      final playing = controller.isPlaying.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _IconButton(
            icon: Icons.shuffle,
            isActive: controller.isShuffle.value,
            onTap: controller.toggleShuffle,
          ),
          _IconButton(
            icon: Icons.skip_previous_rounded,
            size: 30,
            onTap: controller.previous,
          ),
          GlassContainer(
            borderRadius: 40,
            opacity: 0.18,
            borderOpacity: 0.28,
            padding: const EdgeInsets.all(16),
            child: Icon(
              playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: AppColors.textPrimary,
              size: 28,
            ),
          ),
          _IconButton(
            icon: Icons.skip_next_rounded,
            size: 30,
            onTap: controller.next,
          ),
          _IconButton(
            icon: Icons.repeat_rounded,
            isActive: controller.isRepeat.value,
            onTap: controller.toggleRepeat,
          ),
        ],
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
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? AppColors.textPrimary : AppColors.textMuted,
        size: size,
      ),
    );
  }
}

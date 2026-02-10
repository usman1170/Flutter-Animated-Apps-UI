import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/player_controller.dart';

class WaveformSeekBar extends StatelessWidget {
  const WaveformSeekBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Obx(() {
      final progress = controller.progress.value;
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4,
          activeTrackColor: AppColors.textPrimary,
          inactiveTrackColor: AppColors.textMuted.withAlpha(80),
          thumbColor: AppColors.textPrimary,
          overlayColor: AppColors.textPrimary.withAlpha(30),
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 8,
          ),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
        ),
        child: Slider(
          value: progress,
          min: 0,
          max: 1,
          onChanged: controller.seek,
        ),
      );
    });
  }
}

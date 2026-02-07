import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/player_controller.dart';

class WaveformSeekBar extends StatelessWidget {
  const WaveformSeekBar({super.key});

  static const _bars = [
    8, 12, 10, 16, 12, 22, 14, 26, 18, 30, 22, 34, 24, 36, 28, 40, 24,
    36, 22, 34, 18, 30, 16, 26, 14, 22, 12, 18, 10, 16, 12, 10, 8,
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    return Obx(() {
      final progress = controller.progress.value;
      final totalBars = _bars.length;
      final activeBars = (totalBars * progress).round();

      return GestureDetector(
        onHorizontalDragUpdate: (details) {
          final box = context.findRenderObject() as RenderBox?;
          if (box == null) return;
          final local = box.globalToLocal(details.globalPosition);
          controller.seek(local.dx / box.size.width);
        },
        onTapDown: (details) {
          final box = context.findRenderObject() as RenderBox?;
          if (box == null) return;
          final local = box.globalToLocal(details.globalPosition);
          controller.seek(local.dx / box.size.width);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalBars, (index) {
            final height = _bars[index].toDouble();
            final isActive = index <= activeBars;
            return Container(
              width: 4,
              height: height,
              decoration: BoxDecoration(
                color: isActive ? AppColors.textPrimary : AppColors.textMuted,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }),
        ),
      );
    });
  }
}

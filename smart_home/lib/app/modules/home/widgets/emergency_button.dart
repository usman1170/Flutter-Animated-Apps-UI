import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_fonts.dart';
import 'package:gap/gap.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      height: 60,
      backgroundColor: AppColors.accentRed.withValues(alpha: 0.3),
      toggleColor: AppColors.accentRed,
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(seconds: 2));
        controller.success();
        await Future.delayed(const Duration(seconds: 1));
        controller.reset();
      },
      icon: const Icon(Icons.emergency_outlined, color: Colors.white, size: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(24),
          Text(
            'Slide for emergency',
            style: AppFonts.textStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(8),
          const Icon(
            Icons.keyboard_double_arrow_right,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}

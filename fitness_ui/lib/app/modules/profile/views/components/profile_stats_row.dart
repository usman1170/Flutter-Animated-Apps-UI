import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    required this.isGoalMode,
    required this.onStatsTap,
    required this.onGoalTap,
    super.key,
  });

  final bool isGoalMode;
  final VoidCallback onStatsTap;
  final VoidCallback onGoalTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onStatsTap,
            child: _buildTabButton(label: 'STATS', isSelected: !isGoalMode),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onGoalTap,
            child: _buildTabButton(
              label: 'GOAL & STREAK',
              isSelected: isGoalMode,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton({required String label, required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.accent : AppColors.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

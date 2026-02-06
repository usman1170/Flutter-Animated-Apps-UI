import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CameraTabs extends StatelessWidget {
  const CameraTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isActive = index == selectedIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: isActive
                    ? const LinearGradient(
                        colors: [
                          AppColors.primary,
                          Color(0xFF7FDDF3),
                        ],
                      )
                    : null,
                color: isActive ? null : AppColors.chipBackground(brightness),
                border: Border.all(
                  color: AppColors.glassBorder(brightness),
                  width: 1.1,
                ),
              ),
              child: Text(
                tabs[index],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isActive
                          ? Colors.white
                          : AppColors.mutedIcon(brightness),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_container.dart';

class DeviceInfoSection extends StatelessWidget {
  const DeviceInfoSection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Device Info',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
            const Spacer(),
            Text(
              'See All',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassContainer(
          borderRadius: 26,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavIcon(
                icon: Icons.home_filled,
                index: 0,
                isActive: selectedIndex == 0,
                onTap: () => onChanged(0),
              ),
              _NavIcon(
                icon: Icons.battery_full,
                index: 1,
                isActive: selectedIndex == 1,
                onTap: () => onChanged(1),
              ),
              _NavIcon(
                icon: Icons.storage_rounded,
                index: 2,
                isActive: selectedIndex == 2,
                onTap: () => onChanged(2),
              ),
              _NavIcon(
                icon: Icons.videocam_rounded,
                index: 3,
                isActive: selectedIndex == 3,
                onTap: () => onChanged(3),
              ),
              _NavIcon(
                icon: Icons.settings_rounded,
                index: 4,
                isActive: selectedIndex == 4,
                onTap: () => onChanged(4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Outdoor',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.primary : Colors.transparent,
          border: Border.all(
            color: AppColors.glassBorder(brightness),
            width: 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(90),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          color: isActive
              ? Colors.white
              : AppColors.mutedIcon(brightness),
          size: 20,
        ),
      ),
    );
  }
}

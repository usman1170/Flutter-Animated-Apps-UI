import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CameraAppBar extends StatelessWidget {
  const CameraAppBar({
    super.key,
    required this.avatarUrl,
    required this.isDark,
    required this.onToggleTheme,
  });

  final String avatarUrl;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.glassBorder(brightness),
              width: 1.2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.person, size: 28),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        _ActionIcon(
          icon: Icons.search,
          onTap: () {},
        ),
        const SizedBox(width: 12),
        _ActionIcon(
          icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          onTap: onToggleTheme,
        ),
        const SizedBox(width: 12),
        _ActionIcon(
          icon: Icons.notifications_none_rounded,
          onTap: () {},
          showDot: true,
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.onTap,
    this.showDot = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.pillBackground(brightness),
              border: Border.all(
                color: AppColors.glassBorder(brightness),
                width: 1.1,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.mutedIcon(brightness),
            ),
          ),
        ),
        if (showDot)
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.liveRed,
              ),
            ),
          ),
      ],
    );
  }
}

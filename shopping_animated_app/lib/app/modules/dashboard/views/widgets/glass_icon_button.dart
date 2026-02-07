import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_container.dart';

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 24,
        opacity: 0.12,
        borderOpacity: 0.3,
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }
}

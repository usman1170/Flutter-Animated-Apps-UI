import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/water_ripple_tap.dart';
import 'glass_container.dart';

class PopularListItem extends StatelessWidget {
  const PopularListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onPlay,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            imageUrl,
            height: 58,
            width: 58,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
        ),
        GlassPlayButton(onTap: onPlay),
      ],
    );
  }
}

class GlassPlayButton extends StatelessWidget {
  const GlassPlayButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WaterRippleTap(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 22,
        opacity: 0.12,
        borderOpacity: 0.28,
        padding: const EdgeInsets.all(12),
        child: const Icon(
          Icons.play_arrow_rounded,
          color: AppColors.textPrimary,
          size: 18,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_container.dart';

class DeviceInfoCards extends StatelessWidget {
  const DeviceInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 148,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _InfoCard(
            title: 'Signal',
            value: 'Stable',
            icon: Icons.wifi_rounded,
            accent: AppColors.primary,
          ),
          SizedBox(width: 14),
          _InfoCard(
            title: 'Battery',
            value: '68%',
            icon: Icons.battery_charging_full_rounded,
            accent: Color(0xFF58C2E8),
          ),
          SizedBox(width: 14),
          _InfoCard(
            title: 'Storage',
            value: '12 GB',
            icon: Icons.storage_rounded,
            accent: Color(0xFF7AC7F2),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatefulWidget {
  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 128),
      child: SizedBox(
        width: 150,
        child: GlassContainer(
          borderRadius: 20,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.accent.withAlpha(200),
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.accent.withAlpha(200),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.mutedIcon(brightness),
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_container.dart';

class ScheduleCards extends StatelessWidget {
  const ScheduleCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _NotificationScheduleCard()),
        SizedBox(width: 16),
        Expanded(child: _MovementScheduleCard()),
      ],
    );
  }
}

class _NotificationScheduleCard extends StatelessWidget {
  const _NotificationScheduleCard();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SizedBox(
      height: 150,
      child: GlassContainer(
        borderRadius: 22,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: .spaceBetween,
          children: [
            _ScheduleHeader(
              icon: Icons.event_available_rounded,
              title: 'Notification\nSchedule',
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final isActive = index == 0 || index == 3 || index == 4;
                    return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.pillBackground(brightness),
                        border: Border.all(
                          color: AppColors.glassBorder(brightness),
                          width: 1,
                        ),
                      ),
                      child: isActive
                          ? const Icon(
                              Icons.check_rounded,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _DayLabel('S'),
                    _DayLabel('M'),
                    _DayLabel('T'),
                    _DayLabel('W'),
                    _DayLabel('T'),
                    _DayLabel('F'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MovementScheduleCard extends StatelessWidget {
  const _MovementScheduleCard();

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bars = [0.25, 0.5, 0.35, 0.7, 0.45, 0.6];
    return SizedBox(
      height: 150,
      child: GlassContainer(
        borderRadius: 22,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ScheduleHeader(
              icon: Icons.center_focus_strong_rounded,
              title: 'Movement\nSchedule',
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 36,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: bars.map((value) {
                  return Container(
                    width: 10,
                    height: 36 * value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.pillBackground(brightness),
                      border: Border.all(
                        color: AppColors.glassBorder(brightness),
                        width: 1,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _DayLabel('S'),
                _DayLabel('M'),
                _DayLabel('T'),
                _DayLabel('W'),
                _DayLabel('T'),
                _DayLabel('F'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleHeader extends StatelessWidget {
  const _ScheduleHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.pillBackground(brightness),
            border: Border.all(
              color: AppColors.glassBorder(brightness),
              width: 1,
            ),
          ),
          child: Icon(icon, size: 18, color: AppColors.mutedIcon(brightness)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 12,
        color: AppColors.mutedIcon(brightness),
      ),
    );
  }
}

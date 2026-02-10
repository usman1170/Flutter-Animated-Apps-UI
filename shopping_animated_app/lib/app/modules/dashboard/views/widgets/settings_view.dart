import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/dashboard_controller.dart';
import 'glass_container.dart';
import 'glass_icon_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.find<DashboardController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Settings',
                  style: textTheme.headlineLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: const [
                  GlassIconButton(icon: Icons.search_rounded),
                  SizedBox(width: 10),
                  GlassIconButton(icon: Icons.notifications_none_rounded),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SectionTitle(title: 'Playback & Downloads'),
          const SizedBox(height: 12),
          _GlassToggleTile(
            title: 'Offline mode',
            subtitle: 'Play your downloads only.',
            value: controller.offlineMode,
            onTap: controller.toggleOfflineMode,
          ),
          const SizedBox(height: 12),
          _GlassToggleTile(
            title: 'Download over cellular',
            subtitle: 'Use mobile data for downloads.',
            value: controller.cellularDownload,
            onTap: controller.toggleCellularDownload,
          ),
          const SizedBox(height: 12),
          _GlassToggleTile(
            title: 'Explicit content filter',
            subtitle: 'Hide songs with explicit lyrics.',
            value: controller.explicitFilter,
            onTap: controller.toggleExplicitFilter,
          ),
          const SizedBox(height: 22),
          _SectionTitle(title: 'Queue & Sleep'),
          const SizedBox(height: 12),
          _GlassToggleTile(
            title: 'Crossfade',
            subtitle: 'Smooth transitions between songs.',
            value: controller.crossfade,
            onTap: controller.toggleCrossfade,
          ),
          const SizedBox(height: 12),
          _GlassStepperTile(
            title: 'Sleep timer',
            subtitle: 'Stop playback after ${controller.sleepTimer.value} min.',
            value: controller.sleepTimer,
            min: 5,
            max: 60,
            onChanged: controller.setSleepTimer,
          ),
          const SizedBox(height: 22),
          _SectionTitle(title: 'Account'),
          const SizedBox(height: 12),
          _GlassActionTile(
            title: 'Manage subscription',
            subtitle: 'Premium plan and billing',
            icon: Icons.workspace_premium_rounded,
          ),
          const SizedBox(height: 12),
          _GlassActionTile(
            title: 'Connected devices',
            subtitle: 'Speakers, TVs, and cars',
            icon: Icons.speaker_rounded,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _GlassTile extends StatelessWidget {
  const _GlassTile({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 50,
      opacity: 0.08,
      borderOpacity: 0.35,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      gradient: LinearGradient(
        colors: [
          AppColors.textPrimary.withAlpha(14),
          AppColors.textPrimary.withAlpha(8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: child,
    );
  }
}

class _GlassToggleTile extends StatelessWidget {
  const _GlassToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final RxBool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _GlassTile(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Obx(() {
            final enabled = value.value;
            return GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 28,
                width: 48,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: enabled
                      ? const LinearGradient(
                          colors: [AppColors.accent, AppColors.accentDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            AppColors.textMuted.withAlpha(70),
                            AppColors.textMuted.withAlpha(20),
                          ],
                        ),
                ),
                child: Align(
                  alignment: enabled
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _GlassSliderTile extends StatelessWidget {
  const _GlassSliderTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final RxDouble value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _GlassTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.accent,
                inactiveTrackColor: AppColors.textMuted.withAlpha(70),
                thumbColor: AppColors.accent,
                overlayColor: AppColors.accent.withAlpha(40),
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                min: 0,
                max: 1,
                value: value.value,
                onChanged: onChanged,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _GlassStepperTile extends StatelessWidget {
  const _GlassStepperTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final RxInt value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _GlassTile(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() {
                  return Text(
                    subtitle.replaceAll(RegExp(r'\d+'), value.value.toString()),
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Obx(() {
            return Row(
              children: [
                _StepButton(
                  icon: Icons.remove,
                  onTap: () {
                    final next = (value.value - 5).clamp(min, max);
                    onChanged(next);
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  '${value.value}m',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                _StepButton(
                  icon: Icons.add,
                  onTap: () {
                    final next = (value.value + 5).clamp(min, max);
                    onChanged(next);
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withAlpha(20),
          border: Border.all(color: Colors.white.withAlpha(60), width: 1),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}

class _GlassActionTile extends StatelessWidget {
  const _GlassActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _GlassTile(
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.accent, AppColors.accentDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}

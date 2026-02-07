import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/dashboard_home.dart';
import 'widgets/library_view.dart';
import 'widgets/music_bottom_nav_bar.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundGradient(),
          LiquidGlassLayer(
            settings: _GlassSettings.layer,
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Obx(() {
                      final index = controller.tabIndex.value;
                      if (index == 0) {
                        return const DashboardHome();
                      }
                      if (index == 1) {
                        return const LibraryView();
                      }

                      if (index == 2) {
                        return const _PlaceholderPage(
                          title: 'Music',
                          subtitle: 'Your tracks and playlists.',
                          icon: Icons.music_note_rounded,
                        );
                      }
                      return const _PlaceholderPage(
                        title: 'Profile',
                        subtitle: 'Personalize your music journey.',
                        icon: Icons.person_outline_rounded,
                      );
                    }),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 8,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MusicBottomNavBar(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.bgTop,
            AppColors.bgMid,
            AppColors.bgBottom,
            AppColors.bgDeep,
          ],
          stops: [0.0, 0.45, 0.75, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.transparent, AppColors.bgDeep.withAlpha(120)],
            radius: 0.85,
            center: const Alignment(0.35, 0.15),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 48),
          const SizedBox(height: 12),
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _GlassSettings {
  _GlassSettings._();

  static final layer = LiquidGlassSettings(
    blur: 16,
    thickness: 12,
    glassColor: Colors.white.withAlpha(36),
    lightIntensity: 1.4,
    saturation: 1.2,
    ambientStrength: 0.6,
    chromaticAberration: 0.02,
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../dashboard/views/widgets/glass_container.dart';
import '../controllers/player_controller.dart';
import 'widgets/player_controls.dart';
import 'widgets/waveform_seek_bar.dart';

class PlayerView extends GetView<PlayerController> {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          const _PlayerBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: const GlassContainer(
                          borderRadius: 22,
                          opacity: 0.12,
                          borderOpacity: 0.25,
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 18,
                          ),
                        ),
                      ),
                      Text(
                        'Now Playing',
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const GlassContainer(
                        borderRadius: 22,
                        opacity: 0.12,
                        borderOpacity: 0.25,
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.ios_share_rounded,
                          color: AppColors.textPrimary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Expanded(
                    child: Obx(() {
                      final tracks = controller.tracks;
                      final index = controller.currentIndex.value;
                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.78),
                        onPageChanged: controller.jumpTo,
                        itemCount: tracks.length,
                        itemBuilder: (context, pageIndex) {
                          final track = tracks[pageIndex];
                          final isActive = pageIndex == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: isActive ? 0 : 18,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              image: DecorationImage(
                                image: NetworkImage(track.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withAlpha(40),
                                    Colors.black.withAlpha(120),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 22),
                  Obx(() {
                    final track = controller.currentTrack;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.artist,
                                style: textTheme.bodySmall?.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                track.title,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.toggleFavorite,
                          child: Obx(() {
                            final fav = controller.isFavorite.value;
                            return GlassContainer(
                              borderRadius: 22,
                              opacity: 0.12,
                              borderOpacity: 0.28,
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                fav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: fav
                                    ? AppColors.accent
                                    : AppColors.textPrimary,
                                size: 18,
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 18),
                  const WaveformSeekBar(),
                  const SizedBox(height: 14),
                  Obx(() {
                    final track = controller.currentTrack;
                    final elapsed =
                        (track.durationSeconds * controller.progress.value)
                            .round();
                    final elapsedLabel =
                        '${elapsed ~/ 60}:${(elapsed % 60).toString().padLeft(2, '0')}';
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          elapsedLabel,
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                        Text(
                          track.durationLabel,
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  const PlayerControls(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerBackground extends StatelessWidget {
  const _PlayerBackground();

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
          stops: [0.0, 0.35, 0.7, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.transparent,
              AppColors.bgDeep.withAlpha(120),
            ],
            radius: 0.9,
            center: const Alignment(0.4, 0.2),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../../core/theme/app_colors.dart';
import '../../dashboard/views/widgets/glass_container.dart';
import '../../../core/widgets/water_ripple_tap.dart';
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
          const _AmbientGlow(),
          LiquidGlassLayer(
            settings: LiquidGlassSettings(
              blur: 16,
              thickness: 12,
              glassColor: Colors.white.withAlpha(36),
              lightIntensity: 1.1,
              ambientStrength: 0.7,
              saturation: 1.25,
              chromaticAberration: 0.02,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WaterRippleTap(
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
                        WaterRippleTap(
                          onTap: () {},
                          child: const GlassContainer(
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: 320,
                      child: Obx(() {
                        final tracks = controller.tracks;
                        final index = controller.currentIndex.value;
                        final beat = controller.beatLevel.value;
                        return PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: controller.jumpTo,
                          itemCount: tracks.length,
                          itemBuilder: (context, pageIndex) {
                            final track = tracks[pageIndex];
                            final isActive = pageIndex == index;
                            return _PulseCover(
                              isActive: isActive,
                              beat: beat,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: isActive ? 4 : 22,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  image: DecorationImage(
                                    image: NetworkImage(track.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withAlpha(35),
                                        Colors.black.withAlpha(120),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
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
                                const SizedBox(height: 8),
                                Text(
                                  track.title,
                                  style: textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          WaterRippleTap(
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
                    const SizedBox(height: 24),
                    GlassContainer(
                      borderRadius: 22,
                      opacity: 0.1,
                      borderOpacity: 0.2,
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                      child: Column(
                        children: [
                          const WaveformSeekBar(),
                          const SizedBox(height: 10),
                          Obx(() {
                            final track = controller.currentTrack;
                            final elapsed =
                                (track.durationSeconds *
                                        controller.progress.value)
                                    .round();
                            final elapsedLabel =
                                '${elapsed ~/ 60}:${(elapsed % 60).toString().padLeft(2, '0')}';
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  elapsedLabel,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                Text(
                                  track.durationLabel,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const PlayerControls(),
                    const SizedBox(height: 18),
                    Obx(() {
                      final tracks = controller.tracks;
                      if (tracks.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final nextIndex =
                          (controller.currentIndex.value + 1) % tracks.length;
                      final nextTrack = tracks[nextIndex];
                      return GlassContainer(
                        borderRadius: 22,
                        opacity: 0.09,
                        borderOpacity: 0.18,
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                nextTrack.imageUrl,
                                height: 46,
                                width: 46,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Up Next',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    nextTrack.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    nextTrack.artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.queue_music_rounded,
                              color: AppColors.textMuted,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
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
            colors: [Colors.transparent, AppColors.bgDeep.withAlpha(120)],
            radius: 0.9,
            center: const Alignment(0.4, 0.2),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.transparent, AppColors.bgDeep.withAlpha(180)],
              radius: 0.9,
              center: const Alignment(0.5, 0.95),
            ),
          ),
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatefulWidget {
  const _AmbientGlow();

  @override
  State<_AmbientGlow> createState() => _AmbientGlowState();
}

class _AmbientGlowState extends State<_AmbientGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final PlayerController _playerController;
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _playerController = Get.find<PlayerController>();
    _worker = ever<bool>(_playerController.isPlaying, (playing) {
      if (playing) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
    if (_playerController.isPlaying.value) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _worker?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeInOut.transform(_controller.value);
          final alpha = (60 + (80 * t)).round();
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.transparent, AppColors.accent.withAlpha(alpha)],
                radius: 0.95,
                center: const Alignment(0.55, 0.88),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PulseCover extends StatelessWidget {
  const _PulseCover({
    required this.child,
    required this.isActive,
    required this.beat,
  });

  final Widget child;
  final bool isActive;
  final double beat;

  @override
  Widget build(BuildContext context) {
    final scale = isActive ? (1.0 + (beat * 0.04)) : 1.0;
    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeOut,
      child: child,
    );
  }
}

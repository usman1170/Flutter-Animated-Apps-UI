import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../lobby/controllers/lobby_controller.dart';

import '../../../../core/theme/app_colors.dart';
import 'arc_progress_painter.dart';
import 'avatar_creator_view.dart';
import 'goal_streak_panel.dart';
import 'locker_section.dart';

class ProfileAvatarSection extends StatefulWidget {
  const ProfileAvatarSection({required this.isGoalMode, super.key});

  final bool isGoalMode;

  @override
  State<ProfileAvatarSection> createState() => _ProfileAvatarSectionState();
}

class _ProfileAvatarSectionState extends State<ProfileAvatarSection> {
  String avatarUrl =
      'https://models.readyplayer.me/65893b0514f9f5f28e61d783.glb';

  @override
  void initState() {
    super.initState();
    _initAvatar();
  }

  void _initAvatar() {
    try {
      final LobbyController controller = Get.find<LobbyController>();
      if (controller.selectedAvatarPath.value.isNotEmpty) {
        avatarUrl = controller.selectedAvatarPath.value;
      }
    } catch (_) {
      // LobbyController might not be initialized if navigated here directly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 380,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool goalMode = widget.isGoalMode;
              final double leftInset = goalMode
                  ? -constraints.maxWidth * 0.16
                  : 22;
              final double rightInset = goalMode
                  ? constraints.maxWidth * 0.42
                  : 0;
              final double glowWidth = goalMode ? 198 : 250;
              final double glowHeight = goalMode ? 50 : 60;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeInOutCubic,
                    left: leftInset,
                    right: rightInset,
                    bottom: 20,
                    child: Center(
                      child: Container(
                        width: glowWidth,
                        height: glowHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(glowWidth / 2, glowHeight / 2),
                          ),
                          border: Border.all(color: AppColors.accent, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withAlpha(76),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeInOutCubic,
                    left: leftInset,
                    right: rightInset,
                    bottom: 30,
                    height: 330,
                    child: ModelViewer(
                      key: ValueKey(avatarUrl),
                      backgroundColor: Colors.transparent,
                      src: avatarUrl,
                      alt: 'A 3D model of a rigged human',
                      ar: false,
                      autoRotate: !goalMode,
                      cameraControls: true,
                      disableZoom: true,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeInOutCubic,
                    right: goalMode ? 0 : -constraints.maxWidth * 0.42,
                    top: 38,
                    width: constraints.maxWidth * 0.38,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 260),
                      opacity: goalMode ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !goalMode,
                        child: const GoalStreakPanel(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 20,
                    bottom: 40,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: goalMode ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: goalMode,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCircledStat(
                              Icons.fitness_center,
                              'LVL 1',
                              0.8,
                            ),
                            _buildCircledStat(
                              Icons.directions_run,
                              'LVL 2',
                              0.5,
                            ),
                            _buildCircledStat(Icons.favorite, 'LVL 2', 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 20,
                    bottom: 40,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 220),
                      opacity: goalMode ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: goalMode,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCircledStat(
                              Icons.directions_walk,
                              'LVL 2',
                              0.7,
                            ),
                            _buildCircledStat(
                              Icons.monitor_weight_outlined,
                              'LVL 1',
                              0.4,
                            ),
                            _buildCircledStat(Icons.gps_fixed, 'LVL 2', 0.9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: goalMode ? 0 : 1,
                      child: IgnorePointer(
                        ignoring: goalMode,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => AvatarCreatorView(
                                  onAvatarExported: (url) async {
                                    final LobbyController lobbyController =
                                        Get.find<LobbyController>();
                                    await lobbyController.updateAvatar(url);
                                    setState(() {
                                      avatarUrl = url;
                                    });
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.accent,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withAlpha(50),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.auto_fix_high,
                                    color: AppColors.accent,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'CUSTOMIZE',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        const LockerSection(),
      ],
    );
  }

  Widget _buildCircledStat(IconData icon, String label, double progress) {
    return Column(
      children: [
        SizedBox(
          width: 68,
          height: 68,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CustomPaint(
              painter: ArcProgressPainter(progress: progress),
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.accent, size: 30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

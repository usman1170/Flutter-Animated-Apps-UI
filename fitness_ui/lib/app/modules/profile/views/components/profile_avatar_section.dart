import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'dart:math' as math;
import '../../../../core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'avatar_creator_view.dart';
import 'locker_section.dart';

class ProfileAvatarSection extends StatefulWidget {
  const ProfileAvatarSection({super.key});

  @override
  State<ProfileAvatarSection> createState() => _ProfileAvatarSectionState();
}

class _ProfileAvatarSectionState extends State<ProfileAvatarSection> {
  String avatarUrl =
      'https://models.readyplayer.me/65893b0514f9f5f28e61d783.glb';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 380,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 20,
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(125, 30),
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
              Positioned(
                bottom: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 360,
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ModelViewer(
                    key: ValueKey(
                      avatarUrl,
                    ), // Forces ModelViewer to re-initialize when URL changes
                    backgroundColor: Colors.transparent,
                    src: avatarUrl,
                    alt: 'A 3D model of a rigged human',
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                    disableZoom: true,
                    innerModelViewerHtml: '''
                      <div slot="poster" id="poster">
                        <div class="loader-pulse"></div>
                      </div>
                      <style>
                        #poster {
                          width: 100%;
                          height: 100%;
                          display: flex;
                          justify-content: center;
                          align-items: center;
                        }
                        .loader-pulse {
                          width: 80px;
                          height: 80px;
                          border-radius: 50%;
                          background: rgba(0, 240, 255, 0.4); /* Cyan accent */
                          box-shadow: 0 0 0 0 rgba(0, 240, 255, 0.7);
                          animation: pulse-ring 1.5s infinite;
                        }
                        @keyframes pulse-ring {
                          0% {
                            transform: scale(0.8);
                            box-shadow: 0 0 0 0 rgba(0, 240, 255, 0.7);
                          }
                          70% {
                            transform: scale(1.2);
                            box-shadow: 0 0 0 20px rgba(0, 240, 255, 0);
                          }
                          100% {
                            transform: scale(0.8);
                            box-shadow: 0 0 0 0 rgba(0, 240, 255, 0);
                          }
                        }
                      </style>
                    ''',
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 50,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.accent),
                  onPressed: () {
                    Get.to(
                      () => AvatarCreatorView(
                        onAvatarExported: (url) {
                          setState(() {
                            avatarUrl = url;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                top: 20,
                bottom: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCircledStat(Icons.fitness_center, 'LVL 1', 0.8),
                    _buildCircledStat(Icons.directions_run, 'LVL 2', 0.5),
                    _buildCircledStat(Icons.favorite, 'LVL 2', 0.6),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 20,
                bottom: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCircledStat(Icons.directions_walk, 'LVL 2', 0.7),
                    _buildCircledStat(
                      Icons.monitor_weight_outlined,
                      'LVL 1',
                      0.4,
                    ),
                    _buildCircledStat(Icons.gps_fixed, 'LVL 2', 0.9),
                  ],
                ),
              ),
            ],
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
          width: 70,
          height: 70,
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
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ArcProgressPainter extends CustomPainter {
  final double progress;

  ArcProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const startAngle = math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

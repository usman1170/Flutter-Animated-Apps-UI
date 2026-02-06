import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'glass_container.dart';

class CameraMainCard extends StatelessWidget {
  const CameraMainCard({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GlassContainer(
      borderRadius: 26,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Nous W7 3mp',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.pillBackground(brightness),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.glassBorder(brightness),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.liveRed,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '90%',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 26,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.storage_rounded,
                              size: 18,
                              color: AppColors.mutedIcon(brightness),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Storage',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.mutedIcon(brightness),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'On',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 22,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.bluetooth_rounded,
                              size: 18,
                              color: AppColors.mutedIcon(brightness),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Bluetooth',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.mutedIcon(brightness),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: -6,
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: brightness == Brightness.dark
                    ? [
                        const Color(0xFF1F2C3A).withAlpha(210),
                        const Color(0xFF1A2734).withAlpha(190),
                      ]
                    : [
                        const Color(0xFFFFFFFF).withAlpha(230),
                        const Color(0xFFDDE8F3).withAlpha(210),
                      ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.glassBorder(brightness),
                width: 1,
              ),
              boxShadow: brightness == Brightness.dark
                  ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.white.withAlpha(150),
                        blurRadius: 12,
                        offset: const Offset(-4, -4),
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Row(
              children: [
                _ControlButton(
                  icon: Icons.videocam_off_rounded,
                  onTap: () {},
                ),
                const Spacer(),
                Text(
                  '›››',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 3,
                        color: AppColors.mutedIcon(brightness),
                      ),
                ),
                const Spacer(),
                _ControlButton(
                  icon: Icons.videocam_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.pillBackground(brightness),
          border: Border.all(
            color: AppColors.glassBorder(brightness),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: AppColors.mutedIcon(brightness),
          size: 20,
        ),
      ),
    );
  }
}

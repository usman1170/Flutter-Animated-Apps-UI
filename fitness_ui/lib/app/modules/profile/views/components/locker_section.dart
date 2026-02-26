import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../../gen/assets.gen.dart';

class LockerSection extends StatelessWidget {
  const LockerSection({super.key});

  static final List<String> _lockerPngs = <String>[
    Assets.images.locker.blackJacket.path,
    Assets.images.locker.whiteTshirt.path,
    Assets.images.locker.blackTrouser.path,
    Assets.images.locker.blueShirt.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'LOCKER',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 15.5,
                letterSpacing: 2.0,
              ),
            ),
            Row(
              children: const [
                Text(
                  '7/30',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 86,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFirstLockerItem(),
              _buildLockerItem(
                imagePath: _lockerPngs[1],
                imageAlignment: const Alignment(0, -0.35),
              ),
              _buildLockerItem(
                imagePath: _lockerPngs[3],
                imageAlignment: const Alignment(0, -0.18),
              ),
              _buildLockerItem(
                imagePath: _lockerPngs[2],
                imageAlignment: const Alignment(0, -0.18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFirstLockerItem() {
    return Container(
      width: 112,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF101E31),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF25384D), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildItemImage(
              imagePath: _lockerPngs[0],
              alignment: const Alignment(-0.15, -0.25),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0x2A020D18), const Color(0xA6040E1A)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockerItem({
    required String imagePath,
    required Alignment imageAlignment,
  }) {
    return Container(
      width: 112,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF101E31),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF25384D), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildItemImage(imagePath: imagePath, alignment: imageAlignment),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0x2A020D18), const Color(0xA6040E1A)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage({
    required String imagePath,
    required Alignment alignment,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Image.asset(
        imagePath,
        alignment: alignment,
        filterQuality: FilterQuality.high,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: const Color(0xFF0E1A2A),
            alignment: Alignment.center,
            child: const Icon(
              Icons.checkroom_rounded,
              color: Color(0xFF4C6078),
              size: 24,
            ),
          );
        },
      ),
    );
  }
}

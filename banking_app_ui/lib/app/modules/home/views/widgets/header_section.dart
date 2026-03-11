import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.greyBg,
              border: Border.all(color: AppColor.divider, width: 1),
            ),
            child: ClipOval(
              child: Icon(
                LucideIcons.user,
                size: 22,
                color: AppColor.secondaryText,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColor.secondaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'George P.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryText,
                  ),
                ),
              ],
            ),
          ),
          _buildIconButton(LucideIcons.settings),
          const SizedBox(width: 8),
          _buildIconButton(LucideIcons.search),
          const SizedBox(width: 8),
          Stack(
            children: [
              _buildIconButton(LucideIcons.bell),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColor.redBadge,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.white, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      '9+',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: AppColor.greyBg, shape: BoxShape.circle),
      child: Center(child: Icon(icon, size: 18, color: AppColor.primaryText)),
    );
  }
}

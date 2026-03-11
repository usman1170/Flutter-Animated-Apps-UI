import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class SpendingsSection extends StatelessWidget {
  const SpendingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spendings in April',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryText,
                ),
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.accentBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildSpendingCard(
                LucideIcons.refreshCw,
                AppColor.spendingPurple,
                AppColor.spendingPurpleIcon,
                '\$ 10,000',
                'All Transactions',
              ),
              const SizedBox(width: 12),
              _buildSpendingCard(
                LucideIcons.arrowUpRight,
                AppColor.spendingBlue,
                AppColor.spendingBlueIcon,
                '\$ 1,456',
                'Transferred',
              ),
              const SizedBox(width: 12),
              _buildSpendingCard(
                LucideIcons.globe,
                AppColor.spendingGreen,
                AppColor.spendingGreenIcon,
                '\$ 271',
                'Online Shopping',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpendingCard(
    IconData icon,
    Color bgColor,
    Color iconColor,
    String amount,
    String label,
  ) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.scaffoldBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(icon, size: 20, color: iconColor)),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColor.secondaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

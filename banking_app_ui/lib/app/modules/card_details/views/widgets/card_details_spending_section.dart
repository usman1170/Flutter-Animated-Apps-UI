import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class CardDetailsSpendingSection extends StatelessWidget {
  const CardDetailsSpendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Spendings in April',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textStrong,
                ),
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.paymentsBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 146,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _SpendCard(
                icon: LucideIcons.history,
                iconBg: AppColor.surfaceLavender,
                iconColor: AppColor.paymentsBlue,
                amount: '\$ 10,000',
                label: 'All Transactions',
              ),
              SizedBox(width: 12),
              _SpendCard(
                icon: LucideIcons.creditCard,
                iconBg: AppColor.spendingPurple,
                iconColor: AppColor.spendingPurpleIcon,
                amount: '\$ 1,456',
                label: 'Transferred',
              ),
              SizedBox(width: 12),
              _SpendCard(
                icon: LucideIcons.globe,
                iconBg: AppColor.surfaceMint,
                iconColor: AppColor.paymentsMint,
                amount: '\$ 271',
                label: 'Online Shopping',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpendCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String amount;
  final String label;

  const _SpendCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.amount,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.textStrong,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

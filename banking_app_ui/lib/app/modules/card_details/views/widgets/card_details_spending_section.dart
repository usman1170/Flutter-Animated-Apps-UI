import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';

class CardDetailsSpendingSection extends StatelessWidget {
  final CardDetailsController controller;

  const CardDetailsSpendingSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final items = controller.isCredit
        ? const [
            (
              LucideIcons.history,
              AppColor.surfaceLavender,
              AppColor.paymentsBlue,
              '\$ 10,000',
              'All Transactions',
            ),
            (
              LucideIcons.creditCard,
              AppColor.spendingPurple,
              AppColor.spendingPurpleIcon,
              '\$ 1,456',
              'Transferred',
            ),
            (
              LucideIcons.globe,
              AppColor.surfaceMint,
              AppColor.paymentsMint,
              '\$ 271',
              'Online Shopping',
            ),
          ]
        : const [
            (
              LucideIcons.shoppingBag,
              AppColor.surfaceLavender,
              AppColor.paymentsBlue,
              '\$ 840',
              'Card Purchases',
            ),
            (
              LucideIcons.wallet,
              AppColor.spendingPurple,
              AppColor.spendingPurpleIcon,
              '\$ 220',
              'ATM Cash Out',
            ),
            (
              LucideIcons.badgeDollarSign,
              AppColor.surfaceMint,
              AppColor.paymentsMint,
              '\$ 1,240',
              'Salary Inflow',
            ),
          ];

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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryLabel(context),
                ),
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
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
            children: [
              for (var index = 0; index < items.length; index++) ...[
                _SpendCard(
                  icon: items[index].$1,
                  iconBg: items[index].$2,
                  iconColor: items[index].$3,
                  amount: items[index].$4,
                  label: items[index].$5,
                ),
                if (index != items.length - 1) const SizedBox(width: 12),
              ],
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
        color: AppColor.softSurface(context),
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

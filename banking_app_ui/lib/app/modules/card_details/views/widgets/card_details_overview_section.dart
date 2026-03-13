import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';
import 'card_details_header_card.dart';

class CardDetailsOverviewSection extends StatelessWidget {
  final CardDetailsController controller;

  const CardDetailsOverviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final actions = controller.isCredit
        ? const [
            (LucideIcons.arrowDownCircle, 'Top-up'),
            (LucideIcons.arrowUpCircle, 'Payments'),
            (LucideIcons.refreshCcw, 'Transfer'),
          ]
        : const [
            (LucideIcons.wallet, 'Cash out'),
            (LucideIcons.barChart3, 'Insights'),
            (LucideIcons.refreshCcw, 'Transfer'),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardDetailsHeaderCard(controller: controller),
        const SizedBox(height: 24),
        Text(
          controller.balance,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColor.primaryLabel(context).withAlpha(220),
            letterSpacing: -1.3,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            for (var index = 0; index < actions.length; index++) ...[
              Expanded(
                child: _ActionTile(
                  icon: actions[index].$1,
                  label: actions[index].$2,
                ),
              ),
              if (index != actions.length - 1) const SizedBox(width: 12),
            ],
          ],
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(context),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColor.paymentsBlue),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

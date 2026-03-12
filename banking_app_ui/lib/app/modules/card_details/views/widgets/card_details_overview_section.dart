import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';

class CardDetailsOverviewSection extends StatelessWidget {
  final CardDetailsController controller;

  const CardDetailsOverviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.balance,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColor.textStrong.withAlpha(220),
            letterSpacing: -1.3,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.arrowDownCircle,
                label: 'Top-up',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.arrowUpCircle,
                label: 'Payments',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.refreshCcw,
                label: 'Transfer',
              ),
            ),
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
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColor.paymentsBlue),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.textStrong,
            ),
          ),
        ],
      ),
    );
  }
}

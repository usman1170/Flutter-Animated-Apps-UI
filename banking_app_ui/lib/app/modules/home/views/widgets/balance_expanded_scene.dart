import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';

class BalanceExpandedScene extends GetView<HomeController> {
  const BalanceExpandedScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BalancePanel(onHide: controller.toggleBalance),
        const SizedBox(height: 14),
        const Row(
          children: [
            Expanded(
              child: _StatusCard(
                title: 'Available cash',
                value: '\$ 8,420',
                accent: AppColor.paymentsBlue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatusCard(
                title: 'Last debit',
                value: '\$ 148.20',
                accent: AppColor.warningOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BalancePanel extends StatelessWidget {
  final VoidCallback onHide;

  const _BalancePanel({required this.onHide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(10),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.paymentsBlue.withAlpha(26),
            ),
            child: const Icon(
              LucideIcons.wallet,
              size: 24,
              color: AppColor.paymentsBlue,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total balance',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryText,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '\$ 12,840.55',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textStrong,
                    letterSpacing: -0.7,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColor.surfaceMint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '+2.4%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColor.successGreen,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onHide,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.surfaceMuted,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    LucideIcons.eyeOff,
                    size: 18,
                    color: AppColor.textMid,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color accent;

  const _StatusCard({
    required this.title,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title == 'Last debit' ? 'Today at 10:24 AM' : 'Ready to transfer',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}

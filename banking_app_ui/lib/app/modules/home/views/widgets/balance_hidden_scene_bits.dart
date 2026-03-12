import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class BalancePreviewVisual extends StatelessWidget {
  const BalancePreviewVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 8,
          top: 18,
          child: Transform.rotate(
            angle: 0.08,
            child: Container(
              width: 96,
              height: 122,
              decoration: BoxDecoration(
                color: AppColor.paymentsBlue.withAlpha(46),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ),
        Positioned(
          left: 6,
          top: 0,
          child: Transform.rotate(
            angle: -0.12,
            child: Container(
              width: 104,
              height: 146,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.white.withAlpha(234),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColor.paymentsBlue,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColor.surfaceSoft,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      LucideIcons.wallet,
                      size: 24,
                      color: AppColor.paymentsBlue,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 68,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColor.surfaceMuted,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 42,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColor.surfaceMuted,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 8,
          child: Container(
            width: 82,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.textStrong,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '+12%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Monthly flow',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColor.surfaceLavender,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BalanceMiniChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const BalanceMiniChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(236),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColor.paymentsBlue),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColor.textMid,
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceStatTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const BalanceStatTag({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(208),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColor.paymentsBlue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColor.textMid,
            ),
          ),
        ],
      ),
    );
  }
}

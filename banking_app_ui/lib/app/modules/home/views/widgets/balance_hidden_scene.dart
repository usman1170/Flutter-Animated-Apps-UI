import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import 'balance_hidden_scene_bits.dart';

class BalanceHiddenScene extends StatelessWidget {
  const BalanceHiddenScene({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 286,
      child: Stack(
        children: const [
          Positioned.fill(top: 18, child: _PreviewPanel()),
          Positioned(
            right: 18,
            top: 0,
            child: BalanceMiniChip(icon: LucideIcons.sparkles, label: 'Live'),
          ),
          Positioned(
            left: 20,
            bottom: 26,
            child: BalanceMiniChip(icon: LucideIcons.lock, label: 'Hidden'),
          ),
        ],
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.white, AppColor.paymentsBlueSoft.withAlpha(72)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.heroGlow.withAlpha(88),
            blurRadius: 52,
            spreadRadius: 4,
            offset: const Offset(-10, 14),
          ),
          const BoxShadow(
            color: AppColor.heroCircleShadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(flex: 6, child: _PreviewCopy()),
          SizedBox(width: 14),
          Expanded(flex: 4, child: BalancePreviewVisual()),
        ],
      ),
    );
  }
}

class _PreviewCopy extends StatelessWidget {
  const _PreviewCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: AppColor.surfaceLavender,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'USBank Preview',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColor.paymentsBlue,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Unlock your\nmoney view',
          style: TextStyle(
            fontSize: 24,
            height: 1.05,
            fontWeight: FontWeight.w700,
            color: AppColor.textStrong,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'See cards, cash flow and recent activity with one tap.',
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w500,
            color: AppColor.secondaryText,
          ),
        ),
        const Spacer(),
        const Row(
          children: [
            BalanceStatTag(icon: LucideIcons.shieldCheck, label: 'Secure'),
            SizedBox(width: 8),
            BalanceStatTag(icon: LucideIcons.zap, label: 'Fast'),
          ],
        ),
      ],
    );
  }
}

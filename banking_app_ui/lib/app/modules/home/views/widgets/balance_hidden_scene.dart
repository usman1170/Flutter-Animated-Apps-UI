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
          colors: [
            AppColor.elevatedSurface(context),
            AppColor.blueSoft(
              context,
            ).withAlpha(AppColor.isDark(context) ? 118 : 72),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.heroGlowColor(
              context,
            ).withAlpha(AppColor.isDark(context) ? 122 : 88),
            blurRadius: AppColor.isDark(context) ? 70 : 52,
            spreadRadius: AppColor.isDark(context) ? 8 : 4,
            offset: const Offset(-10, 14),
          ),
          BoxShadow(
            color: AppColor.heroShadow(context),
            blurRadius: 14,
            offset: const Offset(0, 6),
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
            color: AppColor.lavenderSoft(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'USBank Preview',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Unlock your\nmoney view',
          style: TextStyle(
            fontSize: 24,
            height: 1.05,
            fontWeight: FontWeight.w700,
            color: AppColor.primaryLabel(context),
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'See cards, cash flow and recent activity with one tap.',
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w500,
            color: AppColor.secondaryLabel(context),
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

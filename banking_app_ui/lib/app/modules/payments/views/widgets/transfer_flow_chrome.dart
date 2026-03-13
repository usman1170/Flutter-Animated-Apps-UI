import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TransferHeroCard extends StatelessWidget {
  final IconData icon;
  final String amountText;
  final String badgeText;
  final Color accent;

  const TransferHeroCard({
    super.key,
    required this.icon,
    required this.amountText,
    required this.badgeText,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(
          context,
        ).withAlpha(AppColor.isDark(context) ? 196 : 222),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColor.dividerColor(context).withAlpha(120),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withAlpha(24),
            ),
            child: Icon(icon, color: accent, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${amountText.isEmpty ? '0.00' : amountText}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColor.primaryLabel(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.softSurface(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'In flow',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColor.primaryLabel(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransferStepProgress extends StatelessWidget {
  final List<String> labels;
  final int currentIndex;

  const TransferStepProgress({
    super.key,
    required this.labels,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          labels[currentIndex],
          key: ValueKey(labels[currentIndex]),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColor.primaryLabel(context),
          ),
        ),
      ),
    );
  }
}

class TransferFooter extends StatelessWidget {
  final Color accent;
  final bool isReceiptStep;
  final bool isFirstStep;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const TransferFooter({
    super.key,
    required this.accent,
    required this.isReceiptStep,
    required this.isFirstStep,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isReceiptStep)
          Expanded(
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                side: BorderSide(color: AppColor.dividerColor(context)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(
                isFirstStep ? 'Cancel' : 'Back',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryLabel(context),
                ),
              ),
            ),
          ),
        if (!isReceiptStep) const SizedBox(width: 12),
        Expanded(
          flex: isReceiptStep ? 1 : 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: accent.withAlpha(74),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                backgroundColor: accent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(
                isReceiptStep ? 'Done' : 'Continue',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

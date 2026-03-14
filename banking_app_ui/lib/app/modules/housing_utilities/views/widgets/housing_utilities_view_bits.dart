import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class UtilityMiniCard extends StatelessWidget {
  final String title;
  final String value;

  const UtilityMiniCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: AppColor.secondaryLabel(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

class UtilityBoardRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const UtilityBoardRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColor.mintSoft(context).withAlpha(80)
              : AppColor.softSurface(context),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected
                ? AppColor.paymentsMint
                : AppColor.dividerColor(context),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColor.elevatedSurface(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColor.paymentsMint, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryLabel(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.secondaryLabel(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UtilityAmountRow extends StatelessWidget {
  final String amount;
  final bool selected;
  final VoidCallback onTap;

  const UtilityAmountRow({
    super.key,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColor.mintSoft(context).withAlpha(90)
              : AppColor.softSurface(context),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColor.paymentsMint
                : AppColor.dividerColor(context),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '\$$amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryLabel(context),
                ),
              ),
            ),
            Text(
              selected ? 'Selected' : 'Tap to use',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: selected
                    ? AppColor.paymentsMint
                    : AppColor.secondaryLabel(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

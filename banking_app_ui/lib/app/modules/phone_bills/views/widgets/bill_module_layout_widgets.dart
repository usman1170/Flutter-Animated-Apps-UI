import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class BillHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const BillHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.elevatedSurface(context),
              border: Border.all(color: AppColor.dividerColor(context)),
            ),
            child: Icon(
              LucideIcons.chevronLeft,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryLabel(context),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: AppColor.secondaryLabel(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BillHeroCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const BillHeroCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(context),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.dividerColor(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.blueSoft(context),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.paymentsBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColor.paymentsBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$$amount',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColor.primaryLabel(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BillSectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const BillSectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(context),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColor.dividerColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              height: 1.35,
              color: AppColor.secondaryLabel(context),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

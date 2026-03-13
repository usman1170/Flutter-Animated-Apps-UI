import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentsSection extends StatelessWidget {
  final String title;
  final String actionLabel;
  final List<PaymentSectionItem> items;

  const PaymentsSection({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryLabel(context),
                ),
              ),
              Text(
                actionLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _PaymentCard(item: item);
            },
          ),
        ),
      ],
    );
  }
}

class PaymentSectionItem {
  final PaymentSectionIcon iconKey;
  final String label;

  const PaymentSectionItem({required this.iconKey, required this.label});
}

enum PaymentSectionIcon { transfer, card, user, phone, internet, home }

class _PaymentCard extends StatelessWidget {
  final PaymentSectionItem item;

  const _PaymentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _resolveIcon(item.iconKey),
            size: 28,
            color: AppColor.paymentsBlue,
          ),
          const SizedBox(height: 28),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: AppColor.primaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }

  IconData _resolveIcon(PaymentSectionIcon icon) {
    switch (icon) {
      case PaymentSectionIcon.transfer:
        return LucideIcons.refreshCcw;
      case PaymentSectionIcon.card:
        return LucideIcons.creditCard;
      case PaymentSectionIcon.user:
        return LucideIcons.userPlus;
      case PaymentSectionIcon.phone:
        return LucideIcons.smartphone;
      case PaymentSectionIcon.internet:
        return LucideIcons.wifi;
      case PaymentSectionIcon.home:
        return LucideIcons.home;
    }
  }
}

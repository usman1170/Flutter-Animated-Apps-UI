import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class CardDetailsHistoryBlock extends StatelessWidget {
  const CardDetailsHistoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textStrong,
                ),
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.paymentsBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            decoration: BoxDecoration(
              color: AppColor.surfaceSoft,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              children: [
                _HistoryItem(
                  icon: LucideIcons.arrowDownCircle,
                  title: 'George P.',
                  subtitle: 'April 13 • By card number',
                  amount: '+ \$ 7 292.07',
                  amountColor: AppColor.successGreen,
                  iconBg: AppColor.white,
                  iconColor: AppColor.textStrong,
                ),
                SizedBox(height: 18),
                _HistoryItem(
                  title: 'Yerevan City',
                  subtitle: 'April 13 • Supermarkets',
                  amount: '\$ 292.07',
                  customBadge: _LogoBadge(
                    text: 'CITY',
                    bg: AppColor.masterCardRed,
                  ),
                ),
                SizedBox(height: 18),
                _HistoryItem(
                  title: 'Talixo',
                  subtitle: 'April 13 • Taxi',
                  amount: '\$ 192.07',
                  customBadge: _IconBadge(icon: LucideIcons.slidersHorizontal),
                ),
                SizedBox(height: 18),
                _HistoryItem(
                  title: 'Jacobs Kitchen',
                  subtitle: 'April 13 • By card number',
                  amount: '\$ 22.07',
                  customBadge: _LogoBadge(text: 'JACOBS', bg: AppColor.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;
  final Color iconBg;
  final Color iconColor;
  final Widget? customBadge;

  const _HistoryItem({
    this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.amountColor = AppColor.textStrong,
    this.iconBg = AppColor.white,
    this.iconColor = AppColor.textStrong,
    this.customBadge,
  });

  @override
  Widget build(BuildContext context) {
    final badge =
        customBadge ??
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 24, color: iconColor),
        );

    return Row(
      children: [
        badge,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textStrong,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondaryText,
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: amountColor,
          ),
        ),
      ],
    );
  }
}

class _LogoBadge extends StatelessWidget {
  final String text;
  final Color bg;

  const _LogoBadge({required this.text, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;

  const _IconBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, size: 22, color: AppColor.white),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

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
                  color: Color(0xFF16181D),
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4F97EA),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                _HistoryRow(
                  leading: _IncomingBadge(),
                  title: 'George P.',
                  subtitle: 'April 13 • By card number',
                  amount: '+ \$ 7 292.07',
                  amountColor: Color(0xFF2DC95C),
                ),
                SizedBox(height: 18),
                _HistoryRow(
                  leading: _MerchantBadge(
                    backgroundColor: Color(0xFFBF0010),
                    child: Text(
                      'CITY',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  title: 'Yerevan City',
                  subtitle: 'April 13 • Supermarkets',
                  amount: '\$ 292.07',
                ),
                SizedBox(height: 18),
                _HistoryRow(
                  leading: _MerchantBadge(
                    backgroundColor: AppColor.black,
                    child: Icon(
                      LucideIcons.slidersHorizontal,
                      color: AppColor.white,
                      size: 20,
                    ),
                  ),
                  title: 'Talixo',
                  subtitle: 'April 13 • Taxi',
                  amount: '\$ 192.07',
                ),
                SizedBox(height: 18),
                _HistoryRow(
                  leading: _MerchantBadge(
                    backgroundColor: AppColor.black,
                    child: Text(
                      'JACOBS\nKITCHEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 7,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  title: 'Jacobs Kitchen',
                  subtitle: 'April 13 • By card number',
                  amount: '\$ 22.07',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  const _HistoryRow({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.amountColor = const Color(0xFF1E2127),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E2127),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF7B7C80),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          amount,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: amountColor,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

class _IncomingBadge extends StatelessWidget {
  const _IncomingBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: Icon(
          LucideIcons.arrowDownCircle,
          size: 24,
          color: Color(0xFF23262B),
        ),
      ),
    );
  }
}

class _MerchantBadge extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const _MerchantBadge({required this.backgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: child),
    );
  }
}

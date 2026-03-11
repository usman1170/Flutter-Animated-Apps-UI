import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoansSection extends StatelessWidget {
  const LoansSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Loans'),
        SizedBox(height: 12),
        _FinanceTile(
          icon: LucideIcons.walletCards,
          amount: '\$ 10,000',
          subtitle: 'Pre-approved for any purpose',
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF16181D),
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}

class _FinanceTile extends StatelessWidget {
  final IconData icon;
  final String amount;
  final String subtitle;

  const _FinanceTile({
    required this.icon,
    required this.amount,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECFA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(icon, color: const Color(0xFF4188D9), size: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E2127),
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
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
            const Icon(
              LucideIcons.chevronRight,
              size: 26,
              color: Color(0xFFABACB0),
            ),
          ],
        ),
      ),
    );
  }
}

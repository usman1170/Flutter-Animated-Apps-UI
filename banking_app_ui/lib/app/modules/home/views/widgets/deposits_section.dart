import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DepositsSection extends StatelessWidget {
  const DepositsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: 'Deposits'),
        SizedBox(height: 12),
        _DepositTile(amount: '\$ 7,341', subtitle: '10% annual return'),
        SizedBox(height: 12),
        _DepositTile(amount: '€ 4,500', subtitle: '8.5% annual return'),
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

class _DepositTile extends StatelessWidget {
  final String amount;
  final String subtitle;

  const _DepositTile({required this.amount, required this.subtitle});

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
              child: const Center(
                child: Icon(
                  LucideIcons.badgeDollarSign,
                  color: Color(0xFF4188D9),
                  size: 24,
                ),
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

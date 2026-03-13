import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class TransferAccountCard extends StatelessWidget {
  final String title;
  final String balance;
  final IconData icon;
  final Color accent;
  final bool selected;
  final VoidCallback onTap;

  const TransferAccountCard({
    super.key,
    required this.title,
    required this.balance,
    required this.icon,
    required this.accent,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? accent.withAlpha(18)
              : AppColor.softSurface(context),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? accent.withAlpha(160)
                : AppColor.dividerColor(context),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: accent.withAlpha(34),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: selected
                    ? accent.withAlpha(22)
                    : AppColor.elevatedSurface(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 22),
            ),
            const SizedBox(width: 14),
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
                  const SizedBox(height: 6),
                  Text(
                    balance,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondaryLabel(context),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? accent.withAlpha(28)
                    : AppColor.elevatedSurface(context),
                border: Border.all(
                  color: selected ? accent : AppColor.dividerColor(context),
                ),
              ),
              child: selected
                  ? Icon(LucideIcons.check, size: 15, color: accent)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

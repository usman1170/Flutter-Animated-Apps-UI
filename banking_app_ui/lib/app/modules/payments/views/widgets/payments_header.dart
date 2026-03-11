import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentsHeader extends StatelessWidget {
  const PaymentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'Payments',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: AppColor.textStrong,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _CircleButton(icon: LucideIcons.moreVertical),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;

  const _CircleButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: AppColor.surfaceMuted,
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(icon, size: 22, color: AppColor.iconDark)),
    );
  }
}

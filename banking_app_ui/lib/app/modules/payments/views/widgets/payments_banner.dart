import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentsBanner extends StatelessWidget {
  const PaymentsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 154,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.paymentsBlueSoft,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 20,
              top: 28,
              child: Text(
                'Loan Approved',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textStrong,
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 74,
              child: Text(
                'You’ve got a pre-\napproved loan!',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textMid,
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 28,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(190),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.x,
                  size: 18,
                  color: AppColor.textMuted,
                ),
              ),
            ),
            const Positioned(right: 30, bottom: 12, child: _LoanApprovedArt()),
          ],
        ),
      ),
    );
  }
}

class _LoanApprovedArt extends StatelessWidget {
  const _LoanApprovedArt();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 122,
      child: Stack(
        children: [
          const Positioned(left: 12, top: 22, child: _CashStack()),
          const Positioned(left: 62, top: 8, child: _CashStack()),
          const Positioned(left: 98, top: 50, child: _CashStack()),
          Positioned(
            left: 86,
            top: 14,
            child: Transform.rotate(
              angle: 0.16,
              child: Container(
                width: 58,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColor.paymentsBlueCard,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withAlpha(18),
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 116,
            top: 28,
            child: Transform.rotate(
              angle: 0.78,
              child: Icon(
                LucideIcons.check,
                size: 54,
                color: AppColor.surfaceMint.withAlpha(220),
              ),
            ),
          ),
          Positioned(
            left: 92,
            top: 0,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withAlpha(18),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                LucideIcons.coins,
                size: 18,
                color: AppColor.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CashStack extends StatelessWidget {
  const _CashStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 42,
      child: Stack(
        children: [
          Positioned(
            left: 4,
            top: 10,
            child: Container(
              width: 58,
              height: 26,
              decoration: BoxDecoration(
                color: AppColor.white.withAlpha(235),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 6,
            child: Container(
              width: 58,
              height: 26,
              decoration: BoxDecoration(
                color: AppColor.white.withAlpha(245),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          Container(
            width: 58,
            height: 26,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withAlpha(10),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

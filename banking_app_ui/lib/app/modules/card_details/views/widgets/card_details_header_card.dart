import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';

class CardDetailsHeaderCard extends StatelessWidget {
  final CardDetailsController controller;

  const CardDetailsHeaderCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = AppColor.bankCardGradient(
      context,
      isCredit: controller.isCredit,
    );

    return Hero(
      tag: controller.heroTag,
      child: Material(
        color: AppColor.transparent,
        child: Container(
          height: 154,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondaryLabel(context),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                controller.holderName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryLabel(context),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  _MasterBadge(compact: !controller.isCredit),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.cardDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '••• 5567',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MasterBadge extends StatelessWidget {
  final bool compact;

  const _MasterBadge({required this.compact});

  @override
  Widget build(BuildContext context) {
    final dotSize = compact ? 16.0 : 20.0;
    final width = compact ? 24.0 : 30.0;
    final overlap = compact ? 8.0 : 10.0;

    return SizedBox(
      width: width,
      height: dotSize,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: const BoxDecoration(
                color: AppColor.masterCardRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: overlap,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: AppColor.masterCardOrange.withAlpha(210),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

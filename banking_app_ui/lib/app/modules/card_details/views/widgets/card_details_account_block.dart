import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';

class CardDetailsAccountBlock extends GetView<CardDetailsController> {
  const CardDetailsAccountBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryLabel(context),
            ),
          ),
          const SizedBox(height: 16),
          _detailTile(context, controller.limitLabel, controller.limitValue),
          const SizedBox(height: 10),
          _detailTile(context, controller.debtLabel, controller.debtValue),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.softSurface(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.freezeLabel,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryLabel(context),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        controller.toggleFreeze(!controller.isFrozen.value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      width: 70,
                      height: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: controller.isFrozen.value
                            ? LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: controller.isCredit
                                    ? const [
                                        AppColor.paymentsBlue,
                                        AppColor.accentBlue,
                                      ]
                                    : const [
                                        AppColor.paymentsMint,
                                        AppColor.successGreen,
                                      ],
                              )
                            : null,
                        color: controller.isFrozen.value
                            ? null
                            : AppColor.mutedSurface(context),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: controller.isFrozen.value
                              ? AppColor.transparent
                              : AppColor.transparent,
                          width: 1.2,
                        ),
                        boxShadow: controller.isFrozen.value
                            ? [
                                BoxShadow(
                                  color:
                                      (controller.isCredit
                                              ? AppColor.paymentsBlue
                                              : AppColor.paymentsMint)
                                          .withAlpha(70),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: AppColor.elevatedSurface(
                                    context,
                                  ).withAlpha(180),
                                  blurRadius: 10,
                                  offset: const Offset(0, 1),
                                  spreadRadius: -2,
                                ),
                              ],
                      ),
                      child: Stack(
                        children: [
                          if (!controller.isFrozen.value)
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: AppColor.tertiaryLabel(context),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            alignment: controller.isFrozen.value
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColor.elevatedSurface(context),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: controller.isFrozen.value
                                        ? AppColor.black.withAlpha(26)
                                        : AppColor.black.withAlpha(14),
                                    blurRadius: controller.isFrozen.value
                                        ? 10
                                        : 14,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                controller.isFrozen.value
                                    ? Icons.lock
                                    : Icons.lock_open_rounded,
                                size: 16,
                                color: controller.isFrozen.value
                                    ? (controller.isCredit
                                          ? AppColor.paymentsBlue
                                          : AppColor.paymentsMint)
                                    : AppColor.tertiaryLabel(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _arrowTile(context, 'Limits'),
          const SizedBox(height: 10),
          _arrowTile(context, 'Terms and Conditions'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.softSurface(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Bank Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryLabel(context),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        controller.detailsShareText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryLabel(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.externalLink,
                  size: 22,
                  color: AppColor.tertiaryLabel(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailTile(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLabel(context),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowTile(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.primaryLabel(context),
              ),
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 22,
            color: AppColor.tertiaryLabel(context),
          ),
        ],
      ),
    );
  }
}

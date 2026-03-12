import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/card_details_controller.dart';
import 'widgets/card_details_account_block.dart';
import 'widgets/card_details_history_block.dart';
import 'widgets/card_details_overview_section.dart';
import 'widgets/card_details_spending_section.dart';

class CardDetailsView extends GetView<CardDetailsController> {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bgTop = controller.isCredit
        ? AppColor.pageBlueTop
        : AppColor.pageGreenTop;
    final bgBottom = controller.isCredit
        ? AppColor.pageBlueBottom
        : AppColor.pageGreenBottom;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Container(
            height: 420,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bgTop, bgBottom],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: Row(
                      children: [
                        _topButton(LucideIcons.chevronLeft, Get.back),
                        Expanded(
                          child: Center(
                            child: Text(
                              controller.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textStrong,
                              ),
                            ),
                          ),
                        ),
                        _topButton(LucideIcons.moreVertical, null),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 38, 20, 0),
                    child: CardDetailsOverviewSection(controller: controller),
                  ),
                  const SizedBox(height: 30),
                  const CardDetailsSpendingSection(),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.paymentTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textStrong,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.surfaceSoft,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.surfaceMint,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(26),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  LucideIcons.power,
                                  size: 20,
                                  color: AppColor.successGreen,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    controller.paymentBanner,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.successGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.paymentAmount,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textStrong,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: AppColor.mutedBorder,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        LucideIcons.helpCircle,
                                        size: 18,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  controller.paymentText,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.secondaryText,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.paymentsBlue,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Pay Now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.surfaceSoft,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Autopay',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textStrong,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Set up autopay to automatically cover card payments and pay fines',
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            LucideIcons.chevronRight,
                            size: 24,
                            color: AppColor.iconGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const CardDetailsHistoryBlock(),
                  const SizedBox(height: 28),
                  const CardDetailsAccountBlock(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24, color: AppColor.textStrong),
      ),
    );
  }
}

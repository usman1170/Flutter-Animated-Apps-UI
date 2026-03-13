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
    return Scaffold(
      backgroundColor: AppColor.screenBackground(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColor.detailsPageGradient(
                    context,
                    isCredit: controller.isCredit,
                  ),
                  stops: const [0, 0.42, 0.72, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 18),
                  child: Row(
                    children: [
                      _topButton(LucideIcons.chevronLeft, Get.back),
                      Expanded(
                        child: Center(
                          child: Text(
                            controller.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryLabel(context),
                            ),
                          ),
                        ),
                      ),
                      _topButton(LucideIcons.moreVertical, null),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: CardDetailsOverviewSection(
                            controller: controller,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CardDetailsSpendingSection(controller: controller),
                        const SizedBox(height: 28),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            controller.paymentTitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColor.primaryLabel(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.softSurface(context),
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
                                    color: AppColor.mintSoft(context),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(26),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        controller.isCredit
                                            ? LucideIcons.power
                                            : LucideIcons.shieldCheck,
                                        size: 20,
                                        color: controller.isCredit
                                            ? AppColor.successGreen
                                            : AppColor.paymentsMint,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          controller.paymentBanner,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: controller.isCredit
                                                ? AppColor.successGreen
                                                : AppColor.paymentsMint,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.paymentAmount,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.primaryLabel(
                                                  context,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 34,
                                            height: 34,
                                            decoration: BoxDecoration(
                                              color: AppColor.mutedSurface(
                                                context,
                                              ),
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
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.45,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.secondaryLabel(
                                            context,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller.isCredit
                                              ? AppColor.paymentsBlue
                                              : AppColor.paymentsMint,
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.primaryButtonLabel,
                                            style: const TextStyle(
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
                              color: AppColor.softSurface(context),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.autopayTitle,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.primaryLabel(context),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        controller.autopayText,
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1.45,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.secondaryLabel(
                                            context,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  LucideIcons.chevronRight,
                                  size: 24,
                                  color: AppColor.tertiaryLabel(context),
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
        decoration: BoxDecoration(
          color: AppColor.elevatedSurface(Get.context!),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24, color: AppColor.primaryLabel(Get.context!)),
      ),
    );
  }
}

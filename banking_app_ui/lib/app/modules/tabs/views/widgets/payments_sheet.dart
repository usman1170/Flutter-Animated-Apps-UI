import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../payments/views/widgets/payments_banner.dart';
import '../../../payments/views/widgets/payments_favorites_panel.dart';
import '../../../payments/views/widgets/payments_section.dart';
import '../../../payments/views/widgets/transfer_flow_models.dart';

class PaymentsSheet extends StatelessWidget {
  const PaymentsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.sheetSurface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(AppColor.isDark(context) ? 42 : 14),
            blurRadius: 24,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        child: Stack(
          children: [
            const Positioned.fill(child: _PaymentsSheetBackdrop()),
            Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColor.dividerColor(context),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),
                const _SheetHeader(),
                const SizedBox(height: 16),
                const Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PaymentsFavoritesPanel(),
                        SizedBox(height: 18),
                        PaymentsSection(
                          title: 'Transfer Money',
                          actionLabel: 'All',
                          onItemTap: _handleTransferAction,
                          items: [
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.transfer,
                              label: 'Between my\nAccounts',
                              action:
                                  PaymentSectionAction.transferBetweenAccounts,
                            ),
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.card,
                              label: 'By Card\nNumber',
                              action: PaymentSectionAction.transferByCardNumber,
                            ),
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.user,
                              label: 'By Account\nDetails',
                              action:
                                  PaymentSectionAction.transferByAccountDetails,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        PaymentsBanner(),
                        SizedBox(height: 24),
                        PaymentsSection(
                          title: 'Payments',
                          actionLabel: 'All',
                          items: [
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.phone,
                              label: 'Phone Bills',
                            ),
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.internet,
                              label: 'Internet & TV',
                            ),
                            PaymentSectionItem(
                              iconKey: PaymentSectionIcon.home,
                              label: 'Housing and\nutilities',
                            ),
                          ],
                        ),

                        SizedBox(height: 90),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _handleTransferAction(PaymentSectionItem item) {
  final flowType = switch (item.action) {
    PaymentSectionAction.transferBetweenAccounts =>
      TransferFlowType.betweenAccounts,
    PaymentSectionAction.transferByCardNumber => TransferFlowType.byCardNumber,
    PaymentSectionAction.transferByAccountDetails =>
      TransferFlowType.byAccountDetails,
    PaymentSectionAction.none => null,
  };

  if (flowType == null) return;

  Get.toNamed(Routes.TRANSFER_FLOW, arguments: flowType);
}

class _PaymentsSheetBackdrop extends StatelessWidget {
  const _PaymentsSheetBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -24,
          left: -12,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.blueSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 96 : 78),
            ),
          ),
        ),
        Positioned(
          top: 72,
          right: -46,
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.mintSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 98 : 84),
            ),
          ),
        ),
        Positioned(
          left: 130,
          bottom: 120,
          child: Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.lavenderSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 90 : 68),
            ),
          ),
        ),
      ],
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: AppColor.elevatedSurface(
            context,
          ).withAlpha(AppColor.isDark(context) ? 224 : 204),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AppColor.dividerColor(
              context,
            ).withAlpha(AppColor.isDark(context) ? 160 : 120),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColor.paymentsBlue.withAlpha(24),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    LucideIcons.creditCard,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payments Hub',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryLabel(context),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Shortcuts, bills and money movement in one layer',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryLabel(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(
                  child: _HeaderMetric(
                    label: 'Ready bills',
                    value: '04',
                    accent: AppColor.badgeRed,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _HeaderMetric(
                    label: 'Fast actions',
                    value: '08',
                    accent: AppColor.paymentsBlue,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _HeaderMetric(
                    label: 'Monthly flow',
                    value: '+12%',
                    accent: AppColor.successGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color accent;

  const _HeaderMetric({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.elevatedSurface(
          context,
        ).withAlpha(AppColor.isDark(context) ? 212 : 165),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryLabel(context),
            ),
          ),
        ],
      ),
    );
  }
}

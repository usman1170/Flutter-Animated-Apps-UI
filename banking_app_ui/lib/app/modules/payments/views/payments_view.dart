import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import 'widgets/transfer_flow_models.dart';
import 'widgets/payments_banner.dart';
import 'widgets/payments_favorites_panel.dart';
import 'widgets/payments_section.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.screenBackground(context),
      appBar: AppBar(
        backgroundColor: AppColor.screenBackground(context),
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 72,
        centerTitle: true,
        title: Text(
          'Payments',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryLabel(context),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColor.mutedSurface(context),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  LucideIcons.moreVertical,
                  size: 22,
                  color: AppColor.primaryLabel(context),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PaymentsFavoritesPanel(),
              const SizedBox(height: 16),
              PaymentsSection(
                title: 'Transfer Money',
                actionLabel: 'All',
                onItemTap: _handleTransferAction,
                items: [
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.transfer,
                    label: 'Between my\nAccounts',
                    action: PaymentSectionAction.transferBetweenAccounts,
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.card,
                    label: 'By Card\nNumber',
                    action: PaymentSectionAction.transferByCardNumber,
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.user,
                    label: 'By Account\nDetails',
                    action: PaymentSectionAction.transferByAccountDetails,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const PaymentsBanner(),
              const SizedBox(height: 20),
              PaymentsSection(
                title: 'Payments',
                actionLabel: 'All',
                onItemTap: _handleTransferAction,
                items: [
                  const PaymentSectionItem(
                    iconKey: PaymentSectionIcon.phone,
                    label: 'Phone Bills',
                    action: PaymentSectionAction.phoneBills,
                  ),
                  const PaymentSectionItem(
                    iconKey: PaymentSectionIcon.internet,
                    label: 'Internet & TV',
                    action: PaymentSectionAction.internetTv,
                  ),
                  const PaymentSectionItem(
                    iconKey: PaymentSectionIcon.home,
                    label: 'Housing and\nutilities',
                    action: PaymentSectionAction.housingUtilities,
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTransferAction(PaymentSectionItem item) {
    final flowType = switch (item.action) {
      PaymentSectionAction.transferBetweenAccounts =>
        TransferFlowType.betweenAccounts,
      PaymentSectionAction.transferByCardNumber =>
        TransferFlowType.byCardNumber,
      PaymentSectionAction.transferByAccountDetails =>
        TransferFlowType.byAccountDetails,
      PaymentSectionAction.phoneBills => null,
      PaymentSectionAction.internetTv => null,
      PaymentSectionAction.housingUtilities => null,
      PaymentSectionAction.none => null,
    };

    if (item.action == PaymentSectionAction.phoneBills) {
      Get.toNamed(Routes.PHONE_BILLS);
      return;
    }
    if (item.action == PaymentSectionAction.internetTv) {
      Get.toNamed(Routes.INTERNET_TV);
      return;
    }
    if (item.action == PaymentSectionAction.housingUtilities) {
      Get.toNamed(Routes.HOUSING_UTILITIES);
      return;
    }
    if (flowType == null) return;

    Get.toNamed(Routes.TRANSFER_FLOW, arguments: flowType);
  }
}

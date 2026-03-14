import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/bill_module_screen.dart';
import '../controllers/phone_bills_controller.dart';

class PhoneBillsView extends GetView<PhoneBillsController> {
  const PhoneBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BillModuleScreen(
      title: controller.preset.title,
      subtitle: controller.preset.subtitle,
      heroTitle: controller.preset.dueLabel,
      heroIcon: controller.preset.heroIcon,
      submitLabel: 'Pay Phone Bill',
      selectedAmount: controller.selectedAmount,
      providers: controller.preset.providers,
      selectedProvider: controller.selectedProvider,
      amountOptions: controller.amountOptions,
      accountController: controller.accountController,
      amountController: controller.amountController,
      accountLabel: controller.preset.accountLabel,
      sectionTitle: controller.preset.sectionTitle,
      sectionSubtitle: controller.preset.helperText,
      autopayEnabled: controller.autoPayEnabled,
      onBack: Get.back<void>,
      onProviderTap: controller.selectProvider,
      onAmountTap: controller.selectAmount,
      onAmountChanged: controller.updateAmount,
      onAccountChanged: controller.updateAccount,
      onAutopayChanged: controller.toggleAutopay,
      onSubmit: controller.submitPayment,
    );
  }
}

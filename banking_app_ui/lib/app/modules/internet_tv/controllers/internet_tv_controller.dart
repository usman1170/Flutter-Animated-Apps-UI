import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/bill_payment_catalog.dart';

class InternetTvController extends GetxController {
  final preset = BillPaymentCatalog.internetTv;
  final selectedProvider = 'StormFiber'.obs;
  final selectedAmount = '46.90'.obs;
  final accountValue = 'CUS-389201'.obs;
  final autoPayEnabled = true.obs;
  final accountController = TextEditingController(text: 'CUS-389201');
  final amountController = TextEditingController(text: '46.90');

  List<String> get amountOptions => const ['28.00', '46.90', '64.00', '92.00'];

  @override
  void onClose() {
    accountController.dispose();
    amountController.dispose();
    super.onClose();
  }

  void selectProvider(String provider) => selectedProvider.value = provider;

  void selectAmount(String amount) {
    selectedAmount.value = amount;
    amountController.text = amount;
  }

  void updateAmount(String amount) {
    selectedAmount.value = amount.isEmpty ? '0.00' : amount;
  }

  void updateAccount(String value) {
    accountValue.value = value;
  }

  void toggleAutopay(bool value) => autoPayEnabled.value = value;

  void submitPayment() {
    Get.snackbar(
      'Internet bill ready',
      'Payment prepared for ${selectedProvider.value}.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}

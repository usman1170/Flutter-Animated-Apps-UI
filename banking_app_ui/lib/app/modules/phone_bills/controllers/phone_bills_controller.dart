import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/bill_payment_catalog.dart';

class PhoneBillsController extends GetxController {
  final preset = BillPaymentCatalog.phoneBills;
  final selectedProvider = 'Jazz'.obs;
  final selectedAmount = '24.50'.obs;
  final accountValue = '0300 1234567'.obs;
  final autoPayEnabled = false.obs;
  final accountController = TextEditingController(text: '0300 1234567');
  final amountController = TextEditingController(text: '24.50');

  List<String> get amountOptions => const ['12.00', '24.50', '35.00', '50.00'];

  @override
  void onClose() {
    accountController.dispose();
    amountController.dispose();
    super.onClose();
  }

  void selectProvider(String provider) {
    selectedProvider.value = provider;
  }

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

  void toggleAutopay(bool value) {
    autoPayEnabled.value = value;
  }

  void submitPayment() {
    Get.snackbar(
      'Phone bill ready',
      'Payment prepared for ${selectedProvider.value}.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}

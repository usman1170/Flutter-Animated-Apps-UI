import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/bill_payment_catalog.dart';

class HousingUtilitiesController extends GetxController {
  final preset = BillPaymentCatalog.housingUtilities;
  final selectedProvider = 'K-Electric'.obs;
  final selectedAmount = '82.15'.obs;
  final accountValue = 'REF-77492018'.obs;
  final autoPayEnabled = false.obs;
  final accountController = TextEditingController(text: 'REF-77492018');
  final amountController = TextEditingController(text: '82.15');

  List<String> get amountOptions => const ['32.00', '52.50', '82.15', '120.00'];

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
      'Utility bill ready',
      'Payment prepared for ${selectedProvider.value}.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}

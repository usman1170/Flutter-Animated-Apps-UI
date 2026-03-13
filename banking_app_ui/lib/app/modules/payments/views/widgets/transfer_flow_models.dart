import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

enum TransferFlowType { betweenAccounts, byCardNumber, byAccountDetails }

extension TransferFlowTypeX on TransferFlowType {
  String get title {
    switch (this) {
      case TransferFlowType.betweenAccounts:
        return 'Between My Accounts';
      case TransferFlowType.byCardNumber:
        return 'Transfer By Card';
      case TransferFlowType.byAccountDetails:
        return 'Transfer By Account';
    }
  }

  String get subtitle {
    switch (this) {
      case TransferFlowType.betweenAccounts:
        return 'Move funds across your own balances in a guided flow.';
      case TransferFlowType.byCardNumber:
        return 'Send money by card number with verification and OTP.';
      case TransferFlowType.byAccountDetails:
        return 'Choose a bank, add beneficiary details, then confirm.';
    }
  }

  IconData get icon {
    switch (this) {
      case TransferFlowType.betweenAccounts:
        return LucideIcons.refreshCcw;
      case TransferFlowType.byCardNumber:
        return LucideIcons.creditCard;
      case TransferFlowType.byAccountDetails:
        return LucideIcons.landmark;
    }
  }

  Color get accent {
    switch (this) {
      case TransferFlowType.betweenAccounts:
        return AppColor.paymentsMint;
      case TransferFlowType.byCardNumber:
        return AppColor.paymentsBlue;
      case TransferFlowType.byAccountDetails:
        return AppColor.paymentsBlue;
    }
  }

  List<String> get steps {
    switch (this) {
      case TransferFlowType.betweenAccounts:
        return const ['Accounts', 'Verify', 'Amount', 'OTP', 'Receipt'];
      case TransferFlowType.byCardNumber:
        return const ['Recipient', 'Verify', 'Amount', 'OTP', 'Receipt'];
      case TransferFlowType.byAccountDetails:
        return const ['Bank', 'Details', 'Verify', 'Amount', 'OTP', 'Receipt'];
    }
  }
}

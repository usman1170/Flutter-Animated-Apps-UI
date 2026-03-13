import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'transfer_flow_form_bits.dart';
import 'transfer_flow_form_controls.dart';
import 'transfer_flow_models.dart';
import 'transfer_flow_setup_steps.dart';
import 'transfer_flow_surface.dart';

class TransferFlowForms extends StatelessWidget {
  final TransferFlowType type;
  final int currentStep;
  final String selectedBank;
  final String fromAccount;
  final String toAccount;
  final TextEditingController amountController;
  final TextEditingController otpController;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController bankAccountController;
  final TextEditingController accountTitleController;
  final TextEditingController purposeController;
  final ValueChanged<String> onBankChanged;
  final ValueChanged<String> onFromChanged;
  final ValueChanged<String> onToChanged;

  const TransferFlowForms({
    super.key,
    required this.type,
    required this.currentStep,
    required this.selectedBank,
    required this.fromAccount,
    required this.toAccount,
    required this.amountController,
    required this.otpController,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.bankAccountController,
    required this.accountTitleController,
    required this.purposeController,
    required this.onBankChanged,
    required this.onFromChanged,
    required this.onToChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TransferGlassCard(child: _content(context));
  }

  Widget _content(BuildContext context) {
    if (type == TransferFlowType.byAccountDetails && currentStep == 0) {
      return TransferBankStep(
        selectedBank: selectedBank,
        accent: type.accent,
        onChanged: onBankChanged,
      );
    }
    if (type == TransferFlowType.byAccountDetails && currentStep == 1) {
      return TransferAccountDetailsStep(
        bankAccountController: bankAccountController,
        accountTitleController: accountTitleController,
        purposeController: purposeController,
      );
    }
    if (type == TransferFlowType.betweenAccounts && currentStep == 0) {
      return TransferAccountsStep(
        fromAccount: fromAccount,
        toAccount: toAccount,
        accent: type.accent,
        onFromChanged: onFromChanged,
        onToChanged: onToChanged,
      );
    }
    if (type == TransferFlowType.byCardNumber && currentStep == 0) {
      return TransferCardSetupStep(
        cardNumberController: cardNumberController,
        cardHolderController: cardHolderController,
        purposeController: purposeController,
      );
    }
    if (currentStep == type.steps.length - 3) return _amountStep(context);
    if (currentStep == type.steps.length - 2) return _otpStep(context);
    return _verifyStep(context);
  }

  Widget _verifyStep(BuildContext context) {
    final rows = _verifyRows();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Verify details',
          subtitle: 'Confirm the route before entering amount and OTP.',
        ),
        const SizedBox(height: 18),
        ...rows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: TransferFormDetailRow(label: row.$1, value: row.$2),
          ),
        ),
        const SizedBox(height: 4),
        TransferInfoBanner(
          label:
              'Verified destination. Transfer will complete after OTP approval.',
          icon: LucideIcons.badgeCheck,
        ),
      ],
    );
  }

  Widget _amountStep(BuildContext context) {
    const amounts = ['500', '1200', '2450', '5000'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Transfer amount',
          subtitle: 'Quick amounts keep the same visual flow and receipt.',
        ),
        const SizedBox(height: 18),
        TransferField(
          label: 'Amount',
          icon: LucideIcons.badgeDollarSign,
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: amounts
              .map(
                (item) => TransferAmountChip(
                  label: '\$$item',
                  selected: amountController.text == item,
                  accent: type.accent,
                  onTap: () => amountController.text = item,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _otpStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Enter OTP',
          subtitle: 'Use the secure code sent to your registered device.',
        ),
        const SizedBox(height: 18),
        TransferField(
          label: 'OTP code',
          icon: LucideIcons.lock,
          controller: otpController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TransferInfoBanner(
          label: 'Demo code is 4582. This keeps testing the flow simple.',
          icon: LucideIcons.smartphone,
        ),
      ],
    );
  }

  List<(String, String)> _verifyRows() {
    if (type == TransferFlowType.betweenAccounts) {
      return [
        ('From', fromAccount),
        ('To', toAccount),
        ('Route', 'Internal instant transfer'),
        ('Reference', purposeController.text),
      ];
    }
    if (type == TransferFlowType.byCardNumber) {
      return [
        ('Card', cardNumberController.text),
        ('Recipient', cardHolderController.text),
        ('Route', 'Card to card payout'),
        ('Reference', purposeController.text),
      ];
    }
    return [
      ('Bank', selectedBank),
      ('Beneficiary', accountTitleController.text),
      ('Account', bankAccountController.text),
      ('Reference', purposeController.text),
    ];
  }
}

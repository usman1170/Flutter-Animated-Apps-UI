import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import 'transfer_flow_bank_picker.dart';
import 'transfer_flow_form_bits.dart';
import 'transfer_flow_form_controls.dart';
import 'transfer_flow_transfer_account_card.dart';

class TransferBankStep extends StatelessWidget {
  final String selectedBank;
  final Color accent;
  final ValueChanged<String> onChanged;

  const TransferBankStep({
    super.key,
    required this.selectedBank,
    required this.accent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Select bank',
          subtitle: 'Choose where the beneficiary account is held.',
        ),
        const SizedBox(height: 18),
        TransferBankPicker(
          selectedBank: selectedBank,
          accent: accent,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class TransferAccountDetailsStep extends StatelessWidget {
  final TextEditingController bankAccountController;
  final TextEditingController accountTitleController;
  final TextEditingController purposeController;

  const TransferAccountDetailsStep({
    super.key,
    required this.bankAccountController,
    required this.accountTitleController,
    required this.purposeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Beneficiary details',
          subtitle: 'These details will appear inside the receipt.',
        ),
        const SizedBox(height: 18),
        TransferField(
          label: 'Account / IBAN',
          icon: LucideIcons.hash,
          controller: bankAccountController,
        ),
        const SizedBox(height: 14),
        TransferField(
          label: 'Account title',
          icon: LucideIcons.user,
          controller: accountTitleController,
        ),
        const SizedBox(height: 14),
        TransferField(
          label: 'Purpose',
          icon: LucideIcons.fileText,
          controller: purposeController,
        ),
      ],
    );
  }
}

class TransferAccountsStep extends StatelessWidget {
  final String fromAccount;
  final String toAccount;
  final Color accent;
  final ValueChanged<String> onFromChanged;
  final ValueChanged<String> onToChanged;

  const TransferAccountsStep({
    super.key,
    required this.fromAccount,
    required this.toAccount,
    required this.accent,
    required this.onFromChanged,
    required this.onToChanged,
  });

  @override
  Widget build(BuildContext context) {
    final accounts = <({String title, String balance, IconData icon})>[
      (
        title: 'Daily Spending • 1834',
        balance: '\$2,450',
        icon: LucideIcons.wallet,
      ),
      (
        title: 'Salary Plus • 4402',
        balance: '\$8,920',
        icon: LucideIcons.briefcase,
      ),
      (
        title: 'Savings Vault • 9921',
        balance: '\$15,340',
        icon: LucideIcons.piggyBank,
      ),
      (
        title: 'Travel Buffer • 0058',
        balance: '\$1,280',
        icon: LucideIcons.luggage,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Select accounts',
          subtitle: 'Move funds between your own balances.',
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accent.withAlpha(12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accent.withAlpha(64)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withAlpha(24),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.arrowRightLeft,
                  color: accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Select where money moves from and where it lands.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryLabel(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const TransferFormLabel(text: 'From'),
        const SizedBox(height: 12),
        ...accounts.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransferAccountCard(
              title: item.title,
              balance: item.balance,
              icon: item.icon,
              accent: accent,
              selected: fromAccount == item.title,
              onTap: () => onFromChanged(item.title),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.softSurface(context),
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.dividerColor(context)),
            ),
            child: Icon(LucideIcons.moveDown, color: accent, size: 22),
          ),
        ),
        const SizedBox(height: 16),
        const TransferFormLabel(text: 'To'),
        const SizedBox(height: 12),
        ...accounts.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransferAccountCard(
              title: item.title,
              balance: item.balance,
              icon: item.icon,
              accent: accent,
              selected: toAccount == item.title,
              onTap: () => onToChanged(item.title),
            ),
          ),
        ),
      ],
    );
  }
}

class TransferCardSetupStep extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController purposeController;

  const TransferCardSetupStep({
    super.key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.purposeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Recipient details',
          subtitle: 'Add the card and name before verification.',
        ),
        const SizedBox(height: 18),
        TransferField(
          label: 'Card number',
          icon: LucideIcons.creditCard,
          controller: cardNumberController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 14),
        TransferField(
          label: 'Recipient name',
          icon: LucideIcons.user,
          controller: cardHolderController,
        ),
        const SizedBox(height: 14),
        TransferField(
          label: 'Purpose',
          icon: LucideIcons.fileText,
          controller: purposeController,
        ),
      ],
    );
  }
}

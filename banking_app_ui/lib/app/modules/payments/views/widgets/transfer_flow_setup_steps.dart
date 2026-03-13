import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'transfer_flow_form_bits.dart';
import 'transfer_flow_form_controls.dart';

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
    const banks = [
      'Habib Bank',
      'Meezan Bank',
      'United Bank',
      'Standard Chartered',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Select bank',
          subtitle: 'Choose where the beneficiary account is held.',
        ),
        const SizedBox(height: 18),
        ...banks.map(
          (bank) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransferSelectTile(
              label: bank,
              icon: LucideIcons.landmark,
              selected: selectedBank == bank,
              accent: accent,
              onTap: () => onChanged(bank),
            ),
          ),
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
    const accounts = [
      'Daily Spending • 1834',
      'Salary Plus • 4402',
      'Savings Vault • 9921',
      'Travel Buffer • 0058',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferFormTitle(
          title: 'Select accounts',
          subtitle: 'Move funds between your own balances.',
        ),
        const SizedBox(height: 18),
        const TransferFormLabel(text: 'From'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: accounts
              .map(
                (item) => TransferChipCard(
                  label: item,
                  selected: fromAccount == item,
                  accent: accent,
                  onTap: () => onFromChanged(item),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        const TransferFormLabel(text: 'To'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: accounts
              .map(
                (item) => TransferChipCard(
                  label: item,
                  selected: toAccount == item,
                  accent: accent,
                  onTap: () => onToChanged(item),
                ),
              )
              .toList(),
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

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'transfer_flow_form_controls.dart';

class TransferBankPicker extends StatefulWidget {
  final String selectedBank;
  final Color accent;
  final ValueChanged<String> onChanged;

  const TransferBankPicker({
    super.key,
    required this.selectedBank,
    required this.accent,
    required this.onChanged,
  });

  @override
  State<TransferBankPicker> createState() => _TransferBankPickerState();
}

class _TransferBankPickerState extends State<TransferBankPicker> {
  final searchController = TextEditingController();

  static const banks = [
    'Habib Bank',
    'Meezan Bank',
    'United Bank',
    'Standard Chartered',
    'MCB Bank',
    'Bank Alfalah',
    'Faysal Bank',
    'Allied Bank',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.trim().toLowerCase();
    final filteredBanks = banks
        .where((bank) => bank.toLowerCase().contains(query))
        .toList();

    return Column(
      children: [
        TransferField(
          label: 'Search bank',
          icon: LucideIcons.search,
          controller: searchController,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 14),
        ...filteredBanks.map(
          (bank) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TransferSelectTile(
              label: bank,
              icon: LucideIcons.landmark,
              selected: widget.selectedBank == bank,
              accent: widget.accent,
              onTap: () => widget.onChanged(bank),
            ),
          ),
        ),
      ],
    );
  }
}

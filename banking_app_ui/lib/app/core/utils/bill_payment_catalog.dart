import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BillProviderOption {
  final String title;
  final String subtitle;
  final IconData icon;

  const BillProviderOption({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class BillPaymentPreset {
  final String title;
  final String subtitle;
  final String sectionTitle;
  final String accountLabel;
  final String helperText;
  final String amountDue;
  final String dueLabel;
  final IconData heroIcon;
  final List<BillProviderOption> providers;

  const BillPaymentPreset({
    required this.title,
    required this.subtitle,
    required this.sectionTitle,
    required this.accountLabel,
    required this.helperText,
    required this.amountDue,
    required this.dueLabel,
    required this.heroIcon,
    required this.providers,
  });
}

class BillPaymentCatalog {
  BillPaymentCatalog._();

  static const phoneBills = BillPaymentPreset(
    title: 'Phone Bills',
    subtitle: 'Recharge, clear postpaid dues, and keep numbers active.',
    sectionTitle: 'Mobile operators',
    accountLabel: 'Phone number',
    helperText: 'Saved numbers and quick recharge amounts stay ready here.',
    amountDue: '\$24.50',
    dueLabel: 'Due today',
    heroIcon: LucideIcons.smartphone,
    providers: [
      BillProviderOption(
        title: 'Jazz',
        subtitle: 'Postpaid and prepaid recharge',
        icon: LucideIcons.signalHigh,
      ),
      BillProviderOption(
        title: 'Zong',
        subtitle: 'Data, call bundles, and top-up',
        icon: LucideIcons.towerControl,
      ),
      BillProviderOption(
        title: 'Telenor',
        subtitle: 'Recharge and monthly invoice',
        icon: LucideIcons.radioTower,
      ),
      BillProviderOption(
        title: 'Ufone',
        subtitle: 'Mobile plans and bill payments',
        icon: LucideIcons.phone,
      ),
    ],
  );

  static const internetTv = BillPaymentPreset(
    title: 'Internet & TV',
    subtitle: 'Manage broadband, fiber, streaming, and TV subscriptions.',
    sectionTitle: 'Providers',
    accountLabel: 'Customer ID',
    helperText: 'Use your subscriber ID to fetch the latest due amount.',
    amountDue: '\$46.90',
    dueLabel: 'Autopay in 2 days',
    heroIcon: LucideIcons.wifi,
    providers: [
      BillProviderOption(
        title: 'StormFiber',
        subtitle: 'Fiber internet and TV service',
        icon: LucideIcons.wifi,
      ),
      BillProviderOption(
        title: 'PTCL',
        subtitle: 'Broadband and Smart TV',
        icon: LucideIcons.monitorPlay,
      ),
      BillProviderOption(
        title: 'Nayatel',
        subtitle: 'Internet, phone, and cable',
        icon: LucideIcons.router,
      ),
      BillProviderOption(
        title: 'Transworld',
        subtitle: 'Fiber home internet',
        icon: LucideIcons.radioTower,
      ),
    ],
  );

  static const housingUtilities = BillPaymentPreset(
    title: 'Housing & Utilities',
    subtitle: 'Cover electricity, gas, water, maintenance, and rent support.',
    sectionTitle: 'Utility boards',
    accountLabel: 'Reference number',
    helperText:
        'Reference IDs keep the bill fetch and receipt fields consistent.',
    amountDue: '\$82.15',
    dueLabel: '3 bills ready',
    heroIcon: LucideIcons.home,
    providers: [
      BillProviderOption(
        title: 'K-Electric',
        subtitle: 'Electricity connection bill',
        icon: LucideIcons.lightbulb,
      ),
      BillProviderOption(
        title: 'SNGPL',
        subtitle: 'Gas connection monthly dues',
        icon: LucideIcons.flame,
      ),
      BillProviderOption(
        title: 'WASA',
        subtitle: 'Water and sewerage service',
        icon: LucideIcons.droplets,
      ),
      BillProviderOption(
        title: 'Building HOA',
        subtitle: 'Maintenance and service charges',
        icon: LucideIcons.building2,
      ),
    ],
  );
}

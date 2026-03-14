import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/bill_payment_catalog.dart';
import 'bill_module_form_widgets.dart';
import 'bill_module_layout_widgets.dart';

class BillModuleScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String heroTitle;
  final IconData heroIcon;
  final String submitLabel;
  final RxString selectedAmount;
  final RxString selectedProvider;
  final RxBool autopayEnabled;
  final List<BillProviderOption> providers;
  final List<String> amountOptions;
  final TextEditingController accountController;
  final TextEditingController amountController;
  final String accountLabel;
  final String sectionTitle;
  final String sectionSubtitle;
  final VoidCallback onBack;
  final ValueChanged<String> onProviderTap;
  final ValueChanged<String> onAmountTap;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String> onAccountChanged;
  final ValueChanged<bool> onAutopayChanged;
  final VoidCallback onSubmit;

  const BillModuleScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.heroTitle,
    required this.heroIcon,
    required this.submitLabel,
    required this.selectedAmount,
    required this.selectedProvider,
    required this.autopayEnabled,
    required this.providers,
    required this.amountOptions,
    required this.accountController,
    required this.amountController,
    required this.accountLabel,
    required this.sectionTitle,
    required this.sectionSubtitle,
    required this.onBack,
    required this.onProviderTap,
    required this.onAmountTap,
    required this.onAmountChanged,
    required this.onAccountChanged,
    required this.onAutopayChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBackground(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BillHeader(title: title, subtitle: subtitle, onBack: onBack),
              const SizedBox(height: 22),
              Obx(
                () => BillHeroCard(
                  title: heroTitle,
                  amount: selectedAmount.value,
                  icon: heroIcon,
                ),
              ),
              const SizedBox(height: 18),
              BillSectionCard(
                title: sectionTitle,
                subtitle: sectionSubtitle,
                child: Obx(
                  () => Column(
                    children: providers
                        .map(
                          (provider) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: BillProviderTile(
                              title: provider.title,
                              subtitle: provider.subtitle,
                              icon: provider.icon,
                              selected:
                                  selectedProvider.value == provider.title,
                              onTap: () => onProviderTap(provider.title),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              BillSectionCard(
                title: 'Bill details',
                subtitle: 'Review the account, choose amount, and confirm.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BillField(
                      label: accountLabel,
                      icon: LucideIcons.hash,
                      controller: accountController,
                      onChanged: onAccountChanged,
                    ),
                    const SizedBox(height: 14),
                    BillField(
                      label: 'Amount',
                      icon: LucideIcons.badgeDollarSign,
                      controller: amountController,
                      onChanged: onAmountChanged,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: amountOptions
                            .map(
                              (amount) => BillAmountChip(
                                label: '\$$amount',
                                selected: selectedAmount.value == amount,
                                onTap: () => onAmountTap(amount),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => BillAutopayRow(
                        value: autopayEnabled.value,
                        onChanged: onAutopayChanged,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(58),
                    backgroundColor: AppColor.paymentsBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    submitLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

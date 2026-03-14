import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../phone_bills/views/widgets/bill_module_form_widgets.dart';
import '../../phone_bills/views/widgets/bill_module_layout_widgets.dart';
import 'widgets/housing_utilities_view_bits.dart';
import '../controllers/housing_utilities_controller.dart';

class HousingUtilitiesView extends GetView<HousingUtilitiesController> {
  const HousingUtilitiesView({super.key});

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
              BillHeader(
                title: controller.preset.title,
                subtitle: controller.preset.subtitle,
                onBack: Get.back<void>,
              ),
              const SizedBox(height: 22),
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.elevatedSurface(context),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColor.dividerColor(context)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Utility stack',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.paymentsMint,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${controller.selectedAmount.value}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primaryLabel(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Expanded(
                            child: UtilityMiniCard(
                              title: 'Electricity',
                              value: 'Live',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: UtilityMiniCard(
                              title: 'Gas',
                              value: 'Queued',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: UtilityMiniCard(
                              title: 'Water',
                              value: 'Ready',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              BillSectionCard(
                title: 'Boards & services',
                subtitle: 'Pick one bill board or maintenance service to pay.',
                child: Obx(
                  () => Column(
                    children: controller.preset.providers
                        .map(
                          (provider) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: UtilityBoardRow(
                              title: provider.title,
                              subtitle: provider.subtitle,
                              icon: provider.icon,
                              selected:
                                  controller.selectedProvider.value ==
                                  provider.title,
                              onTap: () =>
                                  controller.selectProvider(provider.title),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              BillSectionCard(
                title: 'Reference & due amount',
                subtitle:
                    'Update the billing reference and choose a payment amount.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BillField(
                      label: controller.preset.accountLabel,
                      icon: controller.preset.heroIcon,
                      controller: controller.accountController,
                      onChanged: controller.updateAccount,
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => Column(
                        children: controller.amountOptions
                            .map(
                              (amount) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: UtilityAmountRow(
                                  amount: amount,
                                  selected:
                                      controller.selectedAmount.value == amount,
                                  onTap: () => controller.selectAmount(amount),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => BillAutopayRow(
                        value: controller.autoPayEnabled.value,
                        onChanged: controller.toggleAutopay,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.submitPayment,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(58),
                    backgroundColor: AppColor.paymentsMint,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Pay Utility Bill',
                    style: TextStyle(
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

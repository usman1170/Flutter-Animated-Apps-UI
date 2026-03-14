import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../phone_bills/views/widgets/bill_module_form_widgets.dart';
import '../../phone_bills/views/widgets/bill_module_layout_widgets.dart';
import 'widgets/internet_tv_view_bits.dart';
import '../controllers/internet_tv_controller.dart';

class InternetTvView extends GetView<InternetTvController> {
  const InternetTvView({super.key});

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
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColor.elevatedSurface(context),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColor.dividerColor(context)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.selectedProvider.value,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColor.primaryLabel(context),
                              ),
                            ),
                          ),
                          Text(
                            '\$${controller.selectedAmount.value}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColor.paymentsBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fiber home line • 300 Mbps active plan',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.secondaryLabel(context),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: InternetMetric(
                              label: 'Status',
                              value: 'Online',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InternetMetric(
                              label: 'Autopay',
                              value: controller.autoPayEnabled.value
                                  ? 'Enabled'
                                  : 'Off',
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: InternetMetric(
                              label: 'Due',
                              value: '2 days',
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
                title: 'Streaming & providers',
                subtitle:
                    'Pick a provider first, then update subscriber details.',
                child: SizedBox(
                  height: 124,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.preset.providers.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final provider = controller.preset.providers[index];
                      return Obx(
                        () => InternetProviderCard(
                          title: provider.title,
                          subtitle: provider.subtitle,
                          icon: provider.icon,
                          selected:
                              controller.selectedProvider.value ==
                              provider.title,
                          onTap: () =>
                              controller.selectProvider(provider.title),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),
              BillSectionCard(
                title: 'Subscriber details',
                subtitle: 'Keep the account ID and monthly plan in sync.',
                child: Column(
                  children: [
                    BillField(
                      label: controller.preset.accountLabel,
                      icon: controller.preset.heroIcon,
                      controller: controller.accountController,
                      onChanged: controller.updateAccount,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => InternetPlanTile(
                              title: 'Current bill',
                              value: '\$${controller.selectedAmount.value}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: InternetPlanTile(
                            title: 'Bundle',
                            value: 'TV + Fiber',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.amountOptions
                            .map(
                              (amount) => BillAmountChip(
                                label: '\$$amount',
                                selected:
                                    controller.selectedAmount.value == amount,
                                onTap: () => controller.selectAmount(amount),
                              ),
                            )
                            .toList(),
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
                    backgroundColor: AppColor.paymentsBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'Pay Internet & TV',
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

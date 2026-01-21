import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';
import 'addon_chip.dart';

class AddonSection extends StatelessWidget {
  const AddonSection({super.key, required this.controller});

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add ons',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Obx(() {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.addons.map((addon) {
              final isSelected = controller.selectedAddons.contains(addon.id);
              final isPulsing = controller.lastTappedAddon.value == addon.id;
              return AddonChip(
                addon: addon,
                isSelected: isSelected,
                isPulsing: isPulsing,
                pulseController: controller.addonPulseController,
                onTap: () => controller.toggleAddon(addon),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}

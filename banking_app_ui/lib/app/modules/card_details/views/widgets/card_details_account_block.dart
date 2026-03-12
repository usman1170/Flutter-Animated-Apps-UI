import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/card_details_controller.dart';

class CardDetailsAccountBlock extends GetView<CardDetailsController> {
  const CardDetailsAccountBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.textStrong,
            ),
          ),
          const SizedBox(height: 16),
          _detailTile('Credit Limit', '\$ 3,000'),
          const SizedBox(height: 10),
          _detailTile('Debt', '\$ 459.95'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.surfaceSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(
              () => Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Freeze Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textStrong,
                      ),
                    ),
                  ),
                  Switch(
                    value: controller.isFrozen.value,
                    onChanged: controller.toggleFreeze,
                    activeThumbColor: AppColor.white,
                    activeTrackColor: AppColor.paymentsBlue,
                    inactiveThumbColor: AppColor.white,
                    inactiveTrackColor: AppColor.mutedBorder,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _arrowTile('Limits'),
          const SizedBox(height: 10),
          _arrowTile('Terms and Conditions'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.surfaceSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share Bank Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textStrong,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Share a PDF-file with bank details',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.externalLink,
                  size: 22,
                  color: AppColor.iconGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.textStrong,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrowTile(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: AppColor.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.textStrong,
              ),
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            size: 22,
            color: AppColor.iconGrey,
          ),
        ],
      ),
    );
  }
}

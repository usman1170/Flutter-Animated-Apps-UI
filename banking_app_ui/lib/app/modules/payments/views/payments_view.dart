import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/payments_banner.dart';
import 'widgets/payments_favorites_panel.dart';
import 'widgets/payments_section.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 72,
        centerTitle: true,
        title: const Text(
          'Payments',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppColor.textStrong,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColor.surfaceMuted,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  LucideIcons.moreVertical,
                  size: 22,
                  color: AppColor.iconDark,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentsFavoritesPanel(),
              SizedBox(height: 16),
              PaymentsBanner(),
              SizedBox(height: 20),
              PaymentsSection(
                title: 'Transfer Money',
                actionLabel: 'All',
                items: [
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.transfer,
                    label: 'Between my\nAccounts',
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.card,
                    label: 'By Card\nNumber',
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.user,
                    label: 'By Account\nDetails',
                  ),
                ],
              ),
              SizedBox(height: 18),
              PaymentsSection(
                title: 'Payments',
                actionLabel: 'All',
                items: [
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.phone,
                    label: 'Phone Bills',
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.internet,
                    label: 'Internet & TV',
                  ),
                  PaymentSectionItem(
                    iconKey: PaymentSectionIcon.home,
                    label: 'Housing and\nutilities',
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

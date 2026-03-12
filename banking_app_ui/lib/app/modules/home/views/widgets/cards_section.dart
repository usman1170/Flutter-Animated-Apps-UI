import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_pages.dart';

class CardsSection extends StatelessWidget {
  const CardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          _buildSideIcons(),
          const SizedBox(width: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 20),
              children: [
                _buildCreditCard(),
                const SizedBox(width: 14),
                _buildDebitCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideIcons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSideIcon(LucideIcons.creditCard),
        const SizedBox(height: 10),
        _buildSideIcon(LucideIcons.scanLine),
      ],
    );
  }

  Widget _buildSideIcon(IconData icon) {
    return Container(
      width: 44,
      height: 88,
      decoration: BoxDecoration(
        color: AppColor.greyBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.divider, width: 0.5),
      ),
      child: Center(child: Icon(icon, size: 20, color: AppColor.secondaryText)),
    );
  }

  Widget _buildCreditCard() {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.CARD_DETAILS, arguments: {'type': 'credit'}),
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.creditCardGradientStart,
              AppColor.creditCardGradientEnd,
              AppColor.creditCardGradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColor.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$ 2,540.05',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColor.primaryText,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _buildMasterCardLogo(),
                const SizedBox(width: 8),
                _buildCardNumberPill(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebitCard() {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.CARD_DETAILS, arguments: {'type': 'debit'}),
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.debitCardGradientStart,
              AppColor.debitCardGradientEnd,
              AppColor.debitCardGradientEnd,
            ],
            stops: [0.1, 0.5, 1],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debit Card',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColor.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$ 0.00',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColor.primaryText,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildCardNumberPillWithLogo()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '••• 5567',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColor.white,
        ),
      ),
    );
  }

  Widget _buildCardNumberPillWithLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMasterCardLogoSmall(),
          const SizedBox(width: 6),
          Text(
            '••• 5567',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterCardLogo() {
    return SizedBox(
      width: 30,
      height: 20,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColor.masterCardRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColor.masterCardOrange.withAlpha(200),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterCardLogoSmall() {
    return SizedBox(
      width: 22,
      height: 14,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: AppColor.masterCardRed,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 8,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColor.masterCardOrange.withAlpha(200),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../../tabs/controllers/tabs_controller.dart';

class HomeTeaserSection extends GetView<HomeController> {
  const HomeTeaserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tabsController = Get.find<TabsController>();

    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        child: controller.isBalanceVisible.value
            ? const _VisibleSummary(key: ValueKey('visible'))
            : _HiddenSummary(
                key: const ValueKey('hidden'),
                onQuickPayTap: () => tabsController.changeTab(1),
              ),
      ),
    );
  }
}

class _HiddenSummary extends StatelessWidget {
  final VoidCallback onQuickPayTap;

  const _HiddenSummary({super.key, required this.onQuickPayTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: const [
                Icon(
                  LucideIcons.sparkles,
                  size: 20,
                  color: AppColor.paymentsBlue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap the preview panel to reveal your dashboard',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textMid,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _TeaserCard(
                  icon: LucideIcons.wallet,
                  title: 'Quick Pay',
                  subtitle: 'Fast transfers',
                  onTap: onQuickPayTap,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _TeaserCard(
                  icon: LucideIcons.shieldCheck,
                  title: 'Secure',
                  subtitle: 'Protected access',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VisibleSummary extends StatelessWidget {
  const _VisibleSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            Icon(LucideIcons.sparkles, size: 18, color: AppColor.paymentsBlue),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Dashboard unlocked. Swipe down the sheets to stay in flow.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textMid,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeaserCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _TeaserCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: AppColor.paymentsBlue),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.textStrong,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

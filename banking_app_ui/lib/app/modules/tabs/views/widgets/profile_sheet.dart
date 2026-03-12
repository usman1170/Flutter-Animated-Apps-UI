import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.surfaceSheet,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(14),
            blurRadius: 24,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        child: Stack(
          children: [
            const Positioned.fill(child: _ProfileSheetBackdrop()),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                children: const [
                  _Handle(),
                  SizedBox(height: 18),
                  _ProfileHero(),
                  SizedBox(height: 18),
                  _ProfileOption(
                    icon: LucideIcons.shieldCheck,
                    title: 'Security',
                    subtitle: 'Biometrics, PIN and login settings',
                  ),
                  SizedBox(height: 12),
                  _ProfileOption(
                    icon: LucideIcons.bell,
                    title: 'Notifications',
                    subtitle: 'Manage alerts and payment reminders',
                  ),
                  SizedBox(height: 12),
                  _ProfileOption(
                    icon: LucideIcons.creditCard,
                    title: 'Cards and limits',
                    subtitle: 'Freeze cards, adjust limits and controls',
                  ),
                  SizedBox(height: 12),
                  _ProfileOption(
                    icon: LucideIcons.settings,
                    title: 'Preferences',
                    subtitle: 'App theme, language and personalization',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSheetBackdrop extends StatelessWidget {
  const _ProfileSheetBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -30,
          right: -28,
          child: Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.paymentsBlueSoft.withAlpha(74),
            ),
          ),
        ),
        Positioned(
          top: 180,
          left: -42,
          child: Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.profileBlue.withAlpha(90),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: -36,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.surfaceMint.withAlpha(70),
            ),
          ),
        ),
      ],
    );
  }
}

class _Handle extends StatelessWidget {
  const _Handle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 5,
      decoration: BoxDecoration(
        color: AppColor.divider,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.profileBlue,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColor.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.user,
              size: 30,
              color: AppColor.paymentsBlue,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usman Ghani',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textStrong,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Premium account • USBank',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 22, color: AppColor.paymentsBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textStrong,
                  ),
                ),
                const SizedBox(height: 3),
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

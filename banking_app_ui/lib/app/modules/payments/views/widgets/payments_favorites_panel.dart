import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';

class PaymentsFavoritesPanel extends StatelessWidget {
  const PaymentsFavoritesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.textStrong,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
            decoration: BoxDecoration(
              color: AppColor.surfaceSoft,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _FavoriteItem(
                      icon: LucideIcons.smartphone,
                      label: 'Phone',
                      backgroundColor: AppColor.surfaceMint,
                      iconColor: AppColor.paymentsMint,
                    ),
                    _FavoriteItem(
                      icon: LucideIcons.wifi,
                      label: 'Internet',
                      backgroundColor: AppColor.surfaceLavender,
                      iconColor: AppColor.paymentsBlue,
                    ),
                    _FavoriteAvatar(label: 'M', name: 'Mikael K.'),
                    _FavoriteItem(
                      icon: LucideIcons.plus,
                      label: 'Add',
                      backgroundColor: AppColor.surfaceLavender,
                      iconColor: AppColor.paymentsBlue,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: _ActionPill(
                        icon: LucideIcons.scanLine,
                        label: 'Scan QR',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _ActionPill(
                        icon: LucideIcons.alarmClock,
                        label: 'Autopay',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _ActionPill(
                        icon: LucideIcons.clipboardList,
                        label: 'Bills',
                        badge: '4',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  const _FavoriteItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, size: 28, color: iconColor)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.textMid,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FavoriteAvatar extends StatelessWidget {
  final String label;
  final String name;

  const _FavoriteAvatar({required this.label, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: AppColor.surfaceMuted,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textStrong,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColor.textMid,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;

  const _ActionPill({required this.icon, required this.label, this.badge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.surfaceMuted,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: AppColor.iconDark),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textStrong,
                ),
              ),
            ],
          ),
        ),
        if (badge != null)
          Positioned(
            top: -6,
            right: -4,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColor.badgeRed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

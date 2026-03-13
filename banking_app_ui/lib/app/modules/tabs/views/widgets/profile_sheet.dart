import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_appearance_controller.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key});

  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet> {
  bool _showAppearance = true;

  @override
  Widget build(BuildContext context) {
    final appearanceController = Get.find<AppAppearanceController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColor.sheetSurface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withAlpha(AppColor.isDark(context) ? 42 : 14),
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
                children: [
                  const _Handle(),
                  const SizedBox(height: 18),
                  const _ProfileHero(),
                  const SizedBox(height: 18),
                  const _ProfileOption(
                    icon: LucideIcons.shieldCheck,
                    title: 'Security',
                    subtitle: 'Biometrics, PIN and login settings',
                  ),
                  const SizedBox(height: 12),
                  const _ProfileOption(
                    icon: LucideIcons.bell,
                    title: 'Notifications',
                    subtitle: 'Manage alerts and payment reminders',
                  ),
                  const SizedBox(height: 12),
                  const _ProfileOption(
                    icon: LucideIcons.creditCard,
                    title: 'Cards and limits',
                    subtitle: 'Freeze cards, adjust limits and controls',
                  ),
                  const SizedBox(height: 12),
                  _AppearanceOption(
                    isExpanded: _showAppearance,
                    appearanceController: appearanceController,
                    onTap: () {
                      setState(() {
                        _showAppearance = !_showAppearance;
                      });
                    },
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
              color: AppColor.blueSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 96 : 74),
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
              color: AppColor.lavenderSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 98 : 90),
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
              color: AppColor.mintSoft(
                context,
              ).withAlpha(AppColor.isDark(context) ? 92 : 70),
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
        color: AppColor.dividerColor(context),
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
        color: AppColor.blueSoft(context),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColor.elevatedSurface(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.user,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usman Ghani',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryLabel(context),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Premium account • USBank',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryLabel(context),
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
        color: AppColor.softSurface(context),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.elevatedSurface(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 22,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryLabel(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryLabel(context),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 22,
            color: AppColor.tertiaryLabel(context),
          ),
        ],
      ),
    );
  }
}

class _AppearanceOption extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;
  final AppAppearanceController appearanceController;

  const _AppearanceOption({
    required this.isExpanded,
    required this.onTap,
    required this.appearanceController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appearance = appearanceController.appearance;
      final subtitle = switch (appearance) {
        AppAppearance.system => 'Follow device appearance',
        AppAppearance.light => 'Bright surfaces and softer shadows',
        AppAppearance.dark => 'Dim surfaces with neon glows',
      };

      return AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.softSurface(context),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColor.elevatedSurface(context),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      LucideIcons.sunMoon,
                      size: 22,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appearance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryLabel(context),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondaryLabel(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? LucideIcons.chevronUp
                        : LucideIcons.chevronDown,
                    size: 22,
                    color: AppColor.tertiaryLabel(context),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 240),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: AppAppearance.values.map((mode) {
                    final isSelected = mode == appearance;
                    final label = switch (mode) {
                      AppAppearance.system => 'System',
                      AppAppearance.light => 'Light',
                      AppAppearance.dark => 'Dark',
                    };

                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: mode == AppAppearance.dark ? 0 : 10,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              appearanceController.updateAppearance(mode),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : AppColor.elevatedSurface(context),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: isSelected && AppColor.isDark(context)
                                  ? [
                                      BoxShadow(
                                        color: AppColor.heroGlowColor(
                                          context,
                                        ).withAlpha(72),
                                        blurRadius: 20,
                                        spreadRadius: -2,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? AppColor.white
                                    : AppColor.primaryLabel(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

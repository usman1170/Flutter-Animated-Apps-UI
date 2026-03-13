import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../tabs/controllers/tabs_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(84);

  @override
  Widget build(BuildContext context) {
    final tabsController = Get.find<TabsController>();

    return AppBar(
      backgroundColor: AppColor.screenBackground(context),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 84,
      titleSpacing: 20,
      title: Row(
        children: [
          _CircleAction(
            icon: LucideIcons.user,
            onTap: () => tabsController.changeTab(2),
          ),
          const SizedBox(width: 12),
          _CircleAction(
            icon: LucideIcons.search,
            onTap: () => tabsController.changeTab(1),
          ),
          const Spacer(),
          const _CircleAction(icon: LucideIcons.barChart3),
          const SizedBox(width: 12),
          const _CircleAction(icon: LucideIcons.scanLine),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleAction({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColor.transparent,
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColor.mutedSurface(context),
            shape: BoxShape.circle,
            boxShadow: AppColor.isDark(context)
                ? [
                    BoxShadow(
                      color: AppColor.heroGlowColor(context).withAlpha(28),
                      blurRadius: 18,
                      spreadRadius: -2,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Icon(icon, size: 24, color: AppColor.primaryLabel(context)),
          ),
        ),
      ),
    );
  }
}

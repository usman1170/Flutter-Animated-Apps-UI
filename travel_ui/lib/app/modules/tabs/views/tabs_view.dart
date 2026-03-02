import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/consts.dart';
import '../controllers/tabs_controller.dart';
import '../../home/views/home_view.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GradientScaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: controller.selectedIndex.value,
              children: const [
                HomeView(),
                _PlaceholderView('Search'),
                _PlaceholderView('Bookings'),
                _PlaceholderView('Account'),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              bottom: controller.isBottomBarVisible.value
                  ? kBottomPadding(Get.context!) - (kPadding * 2)
                  : -100,
              left: 0,
              right: 0,
              child: const _FloatingBottomBar(),
            ),
          ],
        ),
      );
    });
  }
}

class _FloatingBottomBar extends GetView<TabsController> {
  const _FloatingBottomBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(170),
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white.withAlpha(130), width: 1),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 22),
              blurRadius: 13,
              spreadRadius: 0,
              color: Color(0x0D000000),
            ),
            BoxShadow(
              offset: Offset(7, 39),
              blurRadius: 16,
              spreadRadius: 0,
              color: Color(0x03000000),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: const Row(
                children: [
                  _TabItem(index: 0, label: 'Home', icon: Icons.home_filled),
                  _TabItem(index: 1, label: 'Search', icon: Icons.search),
                  _TabItem(
                    index: 2,
                    label: 'Bookings',
                    icon: Icons.calendar_today_outlined,
                  ),
                  _TabItem(
                    index: 3,
                    label: 'Account',
                    icon: Icons.person_outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends GetView<TabsController> {
  const _TabItem({
    required this.index,
    required this.label,
    required this.icon,
  });

  final int index;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final bool isActive = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 30,
                color: isActive ? AppColor.primary : AppColor.iconUnselected,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTheme.bodySmall.copyWith(
                  color: isActive ? AppColor.primary : AppColor.iconUnselected,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  const _PlaceholderView(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppTheme.titleLarge));
  }
}

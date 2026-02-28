import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../home/views/home_view.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = [
      HomeView(),
      _PlaceholderPage(label: 'Search'),
      _PlaceholderPage(label: 'Bookings'),
      _PlaceholderPage(label: 'Account'),
      _PlaceholderPage(label: 'More'),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: AppColor.cardSurface),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.onTabChanged,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.cardSurface,
              elevation: 0,
              selectedItemColor: AppColor.primary,
              unselectedItemColor: AppColor.iconMuted,
              selectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_rounded),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Account',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_rounded),
                  label: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.surface,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.textPrimary,
        ),
      ),
    );
  }
}

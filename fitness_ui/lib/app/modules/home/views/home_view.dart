import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/home_controller.dart';
import 'components/custom_bottom_nav_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            Center(child: Text('LOBBY')),
            Center(child: Text('WORKOUT')),
            Center(child: Text('HISTORY')),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

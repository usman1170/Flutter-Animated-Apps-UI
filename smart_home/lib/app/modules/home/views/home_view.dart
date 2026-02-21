import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/home_camera_card.dart';
import 'package:gap/gap.dart';
import '../widgets/emergency_button.dart';
import '../widgets/smart_devices_grid.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeHeader(),
              Gap(24),
              HomeCameraCard(),
              Gap(24),
              EmergencyButton(),
              Gap(24),
              SmartDevicesGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

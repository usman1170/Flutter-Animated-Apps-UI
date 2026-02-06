import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/my_cameras_controller.dart';
import 'widgets/camera_app_bar.dart';
import 'widgets/camera_main_card.dart';
import 'widgets/camera_tabs.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/device_info_cards.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/schedule_cards.dart';

class MyCamerasView extends GetView<MyCamerasController> {
  const MyCamerasView({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundGradient(brightness),
                  ),
                ),
              ),
              SafeArea(
                bottom: false,
                child: Obx(
                  () => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CameraAppBar(
                            avatarUrl: 'https://i.pravatar.cc/150?img=12',
                            isDark: controller.isDarkTheme.value,
                            onToggleTheme: controller.toggleTheme,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'My Cameras',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontSize: 32),
                          ),
                          const SizedBox(height: 16),
                          CameraTabs(
                            tabs: controller.cameraTabs,
                            selectedIndex: controller.selectedTab.value,
                            onChanged: controller.setTab,
                          ),
                          const SizedBox(height: 18),
                          const CameraMainCard(assetPath: 'assets/cctv.png'),
                          const SizedBox(height: 18),
                          const ScheduleCards(),
                          const SizedBox(height: 20),
                          const QuickActionsSection(),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'Device Info',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(fontSize: 18),
                              ),
                              const Spacer(),
                              Text(
                                'See All',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const DeviceInfoCards(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Obx(
          () => BottomNavBar(
            selectedIndex: controller.selectedBottomIndex.value,
            onChanged: controller.setBottomIndex,
          ),
        ),
      ),
    );
  }
}

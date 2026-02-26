import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playerfit/app/modules/profile/controller/profile_controller.dart';
import '../../../core/theme/app_colors.dart';
import 'components/profile_avatar_section.dart';
import 'components/profile_header.dart';
import 'components/profile_stats_row.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProfileHeader(),
                  SizedBox(height: 22),
                  ProfileStatsRow(
                    isGoalMode: controller.isGoalMode.value,
                    onStatsTap: () => controller.toggleGoalMode(false),
                    onGoalTap: () => controller.toggleGoalMode(true),
                  ),
                  SizedBox(height: 22),
                  ProfileAvatarSection(isGoalMode: controller.isGoalMode.value),
                ],
              ),
            ),
            Positioned(
              left: 24,
              bottom: 24,
              child: Row(
                children: [
                  _buildDiamondIcon(Icons.grid_view_rounded),
                  SizedBox(width: 8),
                  _buildDiamondIcon(Icons.info_outline_rounded),
                ],
              ),
            ),
            Positioned(right: 24, bottom: 24, child: _buildActionButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withAlpha(70),
              blurRadius: 10,
              spreadRadius: 1.2,
            ),
          ],
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: const Icon(
            Icons.navigation_rounded,
            color: Color(0xFF06131E),
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildDiamondIcon(IconData icon) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xD0142439),
          border: Border.all(color: const Color(0xFF2D425C), width: 1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Icon(icon, size: 22, color: const Color(0xFFEAF2FF)),
        ),
      ),
    );
  }
}

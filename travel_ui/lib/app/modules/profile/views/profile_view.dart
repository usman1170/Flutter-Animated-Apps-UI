import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              const SizedBox(height: 14),
              _ProfileSummaryCard(),
              const SizedBox(height: 14),
              _ProfileStatsRow(),
              const SizedBox(height: 18),
              _SegmentedTabs(controller: controller),
              const SizedBox(height: 16),
              Text(
                controller.tabs[controller.selectedTabIndex.value].label,
                style: AppTheme.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ...controller.activeItems.map((item) => _SettingTile(item: item)),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(220),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColor.error.withAlpha(60)),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Log out',
                    style: AppTheme.titleMedium.copyWith(
                      color: AppColor.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Profile', style: AppTheme.displaySmall),
        const Spacer(),
        _TopAction(icon: Icons.notifications_none_rounded),
        const SizedBox(width: 8),
        _TopAction(icon: Icons.more_horiz_rounded),
      ],
    );
  }
}

class _TopAction extends StatelessWidget {
  final IconData icon;

  const _TopAction({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(215),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: AppColor.textPrimary, size: 20),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(225),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.white, width: 2),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1200&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budiarti Elmas',
                  style: AppTheme.displaySmall.copyWith(fontSize: 25),
                ),
                Text(
                  'budiarti.elmas@email.com',
                  style: AppTheme.bodySmall.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withAlpha(32),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Explorer Pro',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.edit_outlined, size: 18),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(value: '24', label: 'Trips'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(value: '8', label: 'Countries'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(value: '12.4K', label: 'Points'),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(label, style: AppTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final ProfileController controller;

  const _SegmentedTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List<Widget>.generate(controller.tabs.length, (index) {
          final bool isActive = controller.selectedTabIndex.value == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.changeTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? AppColor.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  controller.tabs[index].label,
                  textAlign: TextAlign.center,
                  style: AppTheme.titleSmall.copyWith(
                    color: isActive ? AppColor.white : AppColor.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final ProfileActionItem item;

  const _SettingTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(220),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColor.primary.withAlpha(24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.settings_suggest_rounded,
              color: AppColor.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(item.subtitle, style: AppTheme.bodySmall),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColor.textSecondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}

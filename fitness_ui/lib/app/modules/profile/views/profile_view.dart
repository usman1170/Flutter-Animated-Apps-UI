import 'package:flutter/material.dart';
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
  bool isGoalMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileHeader(),
              const SizedBox(height: 22),
              ProfileStatsRow(
                isGoalMode: isGoalMode,
                onStatsTap: () => setState(() => isGoalMode = false),
                onGoalTap: () => setState(() => isGoalMode = true),
              ),
              const SizedBox(height: 22),
              ProfileAvatarSection(isGoalMode: isGoalMode),
            ],
          ),
        ),
      ),
    );
  }
}

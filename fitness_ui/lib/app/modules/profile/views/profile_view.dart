import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'components/profile_header.dart';
import 'components/profile_stats_row.dart';
import 'components/profile_avatar_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ProfileHeader(),
              SizedBox(height: 22),
              ProfileStatsRow(),
              SizedBox(height: 22),
              ProfileAvatarSection(),
            ],
          ),
        ),
      ),
    );
  }
}

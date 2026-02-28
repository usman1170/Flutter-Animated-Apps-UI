import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: AppColor.cardSurface,
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: AppColor.textPrimary, width: 1.4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: const [
          Icon(Icons.search_rounded, size: 28, color: AppColor.textPrimary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Where do you want to stay?',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColor.textSecondary,
              ),
            ),
          ),
          Icon(Icons.tune_rounded, size: 25, color: AppColor.textPrimary),
        ],
      ),
    );
  }
}

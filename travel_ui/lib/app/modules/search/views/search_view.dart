import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search', style: AppTheme.displaySmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColor.white.withAlpha(230),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextField(
                      onSubmitted: controller.addRecentSearch,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColor.textPrimary,
                        ),
                        hintText: 'Search hotels, cities, stays',
                        hintStyle: AppTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: AppColor.white,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              'Recent Searches',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.recentSearches.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white.withAlpha(178),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text('No recent searches', style: AppTheme.bodyMedium),
                );
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.recentSearches
                    .map(
                      (item) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white.withAlpha(214),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.border.withAlpha(180),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item,
                              style: AppTheme.titleSmall.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => controller.removeRecentSearch(item),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
            const SizedBox(height: 24),
            Text(
              'Suggestions',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...controller.suggestions.map(
              (suggestion) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.white.withAlpha(209),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        suggestion.imageUrl,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            suggestion.title,
                            style: AppTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            suggestion.subtitle,
                            style: AppTheme.bodySmall.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

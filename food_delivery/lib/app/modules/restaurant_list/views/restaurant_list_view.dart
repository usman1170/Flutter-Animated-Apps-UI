import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/restaurant_list_controller.dart';
import '../widgets/restaurant_card.dart';

class RestaurantListView extends GetView<RestaurantListController> {
  const RestaurantListView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    final featuredRestaurants =
        controller.restaurants.take(5).toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: const Text(
          'Discover',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        actions: [
          Obx(() {
            return Row(
              children: [
                Icon(
                  themeController.isDark.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: 18,
                ),
                Switch.adaptive(
                  value: themeController.isDark.value,
                  activeColor: accentColor,
                  onChanged: (_) => themeController.toggleTheme(),
                ),
              ],
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: controller.restaurants.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Curated picks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 190,
                  child: PageView.builder(
                    controller: controller.bannerController,
                    itemCount: controller.banners.length,
                    itemBuilder: (context, bannerIndex) {
                      final banner = controller.banners[bannerIndex];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                banner.imageUrl,
                                fit: BoxFit.cover,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withAlpha(26),
                                      Colors.black.withAlpha(204),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                bottom: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      banner.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      banner.subtitle,
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(204),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final indicatorBase =
                      Theme.of(context).colorScheme.onSurface;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.banners.length, (dot) {
                      final isActive = controller.currentBanner.value == dot;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? accentColor
                              : indicatorBase.withAlpha(64),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  );
                }),
                const SizedBox(height: 24),
                const Text(
                  'Featured restaurants',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 240,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredRestaurants.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, featuredIndex) {
                      final restaurant = featuredRestaurants[featuredIndex];
                      final intervalStart = featuredIndex * 0.08;
                      final intervalEnd = min(intervalStart + 0.5, 1.0);
                      final curvedAnimation = CurvedAnimation(
                        parent: controller.listController,
                        curve: Interval(
                          intervalStart,
                          intervalEnd,
                          curve: Curves.easeOut,
                        ),
                      );
                      final fade = Tween<double>(begin: 0, end: 1)
                          .animate(curvedAnimation);
                      final slide = Tween<double>(begin: 20, end: 0)
                          .animate(curvedAnimation);

                      return AnimatedBuilder(
                        animation: controller.listController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: fade.value,
                            child: Transform.translate(
                              offset: Offset(slide.value, 0),
                              child: child,
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 230,
                        child: RestaurantCard(
                          restaurant: restaurant,
                          heroTag: 'restaurant_featured_${restaurant.id}',
                          onTap: () {
                              Get.toNamed(
                                Routes.RESTAURANT_DETAIL,
                                arguments: {
                                  'restaurant': restaurant,
                                  'heroTag': 'restaurant_featured_${restaurant.id}',
                                },
                                preventDuplicates: false,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'All restaurants',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
              ],
            );
          }

          final restaurantIndex = index - 1;
          final restaurant = controller.restaurants[restaurantIndex];
          final intervalStart = restaurantIndex * 0.08;
          final intervalEnd = min(intervalStart + 0.5, 1.0);
          final curvedAnimation = CurvedAnimation(
            parent: controller.listController,
            curve: Interval(intervalStart, intervalEnd, curve: Curves.easeOut),
          );
          final fade = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
          final slide =
              Tween<double>(begin: 28, end: 0).animate(curvedAnimation);

          return AnimatedBuilder(
            animation: controller.listController,
            builder: (context, child) {
              return Opacity(
                opacity: fade.value,
                child: Transform.translate(
                  offset: Offset(0, slide.value),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: RestaurantCard(
                restaurant: restaurant,
                heroTag: 'restaurant_${restaurant.id}',
                onTap: () {
                  Get.toNamed(
                    Routes.RESTAURANT_DETAIL,
                    arguments: {
                      'restaurant': restaurant,
                      'heroTag': 'restaurant_${restaurant.id}',
                    },
                    preventDuplicates: false,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

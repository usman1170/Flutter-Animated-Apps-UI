import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../restaurant_list/widgets/info_chip.dart';
import '../controllers/restaurant_detail_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/product_list_tile.dart';

class RestaurantDetailView extends GetView<RestaurantDetailController> {
  const RestaurantDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = controller.restaurant;
    final products = controller.products;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.headerVisible.value ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: controller.heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: Stack(
                              children: [
                                Image.network(
                                  restaurant.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Positioned.fill(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withAlpha(153),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                  child: Obx(() {
                                    return AnimatedOpacity(
                                      opacity: controller.titleVisible.value
                                          ? 1
                                          : 0,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.easeOut,
                                      child: Text(
                                        restaurant.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          InfoChip(
                            icon: Icons.star_rounded,
                            label: restaurant.rating.toStringAsFixed(1),
                          ),
                          const SizedBox(width: 10),
                          InfoChip(
                            icon: Icons.timer_rounded,
                            label: restaurant.eta,
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final slide = Tween<double>(begin: 30, end: 0).animate(
                    CurvedAnimation(
                      parent: controller.menuController,
                      curve: Interval(0.1 * index, 0.6, curve: Curves.easeOut),
                    ),
                  );
                  final fade = Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: controller.menuController,
                      curve: Interval(0.1 * index, 0.6, curve: Curves.easeOut),
                    ),
                  );

                  return AnimatedBuilder(
                    animation: controller.menuController,
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
                      width: 170,
                      child: ProductCard(
                        product: product,
                        heroTag: 'featured_${product.id}',
                        onTap: () {
                          Get.toNamed(
                            Routes.PRODUCT_DETAIL,
                            arguments: {
                              'restaurant': restaurant,
                              'product': product,
                              'heroTag': 'featured_${product.id}',
                            },
                            preventDuplicates: false,
                          );
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemCount: 5,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final intervalStart = 0.05 * index;
                final intervalEnd = min(intervalStart + 0.6, 1.0);
                final curved = CurvedAnimation(
                  parent: controller.menuController,
                  curve: Interval(
                    intervalStart,
                    intervalEnd,
                    curve: Curves.easeOut,
                  ),
                );
                final fade = Tween<double>(begin: 0, end: 1).animate(curved);
                final slide = Tween<double>(begin: 28, end: 0).animate(curved);

                return AnimatedBuilder(
                  animation: controller.menuController,
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
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ProductListTile(
                      product: product,
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAIL,
                          arguments: {
                            'restaurant': restaurant,
                            'product': product,
                            'heroTag': 'product_${product.id}',
                          },
                          preventDuplicates: false,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

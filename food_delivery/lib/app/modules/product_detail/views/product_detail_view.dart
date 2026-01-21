import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../controllers/product_detail_controller.dart';
import '../widgets/addon_section.dart';
import '../widgets/related_section.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final baseColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;
    final cartScale = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: controller.cartBounceController,
        curve: Curves.easeOut,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(controller.restaurant.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ScaleTransition(
              scale: cartScale,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.CART),
                    child: const Icon(Icons.shopping_bag_outlined, size: 26),
                  ),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Obx(() {
                      final count = cartController.count;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: count == 0
                            ? const SizedBox.shrink()
                            : Container(
                                key: ValueKey(count),
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final startOffset = Offset(
            constraints.maxWidth * 0.2,
            constraints.maxHeight * 0.24,
          );
          final endOffset = Offset(
            constraints.maxWidth - 56,
            kToolbarHeight * 0.2,
          );
          final flyAnimation = Tween<Offset>(begin: startOffset, end: endOffset)
              .animate(
                CurvedAnimation(
                  parent: controller.flyController,
                  curve: Curves.easeInOut,
                ),
              );
          final flyScale = Tween<double>(begin: 1, end: 0.2).animate(
            CurvedAnimation(
              parent: controller.flyController,
              curve: Curves.easeInOut,
            ),
          );
          final flyFade = Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(
              parent: controller.flyController,
              curve: Curves.easeOut,
            ),
          );

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Hero(
                      tag: controller.heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.network(
                            controller.product.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(() {
                      return AnimatedOpacity(
                        opacity: controller.contentVisible.value ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.product.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '\$${controller.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              controller.product.description,
                              style: TextStyle(
                                color: baseColor.withAlpha(179),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    AddonSection(controller: controller),
                    const SizedBox(height: 24),
                    RelatedSection(controller: controller),
                    const SizedBox(height: 110),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1, end: 0.96).animate(
                    CurvedAnimation(
                      parent: controller.buttonController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 58,
                      decoration: BoxDecoration(
                        color: controller.added.value
                            ? Colors.greenAccent.shade400
                            : accentColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextButton(
                        onPressed: () {
                          controller.handleAddToCart(() {
                            cartController.add(controller.product);
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          child: controller.added.value
                              ? const Row(
                                  key: ValueKey('added'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_rounded, size: 22),
                                    SizedBox(width: 8),
                                    Text(
                                      'Added',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Add to Cart',
                                  key: ValueKey('add'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Obx(() {
                if (!controller.showFlyImage.value) {
                  return const SizedBox.shrink();
                }
                return AnimatedBuilder(
                  animation: controller.flyController,
                  builder: (context, child) {
                    return Positioned(
                      left: flyAnimation.value.dx,
                      top: flyAnimation.value.dy,
                      child: Opacity(
                        opacity: flyFade.value,
                        child: Transform.scale(
                          scale: flyScale.value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      controller.product.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/product_detail_controller.dart';
import 'related_product_card.dart';

class RelatedSection extends StatelessWidget {
  const RelatedSection({super.key, required this.controller});

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related picks',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.relatedProducts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final related = controller.relatedProducts[index];
              final intervalStart = index * 0.1;
              final intervalEnd = (intervalStart + 0.6).clamp(0.0, 1.0);
              final curved = CurvedAnimation(
                parent: controller.relatedController,
                curve: Interval(
                  intervalStart,
                  intervalEnd,
                  curve: Curves.easeOut,
                ),
              );
              final fade = Tween<double>(begin: 0, end: 1).animate(curved);
              final slide = Tween<double>(begin: 16, end: 0).animate(curved);
              return AnimatedBuilder(
                animation: controller.relatedController,
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
                  child: RelatedProductCard(
                    product: related,
                    heroTag: 'related_${related.id}',
                    onTap: () {
                      Get.toNamed(
                        Routes.PRODUCT_DETAIL,
                        arguments: {
                          'restaurant': controller.restaurant,
                          'product': related,
                          'heroTag': 'related_${related.id}',
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
      ],
    );
  }
}

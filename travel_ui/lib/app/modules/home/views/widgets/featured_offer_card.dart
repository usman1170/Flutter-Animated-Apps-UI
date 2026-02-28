import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';

class FeaturedOfferCard extends StatelessWidget {
  const FeaturedOfferCard({super.key, required this.offer});

  final FeaturedOffer offer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Image.network(offer.imageUrl, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColor.chipGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      offer.priceTag,
                      style: const TextStyle(
                        color: AppColor.textLight,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            offer.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColor.textPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            offer.subtitle,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColor.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

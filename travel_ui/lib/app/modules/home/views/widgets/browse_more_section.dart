import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class BrowseMoreSection extends StatelessWidget {
  const BrowseMoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Browse More',
              style: AppTheme.displaySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const _BrowseMoreCard(
            imageUrl:
                'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?q=80&w=2070&auto=format&fit=crop',
            price: '\$120',
            imageCount: '2/27',
            title: 'Luxury in Bali',
            rating: '4.9',
            reviews: '(2,241 reviews)',
            location: '0.5 km from Eiffel Tower',
            hasFreeCancellation: true,
            hasBreakfast: true,
          ),
          SizedBox(height: 16),
          _BrowseMoreCard(
            imageUrl:
                'https://images.unsplash.com/photo-1611892440504-42a792e24d32?q=80&w=2070&auto=format&fit=crop',
            price: '\$140',
            imageCount: '1/20',
            title: 'Deluxe King Room',
            rating: '5.0',
            reviews: '(1,320 reviews)',
            location: '0.5 km from Eiffel Tower',
            hasFreeCancellation: true,
            hasBreakfast: true,
          ),
        ],
      ),
    );
  }
}

class _BrowseMoreCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String imageCount;
  final String title;
  final String rating;
  final String reviews;
  final String location;
  final bool hasFreeCancellation;
  final bool hasBreakfast;

  const _BrowseMoreCard({
    required this.imageUrl,
    required this.price,
    required this.imageCount,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.hasFreeCancellation,
    required this.hasBreakfast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        price,
                        style: AppTheme.titleMedium.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '/night',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppColor.white.withAlpha(230),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    imageCount,
                    style: AppTheme.bodySmall.copyWith(color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTheme.titleLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: AppTheme.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(reviews, style: AppTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColor.textSecondary,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(location, style: AppTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasFreeCancellation)
                          Row(
                            children: [
                              const Icon(
                                Icons.event_busy_outlined,
                                color: AppColor.textSecondary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Free cancellation',
                                style: AppTheme.bodySmall,
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                        if (hasBreakfast)
                          Row(
                            children: [
                              const Icon(
                                Icons.local_cafe_outlined,
                                color: AppColor.textSecondary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Breakfast included',
                                style: AppTheme.bodySmall,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'View Rooms',
                        style: AppTheme.titleSmall.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

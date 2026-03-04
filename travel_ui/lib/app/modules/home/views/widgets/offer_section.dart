import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../routes/app_pages.dart';
import '../../../offer_details/models/offer_details_model.dart';

const List<OfferDetailsModel> _offers = [
  OfferDetailsModel(
    id: 'luxury-bali',
    imageUrl:
        'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?q=80&w=1974&auto=format&fit=crop',
    pricePerNight: 120,
    title: 'Luxury in Bali',
    location: 'Nusa Penida, Bali',
    subtitle: 'Unwind where paradise meets comfort.',
    description:
        'Wake up to endless ocean views, enjoy open-air breakfast, and relax in a modern suite surrounded by tropical gardens.',
    gallery: [
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?q=80&w=1974&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=1974&auto=format&fit=crop',
    ],
    rating: 4.8,
    reviewsCount: 234,
    facilities: [
      FacilityItem(label: 'Wi-Fi', icon: Icons.wifi_rounded),
      FacilityItem(label: 'Pool', icon: Icons.pool_rounded),
      FacilityItem(label: 'Breakfast', icon: Icons.free_breakfast_rounded),
      FacilityItem(label: 'Spa', icon: Icons.spa_rounded),
    ],
    highlights: [
      'Infinity pool with sea view',
      'Daily floating breakfast',
      'Sunset deck and lounge',
      'Private airport transfer',
    ],
  ),
  OfferDetailsModel(
    id: 'touch-morocco',
    imageUrl:
        'https://images.unsplash.com/photo-1533104816931-20fa691ff6ca?q=80&w=1974&auto=format&fit=crop',
    pricePerNight: 85,
    title: 'A Touch of Morocco',
    location: 'Chefchaouen, Morocco',
    subtitle: 'Where elegance embraces heritage.',
    description:
        'Experience local architecture, warm hospitality, and curated cultural tours while staying in handcrafted boutique suites.',
    gallery: [
      'https://images.unsplash.com/photo-1533104816931-20fa691ff6ca?q=80&w=1974&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?q=80&w=1974&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1553246969-39eb3d7d4b71?q=80&w=1965&auto=format&fit=crop',
    ],
    rating: 4.7,
    reviewsCount: 182,
    facilities: [
      FacilityItem(label: 'Wi-Fi', icon: Icons.wifi_rounded),
      FacilityItem(label: 'Rooftop', icon: Icons.roofing_rounded),
      FacilityItem(label: 'Dining', icon: Icons.restaurant_rounded),
      FacilityItem(label: 'Guide', icon: Icons.explore_rounded),
    ],
    highlights: [
      'Traditional Moroccan interiors',
      'Rooftop breakfast with mountain views',
      'Handpicked local experiences',
      'Walking distance to medina',
    ],
  ),
];

class OfferSection extends StatelessWidget {
  const OfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Offers',
                style: AppTheme.displaySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'View all',
                style: AppTheme.titleMedium.copyWith(
                  color: AppColor.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 12),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _offers
                .map((offer) => _OfferCard(offer: offer))
                .toList(growable: false),
          ),
        ),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  final OfferDetailsModel offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.OFFER_DETAILS, arguments: offer),
      child: SizedBox(
        width: 260,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'offer-image-${offer.id}',
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(offer.imageUrl),
                          fit: BoxFit.cover,
                        ),
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
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '\$${offer.pricePerNight.toStringAsFixed(0)}',
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
                ],
              ),
              const SizedBox(height: 12),
              Text(
                offer.title,
                style: AppTheme.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(offer.subtitle, style: AppTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

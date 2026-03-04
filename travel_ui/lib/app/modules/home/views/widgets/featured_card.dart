import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../routes/app_pages.dart';
import '../../../offer_details/models/offer_details_model.dart';

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  OfferDetailsModel get _featuredOffer => const OfferDetailsModel(
    id: 'escape-ordinary',
    title: 'Azure Coast Resort',
    location: 'Nusa Penida, Bali',
    subtitle: 'Cliffside suites with sunrise deck',
    description:
        'Discover a refined stay with oceanfront suites, dedicated concierge, and curated wellness experiences designed for total reset.',
    imageUrl:
        'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
    gallery: [
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?q=80&w=1974&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=1974&auto=format&fit=crop',
    ],
    pricePerNight: 140,
    rating: 4.9,
    reviewsCount: 318,
    facilities: [
      FacilityItem(label: 'Wi-Fi', icon: Icons.wifi_rounded),
      FacilityItem(label: 'Pool', icon: Icons.pool_rounded),
      FacilityItem(label: 'Breakfast', icon: Icons.free_breakfast_rounded),
      FacilityItem(label: 'Gym', icon: Icons.fitness_center_rounded),
    ],
    highlights: [
      'Sea-view suites and lounge',
      'Private butler and concierge',
      'Sunrise yoga pavilion',
      'Fast check-in and airport shuttle',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 360,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(26),
                    Colors.black.withAlpha(153),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Escape The Ordinary',
                      style: AppTheme.displayLarge.copyWith(
                        color: AppColor.white,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find exclusive hotel deals worldwide',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppColor.white.withAlpha(230),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.OFFER_DETAILS,
                        arguments: _featuredOffer,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white.withAlpha(64),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColor.white.withAlpha(128),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Explore Now',
                          style: AppTheme.titleMedium.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppColor.textPrimary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Where do you want to stay?',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ),
                  const Icon(Icons.tune, color: AppColor.textPrimary, size: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

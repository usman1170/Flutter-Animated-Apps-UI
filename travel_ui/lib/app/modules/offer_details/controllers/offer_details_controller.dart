import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/offer_details_model.dart';

class OfferDetailsController extends GetxController {
  final RxBool isSaved = false.obs;

  late final OfferDetailsModel offer;

  @override
  void onInit() {
    super.onInit();
    offer = (Get.arguments is OfferDetailsModel)
        ? Get.arguments as OfferDetailsModel
        : _fallbackOffer;
  }

  void toggleSaved() {
    isSaved.toggle();
  }
}

const OfferDetailsModel _fallbackOffer = OfferDetailsModel(
  id: 'azure-coast',
  title: 'Azure Coast Resort',
  location: 'Nusa Penida, Bali',
  subtitle: 'Infinity pool and private beach view',
  description:
      'A calm oceanfront retreat with spacious suites, sunset decks, and curated local experiences. Perfect for couples and family stays seeking privacy with premium comfort.',
  imageUrl:
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
  gallery: [
    'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?q=80&w=1974&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1469796466635-455ede028aca?q=80&w=1974&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1533104816931-20fa691ff6ca?q=80&w=1974&auto=format&fit=crop',
  ],
  pricePerNight: 120,
  rating: 4.8,
  reviewsCount: 234,
  facilities: [
    FacilityItem(label: 'Wi-Fi', icon: Icons.wifi_rounded),
    FacilityItem(label: 'Pool', icon: Icons.pool_rounded),
    FacilityItem(label: 'Breakfast', icon: Icons.free_breakfast_rounded),
    FacilityItem(label: 'Gym', icon: Icons.fitness_center_rounded),
    FacilityItem(label: 'Spa', icon: Icons.spa_rounded),
    FacilityItem(label: 'Parking', icon: Icons.local_parking_rounded),
  ],
  highlights: [
    '24/7 concierge assistance',
    'Airport transfer available',
    'Oceanfront dining experience',
    'Flexible check-in options',
  ],
);

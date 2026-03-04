import 'package:flutter/material.dart';

class OfferDetailsModel {
  final String id;
  final String title;
  final String location;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<String> gallery;
  final double pricePerNight;
  final double rating;
  final int reviewsCount;
  final List<FacilityItem> facilities;
  final List<String> highlights;

  const OfferDetailsModel({
    required this.id,
    required this.title,
    required this.location,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.gallery,
    required this.pricePerNight,
    required this.rating,
    required this.reviewsCount,
    required this.facilities,
    required this.highlights,
  });
}

class FacilityItem {
  final String label;
  final IconData icon;

  const FacilityItem({required this.label, required this.icon});
}

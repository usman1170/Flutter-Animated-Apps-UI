import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bookings/controllers/bookings_controller.dart';

class BookingDetailsController extends GetxController {
  late final BookingItem booking;
  final RxBool showAllAmenities = false.obs;

  @override
  void onInit() {
    super.onInit();
    booking = (Get.arguments is BookingItem)
        ? Get.arguments as BookingItem
        : _fallbackBooking;
  }

  List<AmenityItem> get amenities => const [
    AmenityItem(label: 'Free Wi-Fi', icon: Icons.wifi_rounded),
    AmenityItem(label: 'Infinity Pool', icon: Icons.pool_rounded),
    AmenityItem(label: 'Airport Pickup', icon: Icons.airport_shuttle_rounded),
    AmenityItem(label: 'Breakfast', icon: Icons.free_breakfast_rounded),
    AmenityItem(label: 'Spa Access', icon: Icons.spa_rounded),
    AmenityItem(label: 'Gym', icon: Icons.fitness_center_rounded),
  ];

  List<TimelineItem> get timeline => [
    const TimelineItem(
      title: 'Booking Confirmed',
      subtitle: 'Your reservation is secured.',
      time: 'Mar 1, 2026',
    ),
    TimelineItem(
      title: 'Check-in',
      subtitle: 'From 3:00 PM onward',
      time: booking.dateLabel.split('-').first.trim(),
    ),
    TimelineItem(
      title: 'Check-out',
      subtitle: 'Until 11:00 AM',
      time: booking.dateLabel.split('-').last.trim(),
    ),
  ];

  void toggleAmenities() {
    showAllAmenities.toggle();
  }
}

const BookingItem _fallbackBooking = BookingItem(
  hotelName: 'Azure Coast Resort',
  location: 'Nusa Penida, Bali',
  status: 'Confirmed',
  dateLabel: 'Mar 4 - Mar 8',
  imageUrl:
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
);

class AmenityItem {
  final String label;
  final IconData icon;

  const AmenityItem({required this.label, required this.icon});
}

class TimelineItem {
  final String title;
  final String subtitle;
  final String time;

  const TimelineItem({
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

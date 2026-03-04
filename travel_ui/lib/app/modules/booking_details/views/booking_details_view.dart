import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../controllers/booking_details_controller.dart';

class BookingDetailsView extends StatefulWidget {
  const BookingDetailsView({super.key});

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView>
    with SingleTickerProviderStateMixin {
  late final BookingDetailsController controller;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<BookingDetailsController>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = controller.booking;
    final bool isConfirmed = booking.status == 'Confirmed';

    return GradientScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 14),
                  _AnimatedSection(
                    animationController: _animationController,
                    position: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Hero(
                        tag: 'booking-image-${booking.hotelName}',
                        child: Stack(
                          children: [
                            Image.network(
                              booking.imageUrl,
                              width: double.infinity,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withAlpha(30),
                                      Colors.black.withAlpha(120),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              right: 14,
                              bottom: 14,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking.hotelName,
                                    style: AppTheme.displaySmall.copyWith(
                                      color: AppColor.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking.location,
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppColor.white.withAlpha(230),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _AnimatedSection(
                    animationController: _animationController,
                    position: 1,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColor.white.withAlpha(220),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: isConfirmed
                                  ? AppColor.primary.withAlpha(35)
                                  : Colors.orange.withAlpha(35),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              booking.status,
                              style: AppTheme.bodySmall.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isConfirmed
                                    ? AppColor.primary
                                    : const Color(0xFFB54708),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              booking.dateLabel,
                              style: AppTheme.titleSmall.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColor.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _AnimatedSection(
                    animationController: _animationController,
                    position: 2,
                    child: Text(
                      'Trip Timeline',
                      style: AppTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _AnimatedSection(
                    animationController: _animationController,
                    position: 3,
                    child: Column(
                      children: controller.timeline
                          .map(
                            (event) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColor.white.withAlpha(210),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: AppTheme.titleSmall.copyWith(
                                            color: AppColor.textPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          event.subtitle,
                                          style: AppTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    event.time,
                                    style: AppTheme.bodySmall.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _AnimatedSection(
                    animationController: _animationController,
                    position: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amenities',
                          style: AppTheme.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: controller.toggleAmenities,
                            child: Text(
                              controller.showAllAmenities.value
                                  ? 'Show less'
                                  : 'View all',
                              style: AppTheme.titleSmall.copyWith(
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final amenities = controller.amenities;
                    final visible = controller.showAllAmenities.value
                        ? amenities
                        : amenities.take(4).toList();

                    return _AnimatedSection(
                      animationController: _animationController,
                      position: 5,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: visible
                            .map(
                              (item) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.white.withAlpha(220),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 17,
                                      color: AppColor.primary,
                                    ),
                                    const SizedBox(width: 7),
                                    Text(
                                      item.label,
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppColor.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: _AnimatedSection(
                animationController: _animationController,
                position: 6,
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColor.textPrimary,
                            side: BorderSide(
                              color: AppColor.textPrimary.withAlpha(35),
                            ),
                            backgroundColor: AppColor.white.withAlpha(220),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.message_outlined, size: 18),
                          label: const Text('Support'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: AppColor.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Manage',
                            style: AppTheme.titleMedium.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColor.white.withAlpha(220),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 17,
              color: AppColor.textPrimary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text('Booking Details', style: AppTheme.displaySmall),
      ],
    );
  }
}

class _AnimatedSection extends StatelessWidget {
  final AnimationController animationController;
  final int position;
  final Widget child;

  const _AnimatedSection({
    required this.animationController,
    required this.position,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double start = math.min(position * 0.08, 0.8);
    final Animation<double> animation = CurvedAnimation(
      parent: animationController,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, (1 - animation.value) * 18),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
  }
}

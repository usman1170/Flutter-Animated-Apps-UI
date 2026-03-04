import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../controllers/offer_details_controller.dart';
import '../models/offer_details_model.dart';

class OfferDetailsView extends StatefulWidget {
  const OfferDetailsView({super.key});

  @override
  State<OfferDetailsView> createState() => _OfferDetailsViewState();
}

class _OfferDetailsViewState extends State<OfferDetailsView>
    with SingleTickerProviderStateMixin {
  late final OfferDetailsController controller;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<OfferDetailsController>();
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
    final OfferDetailsModel offer = controller.offer;
    final double bottomInset = MediaQuery.of(context).padding.bottom;

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 330,
                pinned: true,
                backgroundColor: AppColor.background,
                leading: _RoundActionButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: Get.back,
                ),
                actions: [
                  Obx(
                    () => _RoundActionButton(
                      icon: controller.isSaved.value
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      onTap: controller.toggleSaved,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'offer-image-${offer.id}',
                        child: Image.network(offer.imageUrl, fit: BoxFit.cover),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withAlpha(46),
                              Colors.black.withAlpha(178),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: AppTheme.displayMedium.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: AppColor.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  offer.location,
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: AppColor.white.withAlpha(230),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFDB022),
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${offer.rating} (${offer.reviewsCount})',
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 22, 16, bottomInset + 116),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 0,
                        child: _priceCard(offer),
                      ),
                      const SizedBox(height: 12),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 1,
                        child: _sectionTitle('About this stay'),
                      ),
                      const SizedBox(height: 8),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 2,
                        child: Text(
                          offer.description,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppColor.textSecondary.withAlpha(230),
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 3,
                        child: _sectionTitle('Facilities'),
                      ),
                      const SizedBox(height: 10),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 4,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: offer.facilities
                              .map((facility) => _facilityChip(facility))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 5,
                        child: _sectionTitle('Gallery'),
                      ),
                      const SizedBox(height: 10),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 6,
                        child: SizedBox(
                          height: 126,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: offer.gallery.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  offer.gallery[index],
                                  width: 156,
                                  height: 126,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 7,
                        child: _sectionTitle('Why guests love it'),
                      ),
                      const SizedBox(height: 10),
                      _AnimatedSection(
                        animationController: _animationController,
                        position: 8,
                        child: Column(
                          children: offer.highlights
                              .map(
                                (highlight) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.white.withAlpha(194),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColor.primary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          highlight,
                                          style: AppTheme.bodyMedium.copyWith(
                                            color: AppColor.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(offer),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(OfferDetailsModel offer) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.white.withAlpha(224),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: AppColor.black.withAlpha(18),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Starting from', style: AppTheme.bodySmall),
                Text(
                  '\$${offer.pricePerNight.toStringAsFixed(0)}/night',
                  style: AppTheme.titleLarge.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Book Now',
                  style: AppTheme.titleMedium.copyWith(color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceCard(OfferDetailsModel offer) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(199),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_offer_rounded,
            color: AppColor.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              offer.subtitle,
              style: AppTheme.bodyMedium.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Widget _facilityChip(FacilityItem facility) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white.withAlpha(212),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(facility.icon, color: AppColor.primary, size: 17),
          const SizedBox(width: 7),
          Text(
            facility.label,
            style: AppTheme.bodyMedium.copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        margin: const EdgeInsets.only(top: 8, left: 8),
        decoration: BoxDecoration(
          color: AppColor.white.withAlpha(194),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 17, color: AppColor.textPrimary),
      ),
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

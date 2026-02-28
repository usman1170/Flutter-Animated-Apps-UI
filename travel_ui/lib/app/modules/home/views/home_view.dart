import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/featured_offer_card.dart';
import 'widgets/hero_banner_card.dart';
import 'widgets/home_search_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Hi, Budiarti 👋',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textPrimary,
                          height: 1.05,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.cardSurface,
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        size: 30,
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const HomeSearchBar(),
                const SizedBox(height: 18),
                HeroBannerCard(imageUrl: controller.heroImage),
                const SizedBox(height: 28),
                Row(
                  children: const [
                    Text(
                      'Featured Offers',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textPrimary,
                        height: 1.05,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 318,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) =>
                        FeaturedOfferCard(offer: controller.offers[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 18),
                    itemCount: controller.offers.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

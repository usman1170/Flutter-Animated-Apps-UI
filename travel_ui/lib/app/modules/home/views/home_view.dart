import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/featured_card.dart';
import 'widgets/offer_section.dart';
import 'widgets/browse_more_section.dart';
import '../../../core/widgets/gradient_scaffold.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeHeader(),
              SizedBox(height: 8),
              FeaturedCard(),
              SizedBox(height: 8),
              OfferSection(),
              SizedBox(height: 12),
              BrowseMoreSection(),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

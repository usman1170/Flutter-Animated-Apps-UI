import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/header_section.dart';
import 'widgets/cards_section.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/spendings_section.dart';
import 'widgets/cashback_banner.dart';
import 'widgets/savings_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 16),
              HeaderSection(),
              SizedBox(height: 20),
              CardsSection(),
              SizedBox(height: 18),
              QuickActionsSection(),
              SizedBox(height: 24),
              SpendingsSection(),
              SizedBox(height: 18),
              CashbackBanner(),
              SizedBox(height: 18),
              SavingsCard(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

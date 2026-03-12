import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/balance_hero_section.dart';
import 'widgets/cards_section.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/spendings_section.dart';
import 'widgets/cashback_banner.dart';
import 'widgets/savings_card.dart';
import 'widgets/loans_section.dart';
import 'widgets/deposits_section.dart';
import 'widgets/history_section.dart';
import 'widgets/home_teaser_section.dart';
import 'widgets/home_app_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homeBg,
      appBar: const HomeAppBar(),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const Positioned.fill(child: _HomeBackdrop()),
            LayoutBuilder(
              builder: (context, constraints) {
                return Obx(() {
                  final isVisible = controller.isBalanceVisible.value;
                  final allowHiddenScroll = constraints.maxHeight < 690;
                  return SingleChildScrollView(
                    physics: isVisible
                        ? const BouncingScrollPhysics()
                        : allowHiddenScroll
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: isVisible ? 120 : 28),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BalanceHeroSection(),
                          const HomeTeaserSection(),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 520),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInOutCubic,
                            transitionBuilder: (child, animation) {
                              final offset = Tween<Offset>(
                                begin: const Offset(0, 0.04),
                                end: Offset.zero,
                              ).animate(animation);
                              final scale = Tween<double>(
                                begin: 0.985,
                                end: 1,
                              ).animate(animation);
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: offset,
                                  child: ScaleTransition(
                                    scale: scale,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: isVisible
                                ? const _DashboardContent(
                                    key: ValueKey('dashboard'),
                                  )
                                : const SizedBox.shrink(key: ValueKey('empty')),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBackdrop extends StatelessWidget {
  const _HomeBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned(
          left: -60,
          top: 170,
          child: _HomeGlow(
            size: 220,
            color: AppColor.paymentsBlueSoft,
            alpha: 64,
          ),
        ),
        Positioned(
          right: -70,
          top: 360,
          child: _HomeGlow(size: 210, color: AppColor.surfaceMint, alpha: 88),
        ),
        Positioned(
          left: 110,
          top: 520,
          child: _HomeGlow(
            size: 180,
            color: AppColor.surfaceLavender,
            alpha: 76,
          ),
        ),
      ],
    );
  }
}

class _HomeGlow extends StatelessWidget {
  final double size;
  final Color color;
  final int alpha;

  const _HomeGlow({
    required this.size,
    required this.color,
    required this.alpha,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(alpha),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6),
        CardsSection(),
        SizedBox(height: 18),
        QuickActionsSection(),
        SizedBox(height: 24),
        SpendingsSection(),
        SizedBox(height: 18),
        CashbackBanner(),
        SizedBox(height: 18),
        SavingsCard(),
        SizedBox(height: 16),
        LoansSection(),
        SizedBox(height: 16),
        DepositsSection(),
        SizedBox(height: 16),
        HistorySection(),
      ],
    );
  }
}

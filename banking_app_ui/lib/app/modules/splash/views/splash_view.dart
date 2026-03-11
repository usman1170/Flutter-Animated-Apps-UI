import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.splashStart, AppColor.splashEnd],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const _SplashArtwork(),
                const SizedBox(height: 34),
                const Text(
                  'USBank',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textStrong,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Smart banking with clean transfers,\npayments, savings, and everyday control.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: AppColor.splashInk,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColor.white.withAlpha(176),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.paymentsBlue,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Loading your dashboard',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textMid,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashArtwork extends StatelessWidget {
  const _SplashArtwork();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withAlpha(78),
              ),
            ),
            Container(
              width: 198,
              height: 198,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withAlpha(120),
              ),
            ),
            Positioned(
              left: 24,
              top: 52,
              child: Transform.rotate(
                angle: -0.16,
                child: Container(
                  width: 76,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColor.splashCardSoft,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 34,
              bottom: 44,
              child: Transform.rotate(
                angle: 0.14,
                child: Container(
                  width: 86,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColor.white.withAlpha(168),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: -0.12,
              child: Container(
                width: 132,
                height: 154,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColor.splashCard, AppColor.paymentsBlue],
                  ),
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withAlpha(26),
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white.withAlpha(220),
                    ),
                    child: const Icon(
                      LucideIcons.landmark,
                      size: 32,
                      color: AppColor.splashInk,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 42,
              right: 58,
              child: Transform.rotate(
                angle: 0.24,
                child: Container(
                  width: 42,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColor.white.withAlpha(206),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

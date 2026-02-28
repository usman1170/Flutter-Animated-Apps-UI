import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HeroBannerCard extends StatelessWidget {
  const HeroBannerCard({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.overlaySoft, AppColor.overlayDark],
                ),
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              bottom: 28,
              child: Column(
                children: [
                  const Text(
                    'Escape The Ordinary',
                    style: TextStyle(
                      color: AppColor.textLight,
                      fontSize: 42,
                      height: 1.06,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find exclusive hotel deals worldwide',
                    style: TextStyle(
                      color: AppColor.textLight,
                      fontSize: 18,
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Container(
                    height: 52,
                    width: 172,
                    decoration: BoxDecoration(
                      color: AppColor.cardSurface.withValues(alpha: 0.34),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Explore Now',
                      style: TextStyle(
                        color: AppColor.textLight,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

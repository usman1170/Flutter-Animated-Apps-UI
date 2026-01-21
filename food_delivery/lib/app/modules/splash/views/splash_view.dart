import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _SplashBackground(),
          Center(
            child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                final pulse = Tween<double>(begin: 0.95, end: 1.05)
                    .animate(CurvedAnimation(
                  parent: controller.animationController,
                  curve: Curves.easeInOut,
                ));
                return Transform.scale(
                  scale: pulse.value,
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withAlpha(140),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 52,
                      height: 52,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Food Delivery',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fresh drops, fast routes.',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withAlpha(179),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 140,
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Warming up flavors...',
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withAlpha(140),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundStart =
        isDark ? const Color(0xFF0E0F13) : const Color(0xFFF6F4F0);
    final backgroundEnd =
        isDark ? const Color(0xFF14161C) : const Color(0xFFFFFFFF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundStart,
            backgroundEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -80,
            top: -40,
            child: _GlowBlob(
              size: 200,
              color: accentColor.withAlpha(110),
            ),
          ),
          Positioned(
            right: -120,
            top: 40,
            child: _GlowBlob(
              size: 220,
              color: accentColor.withAlpha(95),
            ),
          ),
          Positioned(
            right: -60,
            bottom: 120,
            child: _GlowBlob(
              size: 180,
              color: accentColor.withAlpha(85),
            ),
          ),
          Positioned(
            left: -40,
            bottom: 140,
            child: _GlowBlob(
              size: 160,
              color: accentColor.withAlpha(80),
            ),
          ),
          Positioned(
            left: 40,
            top: 180,
            child: _GlowBlob(
              size: 160,
              color: const Color(0xFF7BE495).withAlpha(90),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: _GlowBlob(
              size: 200,
              color: const Color(0xFF7BE495).withAlpha(80),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
          stops: const [0, 0.7],
        ),
      ),
    );
  }
}

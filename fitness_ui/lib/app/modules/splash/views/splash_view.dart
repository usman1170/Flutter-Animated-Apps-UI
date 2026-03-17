import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import 'components/splash_background.dart';
import 'components/splash_core.dart';
import 'components/splash_panels.dart';
import 'components/splash_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Get.offNamed(Routes.HOME);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final value = _controller.value;
          final glow = Curves.easeInOut.transform(
            0.5 + (math.sin(value * math.pi * 4) * 0.5),
          );
          final titleOpacity = Interval(
            0.16,
            0.44,
            curve: Curves.easeOutCubic,
          ).transform(value);
          final cardOpacity = Interval(
            0.3,
            0.68,
            curve: Curves.easeOutCubic,
          ).transform(value);
          final footerOpacity = Interval(
            0.5,
            0.9,
            curve: Curves.easeOutCubic,
          ).transform(value);
          final exitOpacity =
              1 - Interval(0.86, 1, curve: Curves.easeIn).transform(value);
          return Opacity(
            opacity: exitOpacity.clamp(0, 1),
            child: Stack(
              fit: StackFit.expand,
              children: [
                SplashBackground(progress: value, glow: glow),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TopBadge(opacity: titleOpacity),
                        ),
                        const Spacer(),
                        Transform.translate(
                          offset: Offset(0, 26 * (1 - titleOpacity)),
                          child: Opacity(
                            opacity: titleOpacity,
                            child: Column(
                              children: [
                                SplashCore(progress: value, glow: glow),
                                const SizedBox(height: 28),
                                TitleBlock(opacity: titleOpacity),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Transform.translate(
                          offset: Offset(0, 22 * (1 - cardOpacity)),
                          child: Opacity(
                            opacity: cardOpacity,
                            child: StatusPanel(progress: value),
                          ),
                        ),
                        const Spacer(),
                        Opacity(
                          opacity: footerOpacity,
                          child: FooterProgress(progress: value),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

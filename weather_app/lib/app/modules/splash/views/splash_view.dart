import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  double _stageOpacity(double t, double start, double end) {
    if (t < start || t > end) return 0;
    final local = (t - start) / (end - start);
    return local < 0.5 ? local * 2 : (1 - local) * 2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1736), Color(0xFF183A76)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: controller.animation,
            builder: (context, child) {
              final t = controller.animation.value;
              final sunOpacity = _stageOpacity(t, 0.0, 0.4);
              final cloudOpacity = _stageOpacity(t, 0.25, 0.7);
              final rainOpacity = _stageOpacity(t, 0.55, 1.0);
              final scale = 0.9 + (0.12 * Curves.easeInOut.transform(t));

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: scale,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: sunOpacity,
                          child: Icon(
                            Icons.wb_sunny_rounded,
                            size: 120,
                            color: const Color(0xFF7AC6FF),
                          ),
                        ),
                        Opacity(
                          opacity: cloudOpacity,
                          child: Icon(
                            Icons.cloud_rounded,
                            size: 130,
                            color: const Color(0xFFB5D9FF),
                          ),
                        ),
                        Opacity(
                          opacity: rainOpacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.cloud_rounded,
                                size: 130,
                                color: Color(0xFF88B6E9),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.grain, color: Color(0xFF7AC6FF)),
                                  SizedBox(width: 8),
                                  Icon(Icons.grain, color: Color(0xFF7AC6FF)),
                                  SizedBox(width: 8),
                                  Icon(Icons.grain, color: Color(0xFF7AC6FF)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'SkyPulse',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Forecasts in motion',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

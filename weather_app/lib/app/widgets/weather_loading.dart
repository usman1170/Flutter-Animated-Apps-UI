import 'dart:math';

import 'package:flutter/material.dart';

class WeatherLoading extends StatefulWidget {
  const WeatherLoading({super.key});

  @override
  State<WeatherLoading> createState() => _WeatherLoadingState();
}

class _WeatherLoadingState extends State<WeatherLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B1736), Color(0xFF1B3E78)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value;
            final float = 6 * (0.5 - (0.5 - t).abs());
            final pulse = 0.9 + 0.1 * sin(t * 2 * pi);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(0, -float),
                  child: Transform.scale(
                    scale: pulse,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFFF7C2).withAlpha(230),
                                const Color(0xFFFFD27A).withAlpha(153),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.cloud,
                          size: 70,
                          color: Color(0xFFB7D6F6),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 14,
                          child: Row(
                            children: const [
                              Icon(Icons.grain,
                                  color: Color(0xFF7AC6FF), size: 14),
                              SizedBox(width: 4),
                              Icon(Icons.grain,
                                  color: Color(0xFF7AC6FF), size: 14),
                              SizedBox(width: 4),
                              Icon(Icons.grain,
                                  color: Color(0xFF7AC6FF), size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Gathering skies…',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Updating live conditions',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

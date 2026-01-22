import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SunPath extends StatefulWidget {
  const SunPath({super.key, required this.progress});

  final double progress;

  @override
  State<SunPath> createState() => _SunPathState();
}

class _SunPathState extends State<SunPath>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = 0.9 + 0.1 * sin(_controller.value * 2 * pi);
        final value = (widget.progress * 100).clamp(0.0, 100.0);
        return SizedBox(
          height: 170,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 170 * pulse,
                  height: 170 * pulse,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFFE7A3).withOpacity(0.25),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: value,
                  appearance: CircularSliderAppearance(
                    startAngle: 180,
                    angleRange: 180,
                    size: 180,
                    customWidths: CustomSliderWidths(
                      trackWidth: 4,
                      progressBarWidth: 6,
                      handlerSize: 10,
                    ),
                    customColors: CustomSliderColors(
                      trackColor: Colors.white.withOpacity(0.2),
                      progressBarColor: const Color(0xFF9AD9FF),
                      dotColor: const Color(0xFFFFD56A),
                    ),
                    infoProperties: InfoProperties(
                      mainLabelStyle:
                          const TextStyle(color: Colors.transparent),
                      modifier: (double _) => '',
                    ),
                  ),
                  innerWidget: (_) {
                    return Center(
                      child: Transform.scale(
                        scale: pulse,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFFD56A),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

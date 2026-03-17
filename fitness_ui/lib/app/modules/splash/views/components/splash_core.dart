import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashCore extends StatelessWidget {
  const SplashCore({super.key, required this.progress, required this.glow});

  final double progress;
  final double glow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width.clamp(260.0, 360.0);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _Ring(
            size: size,
            progress: progress,
            glow: glow,
            start: 0.08,
            sweep: 0.72,
            strokeWidth: 3.2,
          ),
          _Ring(
            size: size * 0.8,
            progress: 1 - progress,
            glow: glow,
            start: 0.42,
            sweep: 0.56,
            strokeWidth: 2.6,
          ),
          _Ring(
            size: size * 0.58,
            progress: progress,
            glow: glow,
            start: 0.7,
            sweep: 0.44,
            strokeWidth: 2,
          ),
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: size * 0.26,
              height: size * 0.26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.accent.withAlpha((170 + glow * 70).round()),
                  width: 1.6,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B2D40), Color(0xFF0D1825)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withAlpha((35 + glow * 35).round()),
                    blurRadius: 26,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.accent,
                  size: size * 0.12,
                ),
              ),
            ),
          ),
          Positioned(
            top: size * 0.09,
            child: _PulseDot(offset: 0, progress: progress),
          ),
          Positioned(
            right: size * 0.1,
            child: _PulseDot(offset: 0.25, progress: progress),
          ),
          Positioned(
            bottom: size * 0.12,
            child: _PulseDot(offset: 0.5, progress: progress),
          ),
          Positioned(
            left: size * 0.08,
            child: _PulseDot(offset: 0.75, progress: progress),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({
    required this.size,
    required this.progress,
    required this.glow,
    required this.start,
    required this.sweep,
    required this.strokeWidth,
  });

  final double size;
  final double progress;
  final double glow;
  final double start;
  final double sweep;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: progress * math.pi * 2,
      child: CustomPaint(
        size: Size.square(size),
        painter: _RingPainter(
          start: start,
          sweep: sweep,
          glow: glow,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _PulseDot extends StatelessWidget {
  const _PulseDot({required this.offset, required this.progress});

  final double offset;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final value = ((progress + offset) % 1.0);
    final scale = 0.75 + (math.sin(value * math.pi * 2) + 1) * 0.18;
    final opacity = 0.35 + (math.sin(value * math.pi * 2) + 1) * 0.18;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.accent.withAlpha((opacity * 255).round()),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withAlpha((opacity * 180).round()),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.start,
    required this.sweep,
    required this.glow,
    required this.strokeWidth,
  });

  final double start;
  final double sweep;
  final double glow;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final track = Paint()
      ..color = const Color(0xFF223549)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect.deflate(strokeWidth), 0, math.pi * 2, false, track);

    final active = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.accent.withAlpha((30 + glow * 20).round()),
          AppColors.accent,
          const Color(0xFF7AF2FF),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawArc(
      rect.deflate(strokeWidth),
      start * math.pi * 2,
      sweep * math.pi * 2,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.sweep != sweep ||
        oldDelegate.glow != glow ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

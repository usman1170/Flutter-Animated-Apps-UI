import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({
    super.key,
    required this.progress,
    required this.glow,
  });

  final double progress;
  final double glow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.2),
              radius: 1.1,
              colors: [
                const Color(0xFF0B1724),
                AppColors.background,
                const Color(0xFF040B12),
              ],
              stops: const [0, 0.55, 1],
            ),
          ),
        ),
        Positioned(
          top: -120 + (progress * 28),
          right: -70,
          child: _GlowOrb(size: 240, opacity: 0.18 + (glow * 0.1)),
        ),
        Positioned(
          bottom: -120 + (progress * 20),
          left: -80,
          child: _GlowOrb(size: 220, opacity: 0.1 + (glow * 0.08)),
        ),
        CustomPaint(
          painter: _GridPainter(progress: progress, glow: glow),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.accent.withAlpha((opacity * 255).round()),
            AppColors.accent.withAlpha(0),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.progress, required this.glow});

  final double progress;
  final double glow;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF173149).withAlpha((50 + glow * 40).round())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const spacing = 34.0;
    final verticalShift = (progress * spacing * 2) % spacing;
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        gridPaint,
      );
    }
    for (double y = -spacing; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y + verticalShift),
        Offset(size.width, y + verticalShift),
        gridPaint..color = const Color(0xFF102436).withAlpha(28),
      );
    }

    final sweep = Rect.fromCircle(
      center: Offset(size.width / 2, size.height * 0.55),
      radius: size.width * 0.46,
    );
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.accent.withAlpha(0),
          AppColors.accent.withAlpha((70 + glow * 60).round()),
          AppColors.accent.withAlpha(0),
        ],
        stops: const [0, 0.16, 0.34],
        transform: GradientRotation(math.pi * 2 * progress),
      ).createShader(sweep)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawArc(sweep, 0, math.pi * 2, false, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.glow != glow;
  }
}

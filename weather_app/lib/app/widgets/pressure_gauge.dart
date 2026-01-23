import 'dart:math';

import 'package:flutter/material.dart';

class PressureGauge extends StatefulWidget {
  const PressureGauge({
    super.key,
    required this.pressure,
    this.size = const Size(110, 72),
  });

  final int pressure;
  final Size size;

  @override
  State<PressureGauge> createState() => _PressureGaugeState();
}

class _PressureGaugeState extends State<PressureGauge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
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
        final wiggle = sin(_controller.value * 2 * pi) * 0.03;
        return CustomPaint(
          painter: _PressureGaugePainter(widget.pressure, wiggle),
          size: widget.size,
        );
      },
    );
  }
}

class _PressureGaugePainter extends CustomPainter {
  _PressureGaugePainter(this.pressure, this.wiggle);

  final int pressure;
  final double wiggle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width * 0.42;
    final basePaint = Paint()
      ..color = Colors.white.withAlpha(51)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final activePaint = Paint()
      ..color = const Color(0xFF9AD9FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      basePaint,
    );

    final normalized = ((pressure - 980) / 70).clamp(0.0, 1.0);
    final sweep = pi * (normalized + wiggle).clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweep,
      false,
      activePaint,
    );

    final angle = pi + sweep;
    final pointer = Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(pointer, 4.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _PressureGaugePainter oldDelegate) {
    return oldDelegate.pressure != pressure || oldDelegate.wiggle != wiggle;
  }
}

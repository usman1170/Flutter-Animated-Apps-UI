import 'package:flutter/material.dart';
import 'dart:math';

class ThermostatPainter extends CustomPainter {
  final double value;

  ThermostatPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate bounds tightly around the half circle
    final center = Offset(size.width / 2, size.height);
    // Radius is slightly smaller than half width to account for stroke width
    final radius = (size.width / 2) - 4; // 4 is half of strokeWidth 8

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFFE6885B), Color(0xFF5BA4E6)],
        startAngle: pi,
        endAngle: 2 * pi,
        transform: GradientRotation(pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      bgPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi * value,
      false,
      activePaint,
    );

    final knobAngle = pi + (pi * value);
    final knobOffset = Offset(
      center.dx + radius * cos(knobAngle),
      center.dy + radius * sin(knobAngle),
    );

    final knobPaint = Paint()..color = Colors.white;
    canvas.drawCircle(knobOffset, 5, knobPaint);
  }

  @override
  bool shouldRepaint(covariant ThermostatPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

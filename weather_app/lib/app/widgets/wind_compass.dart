import 'dart:math';

import 'package:flutter/material.dart';

class WindCompass extends StatefulWidget {
  const WindCompass({super.key, required this.degrees});

  final int degrees;

  @override
  State<WindCompass> createState() => _WindCompassState();
}

class _WindCompassState extends State<WindCompass>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
        final pulse = 0.92 + 0.08 * sin(_controller.value * 2 * pi);
        final sweep = _controller.value * 2 * pi;
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 1.2),
              ),
            ),
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withAlpha(20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            CustomPaint(
              size: const Size(88, 88),
              painter: _CompassRingPainter(sweep),
            ),
            Container(
              width: 64 * pulse,
              height: 64 * pulse,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white12, width: 1),
              ),
            ),
            Transform.rotate(
              angle: (widget.degrees - 90) * pi / 180,
              child: CustomPaint(
                size: const Size(44, 44),
                painter: _CompassArrowPainter(),
              ),
            ),
            Positioned(
              right: 6,
              child: Text('E',
                  style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 10)),
            ),
            Positioned(
              left: 6,
              child: Text('W',
                  style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 10)),
            ),
            const Positioned(
              top: 4,
              child: Text('N',
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
            ),
            Positioned(
              bottom: 4,
              child: Text('S',
                  style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 10)),
            ),
          ],
        );
      },
    );
  }
}

class _CompassRingPainter extends CustomPainter {
  _CompassRingPainter(this.sweep);

  final double sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF7AC6FF),
          Color(0xFFFFD56A),
          Color(0xFF7AC6FF),
        ],
      ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: rect.center, radius: size.width / 2 - 2),
      sweep,
      pi / 2,
      false,
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CompassRingPainter oldDelegate) {
    return oldDelegate.sweep != sweep;
  }
}

class _CompassArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final arrowPaint = Paint()
      ..color = const Color(0xFF7AC6FF)
      ..style = PaintingStyle.fill;
    final shadowPaint = Paint()
      ..color = const Color(0xFF7AC6FF).withAlpha(89)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final path = Path()
      ..moveTo(center.dx + 18, center.dy)
      ..lineTo(center.dx - 6, center.dy - 8)
      ..lineTo(center.dx - 2, center.dy)
      ..lineTo(center.dx - 6, center.dy + 8)
      ..close();

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, arrowPaint);
    canvas.drawCircle(center, 3, Paint()..color = Colors.white70);
  }

  @override
  bool shouldRepaint(covariant _CompassArrowPainter oldDelegate) => false;
}

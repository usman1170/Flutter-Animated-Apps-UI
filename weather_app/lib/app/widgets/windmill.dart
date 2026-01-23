import 'dart:math';

import 'package:flutter/material.dart';

class Windmill extends StatefulWidget {
  const Windmill({super.key, required this.speed});

  final double speed;

  @override
  State<Windmill> createState() => _WindmillState();
}

class _WindmillState extends State<Windmill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _durationFromSpeed(widget.speed),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant Windmill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.speed != widget.speed) {
      _controller.duration = _durationFromSpeed(widget.speed);
      _controller.repeat();
    }
  }

  Duration _durationFromSpeed(double speed) {
    final clamped = speed.clamp(0.5, 12.0);
    final ms = (2000 / clamped).round();
    return Duration(milliseconds: ms);
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
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: CustomPaint(
        size: const Size(48, 48),
        painter: _WindmillPainter(),
      ),
    );
  }
}

class _WindmillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final bladePaint = Paint()..color = Colors.white.withAlpha(217);
    final hubPaint = Paint()..color = Colors.white;

    for (int i = 0; i < 4; i++) {
      final angle = i * (pi / 2);
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(center.dx + 4 * cos(angle), center.dy + 4 * sin(angle))
        ..lineTo(center.dx + 18 * cos(angle + 0.2),
            center.dy + 18 * sin(angle + 0.2))
        ..lineTo(center.dx + 18 * cos(angle - 0.2),
            center.dy + 18 * sin(angle - 0.2))
        ..close();
      canvas.drawPath(path, bladePaint);
    }

    canvas.drawCircle(center, 4, hubPaint);
  }

  @override
  bool shouldRepaint(covariant _WindmillPainter oldDelegate) => false;
}

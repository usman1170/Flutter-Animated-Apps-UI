import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/weather_kind.dart';

class WeatherBackground extends StatefulWidget {
  const WeatherBackground({super.key, required this.kind});

  final WeatherKind kind;

  @override
  State<WeatherBackground> createState() => _WeatherBackgroundState();
}

class _WeatherBackgroundState extends State<WeatherBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Offset> _stars;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _stars = List.generate(40, (index) {
      final rand = Random(index * 12 + 7);
      return Offset(rand.nextDouble(), rand.nextDouble());
    });
  }

  @override
  void didUpdateWidget(covariant WeatherBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kind != widget.kind) {
      _controller.reset();
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _gradientFor(widget.kind);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            if (widget.kind == WeatherKind.sunnyDay) const _HorizonGlow(),
            if (widget.kind == WeatherKind.clearNight ||
                widget.kind == WeatherKind.cloudyNight)
              const _NightHaze(),
            if (widget.kind == WeatherKind.clearNight)
              CustomPaint(painter: _StarPainter(_stars, _controller.value)),
            if (widget.kind == WeatherKind.sunnyDay)
              Positioned(
                top: 40 + (12 * sin(_controller.value * 2 * pi)),
                right: 30,
                child: _SunGlow(
                  scale: 1.0 + 0.06 * sin(_controller.value * 2 * pi),
                ),
              ),
            if (widget.kind == WeatherKind.clearNight ||
                widget.kind == WeatherKind.cloudyNight)
              Positioned(
                top: 60 + (6 * sin(_controller.value * 2 * pi)),
                right: 40,
                child: const _MoonGlow(),
              ),
            if (widget.kind == WeatherKind.cloudyDay ||
                widget.kind == WeatherKind.cloudyNight)
              CustomPaint(
                painter: _CloudPainter(_controller.value, widget.kind),
              ),
            if (widget.kind == WeatherKind.rain)
              Stack(
                children: [
                  CustomPaint(
                    painter: _CloudPainter(_controller.value, widget.kind),
                  ),
                  CustomPaint(
                    painter: _RainPainter(_controller.value),
                  ),
                ],
              ),
            if (widget.kind == WeatherKind.fog)
              _FogLayer(progress: _controller.value),
          ],
        );
      },
    );
  }

  List<Color> _gradientFor(WeatherKind kind) {
    switch (kind) {
      case WeatherKind.clearNight:
        return const [Color(0xFF060B1E), Color(0xFF101B3F)];
      case WeatherKind.cloudyNight:
        return const [Color(0xFF0B1533), Color(0xFF1B2E59)];
      case WeatherKind.rain:
        return const [Color(0xFF0B1A3B), Color(0xFF1F3E76)];
      case WeatherKind.fog:
        return const [Color(0xFF1E2E4F), Color(0xFF3E5A7E)];
      case WeatherKind.cloudyDay:
        return const [Color(0xFF6EBBE7), Color(0xFF2F6EAD)];
      case WeatherKind.sunnyDay:
        return const [Color(0xFF7CCBFF), Color(0xFF2C6AB5)];
    }
  }
}
class _SunGlow extends StatelessWidget {
  const _SunGlow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFFFFF7C2).withOpacity(0.9),
              const Color(0xFFFFD27A).withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE7A3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
class _MoonGlow extends StatelessWidget {
  const _MoonGlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFFEAF2FF).withOpacity(0.9),
            const Color(0xFF9AB8E3).withOpacity(0.45),
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFEAF2FF),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
class _StarPainter extends CustomPainter {
  _StarPainter(this.stars, this.progress);

  final List<Offset> stars;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (final star in stars) {
      final twinkle = 0.4 + 0.6 * sin((progress + star.dx) * 2 * pi);
      paint.color = Colors.white.withOpacity(twinkle);
      canvas.drawCircle(
        Offset(star.dx * size.width, star.dy * size.height * 0.6),
        1.5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
class _RainPainter extends CustomPainter {
  _RainPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withOpacity(0.65)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 110; i++) {
      final x = (i * 13) % size.width;
      final y = ((i * 31 + progress * 720) % size.height);
      canvas.drawLine(Offset(x, y), Offset(x - 4, y + 14), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
class _FogLayer extends StatelessWidget {
  const _FogLayer({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final offset = 20 * sin(progress * 2 * pi);
    return Stack(
      children: [
        Positioned(
          left: -40 + offset,
          right: 40 - offset,
          top: 120,
          child: _FogBand(opacity: 0.35),
        ),
        Positioned(
          left: 20 - offset,
          right: -20 + offset,
          top: 200,
          child: _FogBand(opacity: 0.25),
        ),
      ],
    );
  }
}
class _FogBand extends StatelessWidget {
  const _FogBand({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
class _CloudPainter extends CustomPainter {
  _CloudPainter(this.progress, this.kind);

  final double progress;
  final WeatherKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final day = kind == WeatherKind.cloudyDay || kind == WeatherKind.rain;
    final baseColor = day ? Colors.white : const Color(0xFFB9C9E8);
    final opacity = day ? 0.7 : 0.45;
    final paint = Paint()
      ..color = baseColor.withOpacity(opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    _drawCloud(canvas, size, paint, 0.18, 0.12, 0.42, 0.16, 0.08, 0.8);
    _drawCloud(canvas, size, paint, 0.62, 0.18, 0.48, 0.18, 0.06, 0.6);
    _drawCloud(canvas, size, paint, 0.36, 0.28, 0.62, 0.2, 0.04, 0.5);
  }

  void _drawCloud(
    Canvas canvas,
    Size size,
    Paint paint,
    double cx,
    double cy,
    double width,
    double height,
    double drift,
    double speed,
  ) {
    final dx = (progress * speed + drift) % 1.0;
    final x = (cx + dx - 0.5) * size.width;
    final y = cy * size.height;
    final w = width * size.width;
    final h = height * size.height;

    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(x + w * 0.2, y + h * 0.55),
          radius: h * 0.35,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(x + w * 0.45, y + h * 0.35),
          radius: h * 0.45,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(x + w * 0.7, y + h * 0.55),
          radius: h * 0.35,
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + w * 0.1, y + h * 0.4, w * 0.75, h * 0.4),
          Radius.circular(h * 0.2),
        ),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CloudPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.kind != kind;
  }
}
class _HorizonGlow extends StatelessWidget {
  const _HorizonGlow();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFF6C7).withOpacity(0.15),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
class _NightHaze extends StatelessWidget {
  const _NightHaze();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF091127).withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}

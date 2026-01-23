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
    _stars = List.generate(60, (index) {
      final rand = Random(index * 19 + 11);
      return Offset(rand.nextDouble(), rand.nextDouble());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kind = widget.kind;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Container(
                key: ValueKey(kind),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _gradientFor(kind),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            if (kind == WeatherKind.clearDay)
              Positioned(
                top: 32 + (10 * sin(t * 2 * pi)),
                right: 30,
                child: _SunGlow(scale: 1.0 + 0.05 * sin(t * 2 * pi)),
              ),
            if (kind == WeatherKind.clearNight ||
                kind == WeatherKind.cloudyNight)
              Positioned(
                top: 52 + (6 * sin(t * 2 * pi)),
                right: 40,
                child: const _MoonGlow(),
              ),
            if (kind == WeatherKind.clearNight)
              CustomPaint(painter: _StarPainter(_stars, t)),
            if (kind == WeatherKind.clearDay)
              CustomPaint(painter: _CloudPainter(t, opacity: 0.18)),
            if (kind == WeatherKind.cloudyDay ||
                kind == WeatherKind.cloudyNight)
              CustomPaint(painter: _CloudPainter(t, opacity: 0.45)),
            if (kind == WeatherKind.rain || kind == WeatherKind.thunderstorm)
              CustomPaint(painter: _CloudPainter(t, opacity: 0.55)),
            if (kind == WeatherKind.rain || kind == WeatherKind.thunderstorm)
              CustomPaint(painter: _RainPainter(t)),
            if (kind == WeatherKind.snow) CustomPaint(painter: _SnowPainter(t)),
            if (kind == WeatherKind.fog) _FogLayer(progress: t),
            if (kind == WeatherKind.rain ||
                kind == WeatherKind.thunderstorm ||
                kind == WeatherKind.snow ||
                kind == WeatherKind.fog)
              _MistOverlay(intensity: 0.12 + 0.05 * sin(t * 2 * pi)),
            if (kind == WeatherKind.thunderstorm) _LightningFlash(progress: t),
            if (_needsDarkOverlay(kind))
              Container(color: Colors.black.withAlpha(46)),
          ],
        );
      },
    );
  }

  List<Color> _gradientFor(WeatherKind kind) {
    switch (kind) {
      case WeatherKind.clearNight:
        return const [Color(0xFF050916), Color(0xFF111C3F)];
      case WeatherKind.cloudyNight:
        return const [Color(0xFF0B1533), Color(0xFF1B2E59)];
      case WeatherKind.rain:
        return const [Color(0xFF0B1A3B), Color(0xFF1F3E76)];
      case WeatherKind.thunderstorm:
        return const [Color(0xFF08132B), Color(0xFF162C52)];
      case WeatherKind.snow:
        return const [Color(0xFF2A4B78), Color(0xFF5A7CAA)];
      case WeatherKind.fog:
        return const [Color(0xFF1E2E4F), Color(0xFF3E5A7E)];
      case WeatherKind.cloudyDay:
        return const [Color(0xFF6EBBE7), Color(0xFF2F6EAD)];
      case WeatherKind.clearDay:
        return const [Color(0xFF7CCBFF), Color(0xFF2C6AB5)];
    }
  }

  bool _needsDarkOverlay(WeatherKind kind) {
    return kind == WeatherKind.clearNight ||
        kind == WeatherKind.cloudyNight ||
        kind == WeatherKind.rain ||
        kind == WeatherKind.thunderstorm;
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
              const Color(0xFFFFF7C2).withAlpha(230),
              const Color(0xFFFFD27A).withAlpha(153),
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
            const Color(0xFFEAF2FF).withAlpha(230),
            const Color(0xFF9AB8E3).withAlpha(115),
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
    final paint = Paint()..color = Colors.white.withAlpha(204);
    for (final star in stars) {
      final twinkle = 0.4 + 0.6 * sin((progress + star.dx) * 2 * pi);
      paint.color = Colors.white.withAlpha((twinkle * 255).round());
      canvas.drawCircle(
        Offset(star.dx * size.width, star.dy * size.height * 0.6),
        1.3,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
class _CloudPainter extends CustomPainter {
  _CloudPainter(this.progress, {required this.opacity});

  final double progress;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((opacity * 255).round())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    _drawCloud(canvas, size, paint, 0.12, 0.12, 0.46, 0.18, 0.08, 0.7);
    _drawCloud(canvas, size, paint, 0.58, 0.2, 0.52, 0.2, 0.02, 0.5);
    _drawCloud(canvas, size, paint, 0.34, 0.32, 0.66, 0.22, 0.05, 0.35);
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
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}
class _RainPainter extends CustomPainter {
  _RainPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withAlpha(166)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 120; i++) {
      final x = (i * 13) % size.width;
      final y = ((i * 31 + progress * 820) % size.height);
      canvas.drawLine(Offset(x, y), Offset(x - 4, y + 14), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SnowPainter extends CustomPainter {
  _SnowPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(204);
    for (int i = 0; i < 90; i++) {
      final x = (i * 19) % size.width;
      final y = ((i * 23 + progress * 220) % size.height);
      final radius = 1.5 + (i % 3) * 0.6;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnowPainter oldDelegate) {
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
        color: Colors.white.withAlpha((opacity * 255).round()),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class _MistOverlay extends StatelessWidget {
  const _MistOverlay({required this.intensity});

  final double intensity;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white.withAlpha((intensity * 255).round()));
  }
}

class _LightningFlash extends StatelessWidget {
  const _LightningFlash({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final flicker = (sin(progress * 16 * pi) + sin(progress * 7 * pi)) * 0.5;
    final opacity = flicker > 0.85 ? (flicker - 0.85) * 2.5 : 0.0;
    return IgnorePointer(
      child: Container(color: Colors.white.withAlpha((opacity * 255).round())),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import '../data/models/weather_models.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';

class HourlyStrip extends StatelessWidget {
  const HourlyStrip({super.key, required this.hourly});

  final List<HourlyWeather> hourly;

  @override
  Widget build(BuildContext context) {
    final items = hourly.take(8).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int currentIndex = 0;
    int bestDelta = (items.first.dt - now).abs();
    for (int i = 1; i < items.length; i++) {
      final delta = (items[i].dt - now).abs();
      if (delta < bestDelta) {
        bestDelta = delta;
        currentIndex = i;
      }
    }

    return GlassCard(
      radius: 22,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 170,
        child: LayoutBuilder(
          builder: (context, constraints) {
            const itemWidth = 74.0;
            final width = max(itemWidth * items.length, constraints.maxWidth);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: width,
                height: 170,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _HourlyTempPainter(
                          items: items,
                          itemWidth: itemWidth,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                          highlightIndex: currentIndex,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: items
                          .asMap()
                          .entries
                          .map(
                            (entry) => SizedBox(
                              width: itemWidth,
                              child: _HourlyCell(
                                item: entry.value,
                                isCurrent: entry.key == currentIndex,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HourlyCell extends StatelessWidget {
  const _HourlyCell({required this.item, required this.isCurrent});

  final HourlyWeather item;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 56),
          Icon(
            _iconFor(item),
            color: _iconColor(item),
            size: isCurrent ? 20 : 18,
          ),
          const SizedBox(height: 6),
          Text(
            '${item.windSpeed.toStringAsFixed(1)} m/s',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isCurrent ? Colors.white : Colors.white70,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            formatHour(item.dt),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isCurrent ? Colors.white : Colors.white54,
                ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(HourlyWeather item) {
    final main = item.weather.isNotEmpty
        ? item.weather.first.main.toLowerCase()
        : '';
    if (main.contains('rain')) return Icons.grain;
    if (main.contains('cloud')) return Icons.cloud;
    if (main.contains('storm')) return Icons.thunderstorm;
    if (main.contains('snow')) return Icons.ac_unit;
    return Icons.wb_sunny;
  }

  Color _iconColor(HourlyWeather item) {
    final main = item.weather.isNotEmpty
        ? item.weather.first.main.toLowerCase()
        : '';
    if (main.contains('rain')) return const Color(0xFF7AC6FF);
    if (main.contains('cloud')) return const Color(0xFFB7D6F6);
    if (main.contains('storm')) return const Color(0xFFFFC857);
    if (main.contains('snow')) return const Color(0xFFD8F1FF);
    return const Color(0xFFFFD56A);
  }
}

class _HourlyTempPainter extends CustomPainter {
  _HourlyTempPainter({
    required this.items,
    required this.itemWidth,
    required this.textStyle,
    required this.highlightIndex,
  });

  final List<HourlyWeather> items;
  final double itemWidth;
  final TextStyle? textStyle;
  final int highlightIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final temps = items.map((e) => e.temp).toList();
    final roundedTemps = temps.map((e) => e.roundToDouble()).toList();
    final minTemp = roundedTemps.reduce(min);
    final maxTemp = roundedTemps.reduce(max);
    final tempRange = max(1.0, maxTemp - minTemp);

    final topPad = 26.0;
    final bottomPad = 70.0;
    final lineHeight = max(16.0, size.height - topPad - bottomPad);

    Offset pointFor(int index, double value) {
      final x = (itemWidth * index) + (itemWidth / 2);
      final t = (value - minTemp) / tempRange;
      final y = topPad + (1 - t) * lineHeight;
      return Offset(x, y);
    }

    for (int i = 0; i < items.length - 1; i++) {
      final p1 = pointFor(i, roundedTemps[i]);
      final p2 = pointFor(i + 1, roundedTemps[i + 1]);
      final c1 = _tempColor(roundedTemps[i]);
      final c2 = _tempColor(roundedTemps[i + 1]);
      final paint = Paint()
        ..strokeWidth = 3.2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(colors: [c1, c2]).createShader(
          Rect.fromPoints(p1, p2),
        );
      canvas.drawLine(p1, p2, paint);
    }

    for (int i = 0; i < items.length; i++) {
      final p = pointFor(i, roundedTemps[i]);
      final paint = Paint()..color = _tempColor(roundedTemps[i]);
      canvas.drawCircle(p, 3.5, paint);
      _drawLabel(canvas, p, '${temps[i].toStringAsFixed(0)}°');
    }

    if (highlightIndex >= 0 && highlightIndex < items.length) {
      final p = pointFor(highlightIndex, roundedTemps[highlightIndex]);
      final arrowPaint = Paint()
        ..color = Colors.white.withAlpha(230)
        ..style = PaintingStyle.fill;
      final shadow = Paint()
        ..color = Colors.black.withAlpha(51)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      final path = Path()
        ..moveTo(p.dx, p.dy + 8)
        ..lineTo(p.dx - 6, p.dy + 20)
        ..lineTo(p.dx + 6, p.dy + 20)
        ..close();
      canvas.drawPath(path, shadow);
      canvas.drawPath(path, arrowPaint);
    }
  }

  Color _tempColor(double temp) {
    if (temp <= 8) return const Color(0xFF7DE7C6);
    if (temp <= 18) return const Color(0xFFFFE08A);
    if (temp <= 26) return const Color(0xFFFFB26A);
    return const Color(0xFFFF7A3D);
  }

  @override
  bool shouldRepaint(covariant _HourlyTempPainter oldDelegate) {
    return oldDelegate.items != items ||
        oldDelegate.highlightIndex != highlightIndex;
  }

  void _drawLabel(Canvas canvas, Offset point, String text) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    final dy = max(6.0, point.dy - painter.height - 6);
    final offset = Offset(
      point.dx - (painter.width / 2),
      dy,
    );
    painter.paint(canvas, offset);
  }
}

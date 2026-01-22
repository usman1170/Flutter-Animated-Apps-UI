import 'package:flutter/material.dart';

import '../data/models/weather_models.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';

class HourlyStrip extends StatelessWidget {
  const HourlyStrip({super.key, required this.hourly});

  final List<HourlyWeather> hourly;

  @override
  Widget build(BuildContext context) {
    final data = hourly.take(12).toList();
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = data[index];
          return SizedBox(
            width: 80,
            child: GlassCard(
              radius: 18,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatHour(item.dt),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    _iconFor(item),
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${item.temp.toStringAsFixed(0)}°',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(item.pop * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _iconFor(HourlyWeather item) {
    final main = item.weather.isNotEmpty
        ? item.weather.first.main.toLowerCase()
        : '';
    if (main.contains('rain')) return Icons.grain;
    if (main.contains('cloud')) return Icons.cloud;
    return Icons.wb_sunny;
  }
}

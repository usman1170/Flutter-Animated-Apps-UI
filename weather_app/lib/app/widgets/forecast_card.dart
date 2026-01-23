import 'package:flutter/material.dart';

import '../data/models/weather_models.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.daily,
    required this.onTap,
    this.isPrimary = false,
  });

  final DailyWeather daily;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: GlassCard(
          radius: 20,
          opacity: isPrimary ? 0.16 : 0.12,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDate(daily.dt, pattern: 'EEEE'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatDate(daily.dt, pattern: 'MMM d'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                '${daily.temp.max.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Icon(
                    _iconFor(daily),
                    color: _iconColor(daily),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(daily.pop * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(DailyWeather daily) {
    final main = daily.weather.isNotEmpty
        ? daily.weather.first.main.toLowerCase()
        : '';
    if (main.contains('rain')) return Icons.grain;
    if (main.contains('cloud')) return Icons.cloud;
    return Icons.wb_sunny;
  }

  Color _iconColor(DailyWeather daily) {
    final main = daily.weather.isNotEmpty
        ? daily.weather.first.main.toLowerCase()
        : '';
    if (main.contains('rain')) return const Color(0xFF7AC6FF);
    if (main.contains('cloud')) return const Color(0xFFB7D6F6);
    if (main.contains('storm')) return const Color(0xFFFFC857);
    if (main.contains('snow')) return const Color(0xFFD8F1FF);
    return const Color(0xFFFFD56A);
  }
}

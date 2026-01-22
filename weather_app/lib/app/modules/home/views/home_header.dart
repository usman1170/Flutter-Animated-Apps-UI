import 'package:flutter/material.dart';

import '../../../data/models/location_models.dart';
import '../../../data/models/weather_models.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/glass_card.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({
    super.key,
    required this.location,
    required this.weather,
  });

  final LocationInfo location;
  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    final iconCode =
        current.weather.isNotEmpty ? current.weather.first.icon : '01d';
    return GlassCard(
      radius: 28,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${location.city}, ${location.country}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatDate(current.dt, pattern: 'EEE, MMM d · HH:mm'),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white.withOpacity(0.12),
                  padding: const EdgeInsets.all(6),
                  child: Image.network(
                    'https://openweathermap.org/img/wn/$iconCode@2x.png',
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${current.temp.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    current.weather.isNotEmpty
                        ? current.weather.first.main
                        : 'Clear',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    'Feels like ${current.feelsLike.toStringAsFixed(0)}°',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _MetaChip(label: 'Lat ${weather.lat.toStringAsFixed(2)}'),
              _MetaChip(label: 'Lon ${weather.lon.toStringAsFixed(2)}'),
              _MetaChip(label: weather.timezone),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white70,
            ),
      ),
    );
  }
}

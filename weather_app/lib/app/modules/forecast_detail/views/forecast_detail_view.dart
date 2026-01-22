import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/formatters.dart';
import '../../../data/models/weather_models.dart';
import '../controllers/forecast_detail_controller.dart';

class ForecastDetailView extends GetView<ForecastDetailController> {
  const ForecastDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final daily = controller.daily;
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B1736), Color(0xFF132A58)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      controller.locationLabel,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  formatDate(daily.dt),
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                _DetailHeaderCard(daily: daily),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _DetailSection(
                        title: 'Temperature',
                        children: [
                          _InfoRow(
                            label: 'Min / Max',
                            value:
                                '${daily.temp.min.toStringAsFixed(0)}° / ${daily.temp.max.toStringAsFixed(0)}°',
                          ),
                          _InfoRow(
                            label: 'Morning',
                            value: '${daily.temp.morn.toStringAsFixed(0)}°',
                          ),
                          _InfoRow(
                            label: 'Evening',
                            value: '${daily.temp.eve.toStringAsFixed(0)}°',
                          ),
                          _InfoRow(
                            label: 'Feels like',
                            value: '${daily.feelsLike.day.toStringAsFixed(0)}°',
                          ),
                        ],
                      ),
                      _DetailSection(
                        title: 'Wind',
                        children: [
                          _InfoRow(
                            label: 'Speed',
                            value: '${daily.windSpeed.toStringAsFixed(1)} m/s',
                          ),
                          _InfoRow(
                            label: 'Gust',
                            value: daily.windGust == null
                                ? '—'
                                : '${daily.windGust?.toStringAsFixed(1)} m/s',
                          ),
                          _InfoRow(
                            label: 'Direction',
                            value:
                                '${daily.windDeg}° ${windDirection(daily.windDeg)}',
                          ),
                        ],
                      ),
                      _DetailSection(
                        title: 'Sun & Moon',
                        children: [
                          _InfoRow(
                            label: 'Sunrise',
                            value: formatTime(daily.sunrise),
                          ),
                          _InfoRow(
                            label: 'Sunset',
                            value: formatTime(daily.sunset),
                          ),
                          _InfoRow(
                            label: 'Moonrise',
                            value: formatTime(daily.moonrise),
                          ),
                          _InfoRow(
                            label: 'Moonset',
                            value: formatTime(daily.moonset),
                          ),
                          _InfoRow(
                            label: 'Moon phase',
                            value: moonPhaseLabel(daily.moonPhase),
                          ),
                        ],
                      ),
                      _DetailSection(
                        title: 'Atmosphere',
                        children: [
                          _InfoRow(
                            label: 'Pressure',
                            value: '${daily.pressure} hPa',
                          ),
                          _InfoRow(
                            label: 'Humidity',
                            value: '${daily.humidity}% ',
                          ),
                          _InfoRow(
                            label: 'Dew point',
                            value: '${daily.dewPoint.toStringAsFixed(1)}°',
                          ),
                          _InfoRow(
                            label: 'Clouds',
                            value: '${daily.clouds}% ',
                          ),
                          _InfoRow(
                            label: 'UV index',
                            value: daily.uvi.toStringAsFixed(1),
                          ),
                        ],
                      ),
                      _DetailSection(
                        title: 'Precipitation',
                        children: [
                          _InfoRow(
                            label: 'Probability',
                            value: '${(daily.pop * 100).toStringAsFixed(0)}%',
                          ),
                          _InfoRow(
                            label: 'Rain',
                            value: daily.rain == null
                                ? '—'
                                : '${daily.rain?.toStringAsFixed(1)} mm',
                          ),
                          _InfoRow(
                            label: 'Snow',
                            value: daily.snow == null
                                ? '—'
                                : '${daily.snow?.toStringAsFixed(1)} mm',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailHeaderCard extends StatelessWidget {
  const _DetailHeaderCard({required this.daily});

  final DailyWeather daily;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cloud,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${daily.temp.max.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                daily.weather.isNotEmpty
                    ? daily.weather.first.description
                    : 'Clear sky',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

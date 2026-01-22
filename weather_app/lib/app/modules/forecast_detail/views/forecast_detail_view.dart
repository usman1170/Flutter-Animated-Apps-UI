import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/weather_models.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/glass_card.dart';
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
                const SizedBox(height: 4),
                Text(
                  'Next 7 Days',
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: daily.isEmpty
                      ? Center(
                          child: Text(
                            'No forecast available',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        )
                      : _ForecastList(daily: daily),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForecastList extends StatefulWidget {
  const _ForecastList({required this.daily});

  final List<DailyWeather> daily;

  @override
  State<_ForecastList> createState() => _ForecastListState();
}

class _ForecastListState extends State<_ForecastList>
    with TickerProviderStateMixin {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List<bool>.filled(widget.daily.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.daily.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final daily = widget.daily[index];
        final isOpen = _expanded[index];
        return GestureDetector(
          onTap: () {
            setState(() => _expanded[index] = !isOpen);
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              radius: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SummaryRow(daily: daily),
                  if (isOpen) ...[
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Min / Max',
                      value:
                          '${daily.temp.min.toStringAsFixed(0)}° / ${daily.temp.max.toStringAsFixed(0)}°',
                    ),
                    _DetailRow(
                      label: 'Feels like',
                      value: '${daily.feelsLike.day.toStringAsFixed(0)}°',
                    ),
                    _DetailRow(
                      label: 'Humidity',
                      value: '${daily.humidity}% ',
                    ),
                    _DetailRow(
                      label: 'Pressure',
                      value: '${daily.pressure} hPa',
                    ),
                    _DetailRow(
                      label: 'Wind',
                      value:
                          '${daily.windSpeed.toStringAsFixed(1)} m/s · ${windDirection(daily.windDeg)}',
                    ),
                    _DetailRow(
                      label: 'Precipitation',
                      value:
                          '${(daily.pop * 100).toStringAsFixed(0)}% · ${daily.rain?.toStringAsFixed(1) ?? '—'} mm',
                    ),
                    _DetailRow(
                      label: 'Sunrise',
                      value: formatTime(daily.sunrise),
                    ),
                    _DetailRow(
                      label: 'Sunset',
                      value: formatTime(daily.sunset),
                    ),
                    _DetailRow(
                      label: 'Moon phase',
                      value: moonPhaseLabel(daily.moonPhase),
                    ),
                  ] else ...[
                    const SizedBox(height: 6),
                    Text(
                      'Tap for details',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white54,
                          ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.daily});

  final DailyWeather daily;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 12),
        Column(
          children: [
            Icon(
              _iconFor(daily),
              color: Colors.white,
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
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../data/models/weather_models.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/pressure_gauge.dart';
import '../../../widgets/windmill.dart';
import 'home_section_widgets.dart';

class TemperatureDetailsSection extends StatelessWidget {
  const TemperatureDetailsSection({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final today = weather.daily.isNotEmpty ? weather.daily.first : null;
    final avgTemp = today == null
        ? weather.current.temp
        : (today.temp.min + today.temp.max) / 2;

    return SectionCard(
      title: 'Temperature Details',
      child: Column(
        children: [
          InfoRow(
            label: 'Min / Max',
            value: today == null
                ? '—'
                : '${today.temp.min.toStringAsFixed(0)}° / ${today.temp.max.toStringAsFixed(0)}°',
          ),
          InfoRow(label: 'Average', value: '${avgTemp.toStringAsFixed(0)}°'),

          InfoRow(
            label: 'Apparent',
            value: '${weather.current.feelsLike.toStringAsFixed(0)}°',
          ),
        ],
      ),
    );
  }
}

class WindSection extends StatelessWidget {
  const WindSection({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Windmill(speed: current.windSpeed),
              const SizedBox(width: 10),
              Text(
                'Wind',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _CompactRow(
            label: 'Speed',
            value: '${current.windSpeed.toStringAsFixed(1)} m/s',
          ),
          _CompactRow(
            label: 'Gust',
            value: current.windGust == null
                ? '—'
                : '${current.windGust?.toStringAsFixed(1)} m/s',
          ),
          _CompactRow(
            label: 'Direction',
            value: '${current.windDeg}° ${windDirection(current.windDeg)}',
          ),
        ],
      ),
    );
  }
}

class AtmosphereSection extends StatelessWidget {
  const AtmosphereSection({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    final previousPressure = weather.hourly.length > 1
        ? weather.hourly[1].pressure
        : null;
    return SectionCard(
      title: 'Atmosphere',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final narrow = constraints.maxWidth < 260;
          final infoColumn = Column(
            children: [
              InfoRow(
                label: 'Pressure',
                value: '${current.pressure} hPa',
                trailing: pressureTrend(current.pressure, previousPressure),
              ),
              InfoRow(label: 'Humidity', value: '${current.humidity}% '),
              InfoRow(
                label: 'Visibility',
                value: '${(current.visibility / 1000).toStringAsFixed(1)} km',
              ),
            ],
          );
          if (narrow) {
            return Column(
              children: [
                infoColumn,
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: PressureGauge(
                    pressure: current.pressure,
                    size: const Size(96, 64),
                  ),
                ),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: infoColumn),
              const SizedBox(width: 12),
              PressureGauge(
                pressure: current.pressure,
                size: const Size(96, 64),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PrecipitationSection extends StatelessWidget {
  const PrecipitationSection({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    final current = weather.current;
    final today = weather.daily.isNotEmpty ? weather.daily.first : null;
    final intensity = (current.rain1h ?? 0) + (current.snow1h ?? 0);
    return SectionCard(
      title: 'Precipitation',
      child: Column(
        children: [
          InfoRow(
            label: 'Intensity',
            value: intensity == 0
                ? '—'
                : '${intensity.toStringAsFixed(1)} mm/h',
          ),
          InfoRow(
            label: 'Accumulated',
            value: today?.rain == null
                ? '—'
                : '${today?.rain?.toStringAsFixed(1)} mm',
          ),

          InfoRow(
            label: 'Probability',
            value: today == null
                ? '—'
                : '${(today.pop * 100).toStringAsFixed(0)}%',
          ),
        ],
      ),
    );
  }
}

class CloudsCard extends StatelessWidget {
  const CloudsCard({super.key, required this.weather});

  final WeatherResponse weather;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _PillIcon(icon: Icons.cloud, color: Color(0xFFB7E3FF)),
              const SizedBox(width: 8),
              Text(
                'Clouds',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InfoRow(label: 'Coverage', value: '${weather.current.clouds}% '),
        ],
      ),
    );
  }
}

class UvCard extends StatelessWidget {
  const UvCard({super.key, required this.uvi});

  final double uvi;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _PillIcon(
                icon: Icons.wb_sunny_rounded,
                color: Color(0xFFFFD56A),
              ),
              const SizedBox(width: 8),
              Text(
                'UV Index',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InfoRow(label: 'Value', value: uvi.toStringAsFixed(1)),
        ],
      ),
    );
  }
}

class _PillIcon extends StatefulWidget {
  const _PillIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  State<_PillIcon> createState() => _PillIconState();
}

class _PillIconState extends State<_PillIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
        final scale = 0.95 + (_controller.value * 0.08);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.color.withOpacity(0.5)),
            ),
            child: Icon(widget.icon, color: widget.color),
          ),
        );
      },
    );
  }
}

class _CompactRow extends StatelessWidget {
  const _CompactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

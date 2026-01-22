import 'package:flutter/material.dart';

import '../../../data/models/weather_models.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/info_card.dart';
import 'home_section_widgets.dart';

class AirQualitySection extends StatelessWidget {
  const AirQualitySection({super.key, required this.airQuality});

  final AirQuality? airQuality;

  @override
  Widget build(BuildContext context) {
    if (airQuality == null) {
      return const SizedBox.shrink();
    }
    final aqi = airQuality!.aqi;
    final label = _aqiLabel(aqi);
    return SectionCard(
      title: 'Air Quality',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AQI $aqi · $label',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            _aqiAdvice(aqi),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              InfoCard(
                title: 'PM2.5',
                value: '${airQuality!.components.pm25.toStringAsFixed(1)}',
                icon: Icons.blur_on,
              ),
              InfoCard(
                title: 'PM10',
                value: '${airQuality!.components.pm10.toStringAsFixed(1)}',
                icon: Icons.grain,
              ),
              InfoCard(
                title: 'CO',
                value: '${airQuality!.components.co.toStringAsFixed(1)}',
                icon: Icons.air,
              ),
              InfoCard(
                title: 'O3',
                value: '${airQuality!.components.o3.toStringAsFixed(1)}',
                icon: Icons.bubble_chart,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _aqiLabel(int value) {
    switch (value) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }

  String _aqiAdvice(int value) {
    switch (value) {
      case 1:
        return 'Air quality is ideal for outdoor activity.';
      case 2:
        return 'Sensitive groups should take it easy.';
      case 3:
        return 'Reduce prolonged or heavy exertion.';
      case 4:
        return 'Limit outdoor activity if you feel symptoms.';
      case 5:
        return 'Stay indoors and keep windows closed.';
      default:
        return 'No advice available.';
    }
  }
}

class AlertsSection extends StatelessWidget {
  const AlertsSection({super.key, required this.alerts});

  final List<WeatherAlert> alerts;

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return const SizedBox.shrink();
    }
    return SectionCard(
      title: 'Alerts',
      child: Column(
        children: alerts
            .map((alert) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.event,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${formatTime(alert.start)} - ${formatTime(alert.end)}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        alert.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

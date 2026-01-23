import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/forecast_card.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/hourly_strip.dart';
import '../../../widgets/sun_path.dart';
import '../../../widgets/weather_background.dart';
import '../../../widgets/weather_loading.dart';
import '../controllers/home_controller.dart';
import 'home_alerts_sections.dart';
import 'home_detail_sections.dart';
import 'home_header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const WeatherLoading();
        }
        if (controller.error.value.isNotEmpty) {
          return _ErrorState(
            message: controller.error.value,
            onRetry: controller.loadWeather,
          );
        }
        final data = controller.weather.value;
        final location = controller.location.value;
        if (data == null || location == null) {
          return _ErrorState(
            message: 'Weather data unavailable',
            onRetry: controller.loadWeather,
          );
        }

        final sunProgress = _sunProgress(
          data.current.dt,
          data.current.sunrise,
          data.current.sunset,
        );

        return Stack(
          children: [
            WeatherBackground(kind: controller.kind.value),
            SafeArea(
              child: RefreshIndicator(
                onRefresh: controller.refreshWeather,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    WeatherHeader(
                      location: location,
                      weather: data,
                      isSaved: controller.isCurrentSaved(),
                      isRefreshing: controller.isRefreshing.value,
                      onSave: controller.saveCurrentCity,
                      onChangeLocation: controller.changeLocation,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(title: 'Hourly Forecast'),
                        const SizedBox(height: 12),
                        HourlyStrip(hourly: data.hourly),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionTitle(title: 'Next 7 Days'),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(
                                  Routes.FORECAST_DETAIL,
                                  arguments: {
                                    'daily': data.daily.take(7).toList(),
                                    'location':
                                        '${location.city}, ${location.country}',
                                    'kind': controller.kind.value,
                                  },
                                );
                              },
                              child: const Text(
                                'See Full Forecast',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...data.daily.take(3).toList().asMap().entries.map((
                          entry,
                        ) {
                          final index = entry.key;
                          final daily = entry.value;
                          return ForecastCard(
                            daily: daily,
                            isPrimary: index == 0,
                            onTap: () {
                              Get.toNamed(
                                Routes.FORECAST_DETAIL,
                                arguments: {
                                  'daily': data.daily.take(7).toList(),
                                  'location':
                                      '${location.city}, ${location.country}',
                                  'kind': controller.kind.value,
                                },
                              );
                            },
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _GlassRow(
                      left: TemperatureDetailsSection(weather: data),
                      right: PrecipitationSection(weather: data),
                      baseHeight: 160,
                    ),
                    const SizedBox(height: 16),
                    _GlassRow(
                      left: WindSection(weather: data),
                      right: AtmosphereSection(weather: data),
                      baseHeight: 250,
                    ),
                    const SizedBox(height: 16),
                    _GlassRow(
                      left: CloudsCard(weather: data),
                      right: UvCard(uvi: data.current.uvi),
                      baseHeight: 100,
                    ),
                    const SizedBox(height: 16),
                    AirQualitySection(airQuality: controller.airQuality.value),
                    const SizedBox(height: 16),
                    AlertsSection(alerts: data.alerts),
                    const SizedBox(height: 16),
                    GlassCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle(title: 'Sun Path'),
                          const SizedBox(height: 8),
                          SunPath(progress: sunProgress),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(data.current.sunrise),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(color: Colors.white70),
                              ),
                              Text(
                                formatTime(data.current.sunset),
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  double _sunProgress(int now, int sunrise, int sunset) {
    if (sunset <= sunrise) return 0.5;
    final raw = (now - sunrise) / (sunset - sunrise);
    return raw.clamp(0.0, 1.0);
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(color: Colors.white),
    );
  }
}

class _GlassRow extends StatelessWidget {
  const _GlassRow({
    required this.left,
    required this.right,
    required this.baseHeight,
  });

  final Widget left;
  final Widget right;
  final double baseHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = constraints.maxWidth < 380 ? 10.0 : 14.0;
        final height = constraints.maxWidth < 360
            ? baseHeight + 30
            : baseHeight;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(height: height, child: left),
            ),
            SizedBox(width: gap),
            Expanded(
              child: SizedBox(height: height, child: right),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B1736), Color(0xFF132A58)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

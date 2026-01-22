import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/location_service.dart';
import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A1432), Color(0xFF152C5B)],
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Pick Location',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Find the area or city to see detailed forecasts.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.white70),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Search city',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      Icon(Icons.my_location, color: Colors.white70),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            _GhostLocationCard(
                              title: 'Montreal',
                              temp: '8°',
                              icon: Icons.ac_unit,
                            ),
                            SizedBox(width: 14),
                            _GhostLocationCard(
                              title: 'Tokyo',
                              temp: '12°',
                              icon: Icons.cloud,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: Row(
                          children: const [
                            _GhostLocationCard(
                              title: 'Taipei',
                              temp: '20°',
                              icon: Icons.wb_cloudy,
                            ),
                            SizedBox(width: 14),
                            _GhostLocationCard(
                              title: 'Toronto',
                              temp: '12°',
                              icon: Icons.thunderstorm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: AnimatedBuilder(
                    animation: controller.pulseController,
                    builder: (context, child) {
                      final pulse =
                          0.9 + (controller.pulseController.value * 0.2);
                      return Transform.scale(
                        scale: pulse,
                        child: child,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5FB8FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Obx(() {
                        final status = controller.status.value;
                        final isChecking = controller.isChecking.value;
                        final label = isChecking
                            ? 'Checking...'
                            : status == LocationStatus.deniedForever
                                ? 'Open Settings'
                                : 'Allow Location';
                        return GestureDetector(
                          onTap: isChecking
                              ? null
                              : () {
                                  controller.requestPermission();
                                },
                          child: Text(
                            label,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostLocationCard extends StatelessWidget {
  const _GhostLocationCard({
    required this.title,
    required this.temp,
    required this.icon,
  });

  final String title;
  final String temp;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              temp,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Icon(icon, color: Colors.white70),
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

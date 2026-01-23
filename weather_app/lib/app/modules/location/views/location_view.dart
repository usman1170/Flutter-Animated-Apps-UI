import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/city_models.dart';
import '../../../data/services/location_service.dart';
import '../../../widgets/glass_card.dart';
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
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Pick Location',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Search for a city and tap to use it. Saved locations appear below.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                GlassCard(
                  radius: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: controller.searchController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white70,
                    onChanged: controller.searchCity,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search city',
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  if (controller.isSearching.value) {
                    return const LinearProgressIndicator();
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: 12),
                Expanded(
                  child: Obx(() {
                    return ListView(
                      children: [
                        if (controller.results.isNotEmpty) ...[
                          _SectionLabel(title: 'Results'),
                          const SizedBox(height: 8),
                          ...controller.results.map(
                            (city) => _CityTile(
                              city: city,
                              onTap: () => controller.selectCity(city),
                              trailing: const Icon(
                                Icons.north_east,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        _SectionLabel(title: 'Saved Locations'),
                        const SizedBox(height: 8),
                        if (controller.saved.isEmpty)
                          Text(
                            'No saved cities yet.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white60),
                          )
                        else
                          ...controller.saved.map(
                            (city) => _CityTile(
                              city: city,
                              onTap: () => controller.selectCity(city),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white70,
                                ),
                                onPressed: () => controller.removeCity(city),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Center(
                          child: AnimatedBuilder(
                            animation: controller.pulseController,
                            builder: (context, child) {
                              final pulse =
                                  0.9 +
                                  (controller.pulseController.value * 0.2);
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
                                    : 'Use Device Location';
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
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(color: Colors.white),
    );
  }
}

class _CityTile extends StatelessWidget {
  const _CityTile({
    required this.city,
    required this.onTap,
    required this.trailing,
  });

  final CityLocation city;
  final VoidCallback onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          radius: 16,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF9AD9FF)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  city.displayName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/dashboard_controller.dart';
import '../../../../modules/player/controllers/player_controller.dart';

import 'category_chip.dart';
import 'featured_card.dart';
import 'glass_icon_button.dart';
import 'popular_list_item.dart';
import 'section_header.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  static const _chips = ['All', 'New Artists', 'Hot Tracks', "Editor's Picks"];

  static const List<Map<String, Object>> _popular = [
    {
      'title': 'Blinding Light',
      'subtitle': 'Top Hit',
      'image':
          'https://images.unsplash.com/photo-1511379938547-c1f69419868d?auto=format&fit=crop&w=600&q=80',
      'duration': 179,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    },
    {
      'title': 'Ocean Eyes',
      'subtitle': 'Soft Vibe',
      'image':
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80',
      'duration': 160,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    },
    {
      'title': 'Circles Run',
      'subtitle': 'Fan Fav',
      'image':
          'https://images.unsplash.com/photo-1485579149621-3123dd979885?auto=format&fit=crop&w=600&q=80',
      'duration': 205,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    },
    {
      'title': 'Night Drive',
      'subtitle': 'Chill Mix',
      'image':
          'https://images.unsplash.com/photo-1487180144351-b8472da7d491?auto=format&fit=crop&w=600&q=80',
      'duration': 194,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    },
    {
      'title': 'Neon Dreams',
      'subtitle': 'Synthwave',
      'image':
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=600&q=80',
      'duration': 188,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    },
    {
      'title': 'Moonlight',
      'subtitle': 'Late Night',
      'image':
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?auto=format&fit=crop&w=600&q=80',
      'duration': 214,
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Hello, Alex',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: const [
                  GlassIconButton(icon: Icons.search_rounded),
                  SizedBox(width: 10),
                  GlassIconButton(icon: Icons.notifications_none_rounded),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Obx(() {
            final controller = Get.find<DashboardController>();
            final selected = controller.homeChipIndex.value;
            return SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: _chips[index],
                    isActive: selected == index,
                    onTap: () => controller.setHomeChip(index),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: _chips.length,
              ),
            );
          }),
          const SizedBox(height: 18),
          const SectionHeader(title: 'For you'),
          const SizedBox(height: 12),
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                FeaturedCard(
                  title: 'Feel the Beat',
                  subtitle:
                      'Explore trending tracks and\nhidden gems curated just\nfor you.',
                  buttonText: 'Start Listening',
                  imageUrl:
                      'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=700&q=80',
                ),
                SizedBox(width: 14),
                _MiniCard(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Popular', actionLabel: 'Show all'),
          const SizedBox(height: 12),
          ..._popular
              .asMap()
              .entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PopularListItem(
                    title: entry.value['title'] as String,
                    subtitle: entry.value['subtitle'] as String,
                    imageUrl: entry.value['image'] as String,
                    onPlay: () => _openPlayer(entry.key),
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _openPlayer(int index) {
    final tracks = _popular
        .map(
          (item) => PlayerTrack(
            title: item['title'] as String,
            artist: item['subtitle'] as String,
            imageUrl: item['image'] as String,
            audioUrl: item['audio'] as String,
            durationSeconds: item['duration'] as int,
          ),
        )
        .toList();
    Get.toNamed(Routes.player, arguments: {'tracks': tracks, 'index': index});
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2E3D8C), Color(0xFF1E2348)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Switch\n& chill',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80',
                height: 58,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

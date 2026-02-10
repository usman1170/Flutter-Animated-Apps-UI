import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/dashboard_controller.dart';
import '../../../../modules/player/controllers/player_controller.dart';

import 'category_chip.dart';
import 'glass_icon_button.dart';
import 'popular_list_item.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  static const _chips = ['All', 'Liked Songs', 'Playlists', 'Downloads'];

  static const List<Map<String, Object>> _tracks = [
    {
      'title': 'Save Your Tears',
      'subtitle': 'The Weeknd',
      'duration': '3:35',
      'seconds': 215,
      'image':
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
    },
    {
      'title': 'Happier Than Ever',
      'subtitle': 'Billie Eilish',
      'duration': '4:57',
      'seconds': 297,
      'image':
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
    },
    {
      'title': 'Sunflower',
      'subtitle': 'Post Malone',
      'duration': '2:40',
      'seconds': 160,
      'image':
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
    },
    {
      'title': 'Believer',
      'subtitle': 'Imagine Dragons',
      'duration': '3:25',
      'seconds': 205,
      'image':
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    },
    {
      'title': 'Positions',
      'subtitle': 'Ariana Grande',
      'duration': '3:02',
      'seconds': 182,
      'image':
          'https://images.unsplash.com/photo-1485579149621-3123dd979885?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
    },
    {
      'title': 'Shivers',
      'subtitle': 'Ed Sheeran',
      'duration': '3:28',
      'seconds': 208,
      'image':
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
    },
    {
      'title': 'Ghost',
      'subtitle': 'Justin Bieber',
      'duration': '3:12',
      'seconds': 192,
      'image':
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
    },
    {
      'title': 'Afterglow',
      'subtitle': 'Ed Sheeran',
      'duration': '3:05',
      'seconds': 185,
      'image':
          'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
    },
    {
      'title': 'Levitating',
      'subtitle': 'Dua Lipa',
      'duration': '3:23',
      'seconds': 203,
      'image':
          'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3',
    },
    {
      'title': 'Peaches',
      'subtitle': 'Justin Bieber',
      'duration': '3:18',
      'seconds': 198,
      'image':
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=80',
      'audio':
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
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
                  'Your library',
                  style: textTheme.headlineLarge?.copyWith(
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
            final selected = controller.libraryChipIndex.value;
            return SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: _chips[index],
                    isActive: selected == index,
                    onTap: () => controller.setLibraryChip(index),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: _chips.length,
              ),
            );
          }),
          const SizedBox(height: 20),
          ..._tracks.asMap().entries.map((entry) {
            final track = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _LibraryListItem(
                title: track['title'] as String,
                subtitle: track['subtitle'] as String,
                duration: track['duration'] as String,
                imageUrl: track['image'] as String,
                onPlay: () => _openPlayer(entry.key),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _openPlayer(int index) {
    final tracks = _tracks
        .map(
          (item) => PlayerTrack(
            title: item['title'] as String,
            artist: item['subtitle'] as String,
            imageUrl: item['image'] as String,
            audioUrl: item['audio'] as String,
            durationSeconds: item['seconds'] as int,
          ),
        )
        .toList();
    Get.toNamed(Routes.player, arguments: {'tracks': tracks, 'index': index});
  }
}

class _LibraryListItem extends StatelessWidget {
  const _LibraryListItem({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imageUrl,
    this.onPlay,
  });

  final String title;
  final String subtitle;
  final String duration;
  final String imageUrl;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            imageUrl,
            height: 58,
            width: 58,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Text(
          duration,
          style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(width: 12),
        GlassPlayButton(onTap: onPlay),
      ],
    );
  }
}

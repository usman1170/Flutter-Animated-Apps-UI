import 'package:get/get.dart';

class PlayerTrack {
  const PlayerTrack({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.durationSeconds,
  });

  final String title;
  final String artist;
  final String imageUrl;
  final int durationSeconds;

  String get durationLabel {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }
}

class PlayerController extends GetxController {
  final tracks = <PlayerTrack>[].obs;
  final currentIndex = 0.obs;
  final isPlaying = true.obs;
  final isShuffle = false.obs;
  final isRepeat = false.obs;
  final isFavorite = false.obs;
  final progress = 0.45.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['tracks'] is List<PlayerTrack>) {
      tracks.assignAll(args['tracks'] as List<PlayerTrack>);
    }
    if (args is Map && args['index'] is int) {
      currentIndex.value = args['index'] as int;
    }
  }

  PlayerTrack get currentTrack => tracks[currentIndex.value];

  void togglePlay() => isPlaying.toggle();
  void toggleShuffle() => isShuffle.toggle();
  void toggleRepeat() => isRepeat.toggle();
  void toggleFavorite() => isFavorite.toggle();

  void seek(double value) {
    progress.value = value.clamp(0, 1);
  }

  void next() {
    if (tracks.isEmpty) return;
    if (currentIndex.value < tracks.length - 1) {
      currentIndex.value++;
    } else if (isRepeat.value) {
      currentIndex.value = 0;
    }
  }

  void previous() {
    if (tracks.isEmpty) return;
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else if (isRepeat.value) {
      currentIndex.value = tracks.length - 1;
    }
  }

  void jumpTo(int index) {
    if (index < 0 || index >= tracks.length) return;
    currentIndex.value = index;
  }
}

import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path_provider/path_provider.dart';

class PlayerTrack {
  const PlayerTrack({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.audioUrl,
    required this.durationSeconds,
  });

  final String title;
  final String artist;
  final String imageUrl;
  final String audioUrl;
  final int durationSeconds;

  String get durationLabel {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class PlayerController extends GetxController {
  final _player = AudioPlayer();
  late final PageController pageController;
  final tracks = <PlayerTrack>[].obs;
  final currentIndex = 0.obs;
  final isPlaying = true.obs;
  final isShuffle = false.obs;
  final isRepeat = false.obs;
  final isFavorite = false.obs;
  final progress = 0.45.obs;
  final beatLevel = 0.0.obs;
  final Map<String, List<Duration>> _beatCache = {};
  List<Duration> _beatTimes = const [];
  int _beatIndex = 0;

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
    pageController = PageController(
      viewportFraction: 0.74,
      initialPage: currentIndex.value,
    );
    if (tracks.isNotEmpty) {
      _loadAndPlay(currentIndex.value);
      _prepareBeats(tracks[currentIndex.value]);
    }
    _player.positionStream.listen(_handlePosition);
    _player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (!state.playing) {
        beatLevel.value = 0;
      }
    });
  }

  PlayerTrack get currentTrack => tracks[currentIndex.value];

  void togglePlay() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void toggleShuffle() => isShuffle.toggle();
  void toggleRepeat() => isRepeat.toggle();
  void toggleFavorite() => isFavorite.toggle();

  void seek(double value) {
    final clamped = value.clamp(0.0, 1.0).toDouble();
    progress.value = clamped;
    final seconds = (currentTrack.durationSeconds * clamped).round();
    _player.seek(Duration(seconds: seconds));
    _syncBeatIndex(Duration(seconds: seconds));
  }

  void next() {
    if (tracks.isEmpty) return;
    if (currentIndex.value < tracks.length - 1) {
      currentIndex.value++;
    } else if (isRepeat.value) {
      currentIndex.value = 0;
    }
    _loadAndPlay(currentIndex.value);
    _prepareBeats(currentTrack);
    _animateToCurrent();
  }

  void previous() {
    if (tracks.isEmpty) return;
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else if (isRepeat.value) {
      currentIndex.value = tracks.length - 1;
    }
    _loadAndPlay(currentIndex.value);
    _prepareBeats(currentTrack);
    _animateToCurrent();
  }

  void jumpTo(int index) {
    if (index < 0 || index >= tracks.length) return;
    currentIndex.value = index;
    _loadAndPlay(index);
    _prepareBeats(currentTrack);
    _animateToCurrent();
  }

  Future<void> _loadAndPlay(int index) async {
    final track = tracks[index];
    try {
      await _player.setUrl(track.audioUrl);
      await _player.seek(Duration.zero);
      if (isPlaying.value) {
        await _player.play();
      }
    } catch (_) {}
  }

  void _handlePosition(Duration position) {
    if (tracks.isEmpty) return;
    final total = currentTrack.durationSeconds;
    if (total <= 0) return;
    final value = position.inSeconds / total;
    progress.value = value.clamp(0.0, 1.0).toDouble();
    _updateBeatLevel(position);
  }

  void _animateToCurrent() {
    if (!pageController.hasClients) return;
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  Future<void> _prepareBeats(PlayerTrack track) async {
    if (_beatCache.containsKey(track.audioUrl)) {
      _beatTimes = _beatCache[track.audioUrl]!;
      _beatIndex = 0;
      return;
    }
    try {
      final beats = await _extractBeats(track.audioUrl);
      _beatCache[track.audioUrl] = beats;
      _beatTimes = beats;
      _beatIndex = 0;
    } catch (_) {
      _beatTimes = const [];
      _beatIndex = 0;
    }
  }

  Future<List<Duration>> _extractBeats(String url) async {
    final dir = await getTemporaryDirectory();
    final fileName = url.hashCode.toString();
    final audioFile = File('${dir.path}/$fileName.mp3');
    final waveFile = File('${dir.path}/$fileName.waveform');

    if (!await audioFile.exists()) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return const [];
      }
      await audioFile.writeAsBytes(response.bodyBytes);
    }

    Waveform? waveform;
    await for (final progress in JustWaveform.extract(
      audioInFile: audioFile,
      waveOutFile: waveFile,
    )) {
      if (progress.waveform != null) {
        waveform = progress.waveform;
      }
    }
    if (waveform == null) return const [];

    if (waveform.length <= 0) return const [];
    final durationMs = waveform.duration.inMilliseconds;
    if (durationMs <= 0) return const [];

    double sum = 0;
    final pixels = waveform.length;
    for (var i = 0; i < pixels; i++) {
      final minVal = waveform.getPixelMin(i).abs();
      final maxVal = waveform.getPixelMax(i).abs();
      sum += math.max(minVal, maxVal).toDouble();
    }
    final avg = sum / pixels;
    final threshold = avg * 1.35;
    final pixelDurationMs = durationMs / pixels;
    final minGapMs = 250.0;
    final minGapPixels = math.max(1, (minGapMs / pixelDurationMs).round());

    final beats = <Duration>[];
    var lastBeat = -minGapPixels;
    for (var i = 0; i < pixels; i++) {
      final amplitude = math.max(
        waveform.getPixelMin(i).abs(),
        waveform.getPixelMax(i).abs(),
      );
      if (amplitude > threshold && (i - lastBeat) >= minGapPixels) {
        final timeMs = (i * pixelDurationMs).round();
        beats.add(Duration(milliseconds: timeMs));
        lastBeat = i;
      }
    }
    return beats;
  }

  void _syncBeatIndex(Duration position) {
    if (_beatTimes.isEmpty) return;
    var i = 0;
    while (i < _beatTimes.length && _beatTimes[i] <= position) {
      i++;
    }
    _beatIndex = math.max(0, i - 1);
  }

  void _updateBeatLevel(Duration position) {
    if (!isPlaying.value || _beatTimes.isEmpty) {
      beatLevel.value = 0;
      return;
    }
    while (_beatIndex < _beatTimes.length - 1 &&
        _beatTimes[_beatIndex + 1] <= position) {
      _beatIndex++;
    }
    final beatTime = _beatTimes[_beatIndex];
    final deltaMs = (position - beatTime).inMilliseconds.abs();
    const windowMs = 120;
    if (deltaMs <= windowMs) {
      beatLevel.value = 1 - (deltaMs / windowMs);
    } else {
      beatLevel.value = 0;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    _player.dispose();
    super.onClose();
  }
}

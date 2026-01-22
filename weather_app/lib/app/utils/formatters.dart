import 'package:intl/intl.dart';

String formatTime(int timestamp, {String pattern = 'HH:mm'}) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true)
      .toLocal();
  return DateFormat(pattern).format(date);
}

String formatDate(int timestamp, {String pattern = 'EEE, MMM d'}) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true)
      .toLocal();
  return DateFormat(pattern).format(date);
}

String formatHour(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true)
      .toLocal();
  return DateFormat('HH:00').format(date);
}

String windDirection(int degrees) {
  const directions = [
    'N',
    'NNE',
    'NE',
    'ENE',
    'E',
    'ESE',
    'SE',
    'SSE',
    'S',
    'SSW',
    'SW',
    'WSW',
    'W',
    'WNW',
    'NW',
    'NNW'
  ];
  final index = ((degrees % 360) / 22.5).round() % 16;
  return directions[index];
}

String moonPhaseLabel(double phase) {
  if (phase == 0 || phase == 1) return 'New Moon';
  if (phase < 0.25) return 'Waxing Crescent';
  if (phase == 0.25) return 'First Quarter';
  if (phase < 0.5) return 'Waxing Gibbous';
  if (phase == 0.5) return 'Full Moon';
  if (phase < 0.75) return 'Waning Gibbous';
  if (phase == 0.75) return 'Last Quarter';
  return 'Waning Crescent';
}

double moonIllumination(double phase) {
  return 1 - (2 * phase - 1).abs();
}

String pressureTrend(int current, int? previous) {
  if (previous == null) return 'Steady';
  if (current > previous) return 'Rising';
  if (current < previous) return 'Falling';
  return 'Steady';
}

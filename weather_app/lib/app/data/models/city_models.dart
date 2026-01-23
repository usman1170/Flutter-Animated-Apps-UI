class CityLocation {
  CityLocation({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.state,
  });

  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? state;

  String get displayName {
    if (state == null || state!.isEmpty) {
      return '$name, $country';
    }
    return '$name, $state, $country';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
      'state': state,
    };
  }

  factory CityLocation.fromJson(Map<String, dynamic> json) {
    return CityLocation(
      name: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0,
      state: json['state'] as String?,
    );
  }
}

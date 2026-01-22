class LocationInfo {
  LocationInfo({
    required this.city,
    required this.country,
  });

  final String city;
  final String country;

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      city: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
}

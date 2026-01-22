class WeatherResponse {
  WeatherResponse({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final List<WeatherAlert> alerts;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] as String? ?? '',
      timezoneOffset: json['timezone_offset'] as int? ?? 0,
      current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
      hourly: (json['hourly'] as List<dynamic>? ?? [])
          .map((e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
      daily: (json['daily'] as List<dynamic>? ?? [])
          .map((e) => DailyWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
      alerts: (json['alerts'] as List<dynamic>? ?? [])
          .map((e) => WeatherAlert.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CurrentWeather {
  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.rain1h,
    required this.snow1h,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherInfo> weather;
  final double? rain1h;
  final double? snow1h;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'] as int? ?? 0,
      sunrise: json['sunrise'] as int? ?? 0,
      sunset: json['sunset'] as int? ?? 0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0,
      feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0,
      pressure: json['pressure'] as int? ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0,
      clouds: json['clouds'] as int? ?? 0,
      visibility: json['visibility'] as int? ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0,
      windDeg: json['wind_deg'] as int? ?? 0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>? ?? [])
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      rain1h: (json['rain']?['1h'] as num?)?.toDouble(),
      snow1h: (json['snow']?['1h'] as num?)?.toDouble(),
    );
  }
}

class HourlyWeather {
  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
    required this.rain1h,
    required this.snow1h,
  });

  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherInfo> weather;
  final double pop;
  final double? rain1h;
  final double? snow1h;

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dt: json['dt'] as int? ?? 0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0,
      feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0,
      pressure: json['pressure'] as int? ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0,
      clouds: json['clouds'] as int? ?? 0,
      visibility: json['visibility'] as int? ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0,
      windDeg: json['wind_deg'] as int? ?? 0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>? ?? [])
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      pop: (json['pop'] as num?)?.toDouble() ?? 0,
      rain1h: (json['rain']?['1h'] as num?)?.toDouble(),
      snow1h: (json['snow']?['1h'] as num?)?.toDouble(),
    );
  }
}

class DailyWeather {
  DailyWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi,
    required this.rain,
    required this.snow,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final TempRange temp;
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherInfo> weather;
  final int clouds;
  final double pop;
  final double uvi;
  final double? rain;
  final double? snow;

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'] as int? ?? 0,
      sunrise: json['sunrise'] as int? ?? 0,
      sunset: json['sunset'] as int? ?? 0,
      moonrise: json['moonrise'] as int? ?? 0,
      moonset: json['moonset'] as int? ?? 0,
      moonPhase: (json['moon_phase'] as num?)?.toDouble() ?? 0,
      temp: TempRange.fromJson(json['temp'] as Map<String, dynamic>? ?? {}),
      feelsLike:
          FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>? ?? {}),
      pressure: json['pressure'] as int? ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      dewPoint: (json['dew_point'] as num?)?.toDouble() ?? 0,
      windSpeed: (json['wind_speed'] as num?)?.toDouble() ?? 0,
      windDeg: json['wind_deg'] as int? ?? 0,
      windGust: (json['wind_gust'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>? ?? [])
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      clouds: json['clouds'] as int? ?? 0,
      pop: (json['pop'] as num?)?.toDouble() ?? 0,
      uvi: (json['uvi'] as num?)?.toDouble() ?? 0,
      rain: (json['rain'] as num?)?.toDouble(),
      snow: (json['snow'] as num?)?.toDouble(),
    );
  }
}

class TempRange {
  TempRange({
    required this.min,
    required this.max,
    required this.day,
    required this.night,
    required this.morn,
    required this.eve,
  });

  final double min;
  final double max;
  final double day;
  final double night;
  final double morn;
  final double eve;

  factory TempRange.fromJson(Map<String, dynamic> json) {
    return TempRange(
      min: (json['min'] as num?)?.toDouble() ?? 0,
      max: (json['max'] as num?)?.toDouble() ?? 0,
      day: (json['day'] as num?)?.toDouble() ?? 0,
      night: (json['night'] as num?)?.toDouble() ?? 0,
      morn: (json['morn'] as num?)?.toDouble() ?? 0,
      eve: (json['eve'] as num?)?.toDouble() ?? 0,
    );
  }
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double day;
  final double night;
  final double eve;
  final double morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: (json['day'] as num?)?.toDouble() ?? 0,
      night: (json['night'] as num?)?.toDouble() ?? 0,
      eve: (json['eve'] as num?)?.toDouble() ?? 0,
      morn: (json['morn'] as num?)?.toDouble() ?? 0,
    );
  }
}

class WeatherInfo {
  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      id: json['id'] as int? ?? 0,
      main: json['main'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }
}

class WeatherAlert {
  WeatherAlert({
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.senderName,
  });

  final String event;
  final int start;
  final int end;
  final String description;
  final String senderName;

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      event: json['event'] as String? ?? '',
      start: json['start'] as int? ?? 0,
      end: json['end'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      senderName: json['sender_name'] as String? ?? '',
    );
  }
}

class AirQuality {
  AirQuality({
    required this.aqi,
    required this.components,
  });

  final int aqi;
  final AirQualityComponents components;

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      aqi: json['main']?['aqi'] as int? ?? 0,
      components: AirQualityComponents.fromJson(
        json['components'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class AirQualityComponents {
  AirQualityComponents({
    required this.pm25,
    required this.pm10,
    required this.co,
    required this.no2,
    required this.so2,
    required this.o3,
  });

  final double pm25;
  final double pm10;
  final double co;
  final double no2;
  final double so2;
  final double o3;

  factory AirQualityComponents.fromJson(Map<String, dynamic> json) {
    return AirQualityComponents(
      pm25: (json['pm2_5'] as num?)?.toDouble() ?? 0,
      pm10: (json['pm10'] as num?)?.toDouble() ?? 0,
      co: (json['co'] as num?)?.toDouble() ?? 0,
      no2: (json['no2'] as num?)?.toDouble() ?? 0,
      so2: (json['so2'] as num?)?.toDouble() ?? 0,
      o3: (json['o3'] as num?)?.toDouble() ?? 0,
    );
  }
}

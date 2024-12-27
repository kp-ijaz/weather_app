class Weather {
  final String cityName;
  final String weatherCondition;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final DateTime timestamp;

  Weather({
    required this.cityName,
    required this.weatherCondition,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      weatherCondition: json['weather'][0]['description'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': cityName,
        'weather': [
          {'description': weatherCondition}
        ],
        'main': {
          'temp': temperature,
          'feels_like': feelsLike,
          'humidity': humidity,
        },
        'wind': {'speed': windSpeed},
        'dt': timestamp.millisecondsSinceEpoch ~/ 1000,
      };
}

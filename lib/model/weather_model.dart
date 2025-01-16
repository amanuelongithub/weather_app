import 'dart:convert';

class WeatherModel {
  final String? name;
  final double? temp;
  final double? maxTemp;
  final double? minTemp;
  final double? feelsTemp;
  final String? condition;

  WeatherModel({
    this.name,
    this.temp,
    this.maxTemp,
    this.minTemp,
    this.feelsTemp,
    this.condition,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      name: map['name'] as String?,
      temp: (map['main']?['temp'])?.toDouble(),
      maxTemp: (map['main']?['temp_max'])?.toDouble(),
      minTemp: (map['main']?['temp_min'])?.toDouble(),
      feelsTemp: (map['main']?['feels_like'])?.toDouble(),
      condition: map['weather']?[0]['main'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'main': {
        'temp': temp,
        'temp_max': maxTemp,
        'temp_min': minTemp,
        'feels_like': feelsTemp,
      },
      'weather': [
        {'main': condition},
      ],
    };
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

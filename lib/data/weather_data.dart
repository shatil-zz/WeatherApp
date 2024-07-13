
import 'package:weather_app/utils/temparature.dart';

class WeatherData {
  WeatherData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.date,
    required this.icon,
    required this.cityName
  });

  factory WeatherData.fromJson(dynamic weather) {
    return WeatherData(
      temp: Temperature.celsius(weather["main"]["temp"]),
      minTemp: Temperature.celsius(weather["main"]["temp_min"]),
      maxTemp: Temperature.celsius(weather["main"]["temp_max"]),
      description: weather["weather"][0]["main"],
      date: DateTime.fromMillisecondsSinceEpoch(weather["dt"] * 1000),
      icon: weather["weather"][0]["icon"],
      cityName: weather['name']
    );
  }

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final String description;
  final DateTime date;
  final String icon;
  final String cityName;

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
}
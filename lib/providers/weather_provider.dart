import 'package:flutter/material.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  String cityName = "";
  Resources<WeatherData> resources = Resources();
  WeatherRepository weatherRepository;
  WeatherProvider(this.weatherRepository);

  searchTemperatureByCityName(String cityName) async {
    this.cityName = cityName;
    resources.status = ResourceStatus.LOADING;
    notifyListeners();
    resources = await weatherRepository.getWeatherData(cityName);
    notifyListeners();
  }
}

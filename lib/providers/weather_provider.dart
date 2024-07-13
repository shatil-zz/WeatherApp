import 'package:flutter/material.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/data/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  String cityName = "";
  Resources<WeatherData> resources = Resources();

  searchTemperatureByCityName(String cityName) async {
    this.cityName = cityName;
    resources.status = ResourceStatus.LOADING;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 10));
    resources.status = ResourceStatus.ERROR;
    resources.message = "Load failed";
    notifyListeners();
  }
}

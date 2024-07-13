import 'package:weather_app/api_client/api_client.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/api_client/url_builders.dart';
import 'package:weather_app/data/weather_data.dart';

class WeatherRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Resources<WeatherData>> getWeatherData(String city) async {
    return _apiClient.get<WeatherData>(UrlBuilder().weather(city));
  }
}

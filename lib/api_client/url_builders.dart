
import 'package:weather_app/api_client/api_keys.dart';

class UrlBuilder {
  static final UrlBuilder _instance = UrlBuilder._internal();

  UrlBuilder._internal();

  factory UrlBuilder() => _instance;

  final String _apiBaseUrl = "api.openweathermap.org";
  final String _apiPath = "/data/2.5/";

  Uri weather(String city) => _buildUri(
        endpoint: "weather",
        parametersBuilder: () => cityQueryParameters(city),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParameters(String city) => {
        "q": city,
        "appid": weatherApiKey,
        "units": "metric",
      };
}

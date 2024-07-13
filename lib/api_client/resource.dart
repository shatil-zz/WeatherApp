import 'dart:convert';
import 'package:weather_app/data/weather_data.dart';

class Resources<T> {
  ResourceStatus status = ResourceStatus.EMPTY;
  String? message;
  T? model;
  List<T>? models;

  bool get isLoading => status == ResourceStatus.LOADING;

  bool get isSuccess => status == ResourceStatus.SUCCESS;

  bool get isError => status == ResourceStatus.ERROR;

  bool get isEmpty => status == ResourceStatus.EMPTY;

  Resources();

  factory Resources.fromResponse({required int statusCode, required body}) {
    final resources = Resources<T>();
    switch (statusCode) {
      case 200:
        final data = json.decode(body);
        resources.model = ResponseParser.fromJson<T>(data);
        resources.status = ResourceStatus.SUCCESS;
      case 401:
        resources.message = "Invalid API key";
        resources.status = ResourceStatus.ERROR;
      case 404:
        resources.message = "City not found";
        resources.status = ResourceStatus.ERROR;
      default:
        resources.message = "Unknown Error";
        resources.status = ResourceStatus.ERROR;
    }
    return resources;
  }

  factory Resources.fromStatus(
      {status = ResourceStatus.EMPTY, message, model}) {
    final resources = Resources<T>();
    resources.status = status;
    return resources;
  }
}

enum ResourceStatus { EMPTY, LOADING, SUCCESS, ERROR }

abstract class ResponseParser {
  static T? fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case const (WeatherData):
        return WeatherData.fromJson(json) as T;
      default:
        return json as T;
    }
  }
}

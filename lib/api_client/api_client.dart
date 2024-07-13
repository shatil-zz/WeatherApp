import 'dart:io';

import 'package:weather_app/api_client/resource.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Resources<T>> get<T>(Uri url) async {
    try {
      final response = await http.get(url, headers: {});
      return Resources<T>.fromResponse(
          statusCode: response.statusCode, body: response.body);
    } on SocketException catch (_) {
      return Resources.error(message: "No internet");
    } catch (e) {
      return Resources.error(message: "Unknown exception in app");
    }
  }
}

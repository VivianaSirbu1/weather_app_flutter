import 'dart:convert';
import 'dart:io';

import 'package:wwather_app_a/model/weather_model.dart';
import 'package:wwather_app_a/service/http_service.dart';

class WeatherRepository {
  Future<WeatherData> getWeatherFromApi(String cityName) async {
    try {
      final response = await HttpService.getRequest("$cityName");

      if (response.statusCode == 200) {
        return parsedJson(response.body);
      } else {
        throw Exception();
      }
    } on SocketException {
      rethrow;
    } on HttpException {
      rethrow;
    } on FormatException {
      rethrow;
    }
  }

  WeatherData parsedJson(final response) {
    final responseData = json.decode(response);
    final weatherData = responseData["main"];
    return WeatherData.fromJson(weatherData);
  }
}

import 'dart:convert';

import 'package:weather_app/app/data/api_keys.dart';
import 'package:weather_app/app/models/weather.dart';
import 'package:weather_app/app/providers/http_provider.dart';

class WeatherApiClient {
  Future<String> getCityNameFromLocation(
      double latitude, double longitude) async {
    final endpoint =
        'weather?lat=$latitude&lon=$longitude&appid=${ApiKey.OPEN_WEATHER_MAP}';

    final response = await httpProvider.getClient(endpoint);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      return responseBody['name'];
    } else {
      return null;
    }
  }

  Future<Weather> getWeatherData(String cityName) async {
    final endpoint = 'weather?q=$cityName&appid=${ApiKey.OPEN_WEATHER_MAP}';

    final response = await httpProvider.getClient(endpoint);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      Weather weather;
      weather = Weather.fromJson(responseBody);

      if (weather != null) {
        return weather;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Weather>> getForecastData(String cityName) async {
    final endpoint = 'forecast?q=$cityName&appid=${ApiKey.OPEN_WEATHER_MAP}';

    final response = await httpProvider.getClient(endpoint);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<Weather> weathers;
      weathers = Weather.fromForecastJson(responseBody);

      if (weathers.isNotEmpty) {
        return weathers;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

final WeatherApiClient weatherApiClient = WeatherApiClient();

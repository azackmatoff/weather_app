import 'package:weather_app/app/data/weather_api_client.dart';
import 'package:weather_app/app/models/weather.dart';

class WeatherRepository {
  Future<Weather> getWeather(
      {String cityName, double latitude, double longitude}) async {
    if (cityName == null) {
      cityName =
          await weatherApiClient.getCityNameFromLocation(latitude, longitude);
    }
    final weather = await weatherApiClient.getWeatherData(cityName);

    if (weather == null) {
      return null;
    }

    final weathers = await weatherApiClient.getForecastData(cityName);

    if (weathers.isEmpty) {
      return null;
    }

    weather.forecast = weathers;
    return weather;
  }
}

final WeatherRepository weatherRepository = WeatherRepository();

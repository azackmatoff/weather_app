import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/WeatherIconMapper.dart';
import 'package:weather_app/app/utils/converters.dart';

class Weather {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String main;
  String cityName;

  double windSpeed;

  Temperature temperature;
  Temperature maxTemperature;
  Temperature minTemperature;

  String tempForCache;
  String maxTempForCache;
  String minTempForCache;

  List<Weather> forecast;
  List<Map<String, dynamic>> forecastCache;

  Weather({
    this.id,
    this.time,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.description,
    this.iconCode,
    this.main,
    this.cityName,
    this.windSpeed,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.forecast,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    //Server gives a list of Sets, but it's only sinlge Set available and we're getting it
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static Weather fromJsonCache(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      time: json['time'],
      description: json['description'],
      iconCode: json['iconCode'],
      main: json['main'],
      cityName: json['cityName'],
      temperature: Temperature(intToDouble(json['tempForCache'])),
      maxTemperature: Temperature(intToDouble(json['maxTempForCache'])),
      minTemperature: Temperature(intToDouble(json['minTempForCache'])),
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      humidity: json['humidity'],
      windSpeed: intToDouble(json['windSpeed']),
      forecast: List<Weather>.from(
          json["forecastCache"].map((x) => Weather.fromForecastJsonCache(x))),
    );
  }

  Map<String, dynamic> toJsonCache() => {
        'id': id,
        'time': time,
        'sunrise': sunrise,
        'sunset': sunset,
        'humidity': humidity,
        'description': description,
        'iconCode': iconCode,
        'main': main,
        'cityName': cityName,
        'windSpeed': windSpeed,
        'tempForCache': temperatureToDouble(temperature),
        'maxTempForCache': temperatureToDouble(maxTemperature),
        'minTempForCache': temperatureToDouble(minTemperature),
        'forecastCache':
            List<dynamic>.from(forecast.map((x) => x.toJsonForecast())),
      };

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    // ignore: deprecated_member_use
    final weathers = List<Weather>();
    for (var item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(item['main']['temp'])),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  static Weather fromForecastJsonCache(Map<String, dynamic> json) {
    return Weather(
      time: json['time'],
      temperature: Temperature(intToDouble(json['temperature'])),
      iconCode: json['iconCode'],
    );
  }

  Map<String, dynamic> toJsonForecast() => {
        "time": time,
        "temperature": temperatureToDouble(temperature),
        "iconCode": iconCode,
      };

  IconData getIconData() {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:weather_app/app/models/weather.dart';
import 'package:weather_app/app/providers/geolocation_provider.dart';
import 'package:weather_app/app/providers/local_storage.dart';
import 'package:weather_app/app/repo/weather_repo.dart';

class WeatherController extends GetxController {
  static WeatherController findWeatherController = Get.find();

  Rx<Weather> _weatherData = Weather().obs;

  Weather get weatherData => _weatherData.value;

  RxBool loading = false.obs;
  RxBool cacheEmtpy = false.obs;
  RxBool noInternet = false.obs;
  RxBool noDataAtAll = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateNoDataAtAll(bool v) {
    noDataAtAll.value = v;
    update();
  }

  void updateNoInternet(bool v) {
    noInternet.value = v;
    update();
  }

  void updateLoading(bool v) {
    loading.value = v;
    update();
  }

  void updateCacheEmpty(bool v) {
    cacheEmtpy.value = v;
    update();
  }

  Future<void> checkInternetConnection() async {
    try {
      updateLoading(true);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        updateNoInternet(false);
        updateLoading(false);
      } else {
        updateNoInternet(true);
        updateLoading(false);
      }
    } on SocketException catch (e) {
      updateNoInternet(true);
      updateLoading(false);
      throw Exception(e);
    }
  }

  Future<void> getUserLocationAndWeather() async {
    updateLoading(true);
    final _position = await geolocationProvider.getUserLocaiton();

    if (_position != null) {
      await getWeather(
          latitude: _position.latitude, longitude: _position.longitude);
    } else {
      updateLoading(false);
    }
  }

  Future<void> getWeatherFromCache() async {
    updateLoading(true);
    updateCacheEmpty(false);
    final _dataFromCache = LocalStorage.getString('weather');

    if (_dataFromCache != null) {
      final _convertedData = Weather.fromJsonCache(json.decode(_dataFromCache));
      _weatherData.value = _convertedData;
      update();
      updateLoading(false);
      updateNoDataAtAll(false);
    } else {
      updateCacheEmpty(true);
      updateLoading(false);
      updateNoDataAtAll(true);
    }
  }

  Future<Weather> getWeather(
      {String cityName, double latitude, double longitude}) async {
    updateLoading(true);
    final _data = await weatherRepository.getWeather(
        cityName: cityName, latitude: latitude, longitude: longitude);

    if (_data != null) {
      _weatherData.value = _data;
      await LocalStorage.putWeatherDataToCache(_data);
      update();
      updateLoading(false);

      return _data;
    } else {
      updateLoading(false);
      return null;
    }
  }
}

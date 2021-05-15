import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/models/weather.dart';

class LocalStorage {
  static LocalStorage _localStorage;
  static SharedPreferences _preferences;

  static Future<LocalStorage> getInstance() async {
    if (_localStorage == null) {
      var localStorage = LocalStorage._();
      await localStorage._init();
      _localStorage = localStorage;
    }
    return _localStorage;
  }

  LocalStorage._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key) {
    final resp = _preferences.getString(key);

    if (resp == null || resp == "") {
      return null;
    } else {
      return resp;
    }
  }

  static Future<void> putWeatherDataToCache(Weather data) async {
    await removeString('weather');
    final userData = json.encode(data.toJsonCache());
    await putString("weather", userData);
  }

  // put string
  static Future<bool> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  // clear string
  static Future<bool> removeString(String key) {
    SharedPreferences prefs = _preferences;
    return prefs.remove(key);
  }

  // clear string
  static Future<bool> clrString() {
    SharedPreferences prefs = _preferences;
    return prefs.clear();
  }

  // get bool
  static bool getBool(String key) {
    final resp = _preferences.getBool(key);
    return resp;
  }

  // put bool
  static Future<bool> putBool(String key, bool value) async {
    final val = await _preferences.setBool(key, value);
    if (val == null) {
      return null;
    } else {
      return val;
    }
  }
}

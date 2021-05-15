import 'package:get/get.dart';

import 'package:weather_app/app/modules/weather/bindings/weather_binding.dart';
import 'package:weather_app/app/modules/weather/views/weather_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WEATHER;

  static final routes = [
    GetPage(
      name: _Paths.WEATHER,
      page: () => WeatherView(),
      binding: WeatherBinding(),
    ),
  ];
}

import 'package:get/get.dart';
import 'package:weather_app/app/modules/weather/controllers/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(
      () => WeatherController(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:weather_app/app/modules/weather/bindings/weather_binding.dart';

import 'package:weather_app/app/providers/local_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //// initialize local storage once before running the app
  //// and keep using it through out the app life cycle
  await LocalStorage.getInstance();
  //// get api base url
  await GlobalConfiguration().loadFromAsset("configurations");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Weather App",
      initialRoute: AppPages.INITIAL,
      initialBinding: WeatherBinding(), //initiale WeatherController
      getPages: AppPages.routes,
    );
  }
}

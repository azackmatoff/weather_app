import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/constants/app_colors.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';
import 'package:weather_app/app/modules/weather/controllers/weather_controller.dart';
import 'package:weather_app/app/widgets/custom_dialog.dart';

import 'package:weather_app/app/widgets/weather_widget.dart';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final WeatherController _weatherController =
      WeatherController.findWeatherController;

  String _cityName;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await _weatherController.checkInternetConnection();
    if (_weatherController.noInternet.value) {
      await _weatherController.getWeatherFromCache();
    } else {
      await _weatherController.getUserLocationAndWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
              style: AppTextStyles.secondaryColor16,
            )
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: _showCityChangeDialog,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 14.0),
              child: Text('Change city', style: AppTextStyles.secondaryColor16),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                children: [
                  _weatherController.loading.value
                      ? SizedBox()
                      : WeatherWidget(
                          weather: _weatherController.weatherData,
                        ),
                  _weatherController.noInternet.value &&
                          _weatherController.noDataAtAll.value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                'No internet and no data available from local storage',
                                style: AppTextStyles.secondaryColor25),
                          ),
                        )
                      : SizedBox.shrink(),
                  _weatherController.weatherData == null ||
                          _weatherController.weatherData.isBlank
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'There was an error fetching weather data',
                              style: AppTextStyles.black16,
                            ),
                            FlatButton(
                              child: Text(
                                "Try Again",
                                style: AppTextStyles.black18,
                              ),
                              onPressed: getData,
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  _weatherController.loading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.secondaryColor,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCityChangeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Change city', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ok',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              onPressed: () async {
                final _data =
                    await _weatherController.getWeather(cityName: _cityName);
                if (_data != null) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  CustomDialog().getDialog(
                    title: 'Error!',
                    content:
                        'Either you have entered a wrong city name or there has been some errors on server side. Please try with a valid city name',
                    isError: true,
                  );
                }
              },
            ),
          ],
          content: TextField(
            autofocus: true,
            onChanged: (text) {
              _cityName = text;
            },
            decoration: InputDecoration(
              hintText: 'Name of your city',
              hintStyle: TextStyle(color: Colors.black),
              suffixIcon: GestureDetector(
                onTap: () async {
                  final _data =
                      await _weatherController.getWeather(cityName: _cityName);
                  if (_data != null) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    CustomDialog().getDialog(
                      title: 'Error!',
                      content:
                          'Either you have entered a wrong city name or there has been some errors on server side. Please try with a valid city name',
                      isError: true,
                    );
                  }
                },
                child: Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.black,
          ),
        );
      },
    );
  }
}

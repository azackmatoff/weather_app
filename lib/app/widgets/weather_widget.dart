import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';
import 'package:weather_app/app/models/weather.dart';
import 'package:weather_app/app/widgets/current_conditions.dart';
import 'package:weather_app/app/widgets/custom_divider.dart';
import 'package:weather_app/app/widgets/forecast_horizontal_widget.dart';
import 'package:weather_app/app/widgets/value_tile.dart';
import 'package:weather_app/app/widgets/vertical_divider.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather.cityName?.toUpperCase() ?? '',
              style: AppTextStyles.secondaryColor25,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              weather.description?.toUpperCase(),
              style: AppTextStyles.secondaryColor16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: CurrentConditions(
                weather: weather,
              ),
            ),
            CustomDivider(),
            ForecastHorizontal(weathers: weather.forecast),
            CustomDivider(),
            SizedBox(
              height: 150,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ValueTile("wind speed", '${weather.windSpeed} m/s'),
                  CustomVerticalDivider(),
                  ValueTile(
                    "sunrise",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            weather.sunrise * 1000)),
                  ),
                  CustomVerticalDivider(),
                  ValueTile(
                    "sunset",
                    DateFormat('h:m a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            weather.sunset * 1000)),
                  ),
                  CustomVerticalDivider(),
                  ValueTile("humidity", '${weather.humidity}%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

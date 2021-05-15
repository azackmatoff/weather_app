import 'package:flutter/material.dart';
import 'package:weather_app/app/constants/app_colors.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';
import 'package:weather_app/app/enums/enums.dart';
import 'package:weather_app/app/models/weather.dart';
import 'package:weather_app/app/widgets/value_tile.dart';
import 'package:weather_app/app/widgets/vertical_divider.dart';

/// Renders Weather Icon, current, min and max temperatures
class CurrentConditions extends StatelessWidget {
  final Weather weather;
  const CurrentConditions({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          color: AppColors.secondaryColor,
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${weather.temperature.as(TemperatureUnit.celsius).round()}°',
          style: AppTextStyles.white100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueTile("max",
                '${weather.maxTemperature.as(TemperatureUnit.celsius).round()}°'),
            CustomVerticalDivider(),
            ValueTile("min",
                '${weather.minTemperature.as(TemperatureUnit.celsius).round()}°'),
          ],
        ),
      ],
    );
  }
}

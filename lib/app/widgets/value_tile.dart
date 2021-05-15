import 'package:flutter/material.dart';

import 'package:weather_app/app/constants/app_colors.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData] which is optional
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.white14,
        ),
        SizedBox(
          height: 5,
        ),
        iconData != null
            ? Icon(
                iconData,
                color: AppColors.secondaryColorLight,
                size: 20,
              )
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.secondaryColorLight,
          ),
        ),
      ],
    );
  }
}

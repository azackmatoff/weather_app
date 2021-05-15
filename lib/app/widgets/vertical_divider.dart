import 'package:flutter/material.dart';
import 'package:weather_app/app/constants/app_colors.dart';

class CustomVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Center(
        child: Container(
          width: 1,
          height: 30,
          color: AppColors.white.withAlpha(80),
        ),
      ),
    );
  }
}

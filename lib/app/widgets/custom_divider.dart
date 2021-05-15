import 'package:flutter/material.dart';
import 'package:weather_app/app/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Divider(
        color: AppColors.white.withAlpha(80),
      ),
      padding: EdgeInsets.all(10),
    );
  }
}

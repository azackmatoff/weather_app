import 'package:flutter/material.dart';
import 'package:weather_app/app/constants/app_colors.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';

// ignore: must_be_immutable
class CustomTextWidget extends StatelessWidget {
  CustomTextWidget({
    this.text,
    this.textColor = AppColors.black,
    this.isCentered = false,
    this.islongTxt = false,
    this.maxLine = 1,
    this.textStyle,
  });

  final String text;
  TextStyle
      textStyle; // Since we're using Goolge fonts, textstyle is not constant, thus it can't be final
  final Color textColor;
  final bool isCentered;
  final int maxLine;
  final bool islongTxt;

  @override
  Widget build(BuildContext context) {
    if (textStyle == null) textStyle = AppTextStyles.black14;
    return Text(
      text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: islongTxt ? null : maxLine,
      style: textStyle,
    );
  }
}

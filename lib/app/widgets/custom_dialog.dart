import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/constants/app_colors.dart';
import 'package:weather_app/app/constants/app_textStyles.dart';
import 'package:weather_app/app/widgets/custom_text_widget.dart';

class CustomDialog {
  getDialog({String title, String content, bool isError = false}) {
    Get.defaultDialog(
      title: title,
      titleStyle: isError ? AppTextStyles.redBold20 : AppTextStyles.blackBold20,
      content: Container(
        width: Get.size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Image.asset(
              "assets/images/weather.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomTextWidget(
                text: content,
                maxLine: 5,
                isCentered: true,
                textStyle: AppTextStyles.black16,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: CustomTextWidget(
                  text: "OK",
                  textColor: AppColors.white,
                  textStyle: AppTextStyles.white18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

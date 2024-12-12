import 'package:flutter/material.dart';
import 'package:task_application/core/constants/color_strings.dart';

class AppTextStyles {
  static const TextStyle splashText = TextStyle(
    fontSize: 32.0,
    fontFamily: "splashText",
    fontWeight: FontWeight.bold,
    color: AppColors.background,
  );
  static const TextStyle headline1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline5 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline6 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subtitle1 = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.fadedTextColor);

  static const TextStyle subtitle2 = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.fadedTextColor);

  static const TextStyle bodyText1 = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: AppColors.textColor);

  static const TextStyle bodyText2 = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppColors.textColor);

  static const TextStyle caption = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppColors.fadedTextColor);

  static const TextStyle button1 = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: AppColors.buttonTextColor);
  static const TextStyle button2 = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.bold, color: AppColors.button);
  static const TextStyle labelText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle labelTextSmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static const TextStyle inputField = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  static const TextStyle inputFieldHint = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.fadedTextColor,
  );
  // Card Text Styles
  static const TextStyle cardTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w900,
    color: AppColors.textColor,
  );

  static const TextStyle cardBody1 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w800,
    color: AppColors.textColor,
  );
  static const TextStyle cardBody2 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
    color: AppColors.textColor,
  );
  static const TextStyle completedText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
    color: AppColors.greenColor,
  );
  static const TextStyle incompletedText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
    color: AppColors.redColor,
  );

}

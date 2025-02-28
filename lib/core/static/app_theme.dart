import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/static/texr_theme.dart';

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    textTheme: textTemeApp,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
  )),
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.button),
      iconTheme: IconThemeData(
        color: AppColors.button,
      )),
);

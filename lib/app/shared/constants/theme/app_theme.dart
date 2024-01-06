import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return AppColors.dark;
      } else if (states.contains(MaterialState.selected)) {
        return AppColors.green;
      } else {
        return AppColors.white;
      }
    })),
    primaryColor: AppColors.white,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.grey2,
          backgroundColor: AppColors.dark,
          textStyle: TextStyle(color: AppColors.white, fontSize: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          minimumSize: Size(200, 40)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.dark,
      labelStyle: TextStyle(color: AppColors.grey4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.red)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.dark)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.dark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.green),
      ),
      fillColor: AppColors.dark,
    ),
    textTheme: TextTheme(),
  );
}

import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData themeData = ThemeData(
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return AppColors.dark;
      } else if (states.contains(MaterialState.selected)) {
        return AppColors.green;
      } else {
        return AppColors.dark;
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
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.dark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.red)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.green)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.dark),
      ),
      fillColor: AppColors.dark,
    ),
    textTheme: TextTheme(),
  );
}
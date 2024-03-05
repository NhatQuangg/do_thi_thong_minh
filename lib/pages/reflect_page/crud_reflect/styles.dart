import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  AppStyles._();

  static const Roboto = "Roboto";
  static final boxShadow = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      boxShadow: [
        BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 3),
            color: Color.fromRGBO(0, 0, 0, .16))
      ]);
  static const textTheme = TextTheme(
      bodyLarge: const TextStyle(
          fontFamily: Roboto, fontSize: 14, color: AppColors.textDark),
      bodyMedium: const TextStyle(
          fontFamily: Roboto, fontSize: 12, color: AppColors.textDark),
      titleMedium: const TextStyle(
          fontFamily: Roboto, fontSize: 14, color: AppColors.textDark),
      titleSmall: const TextStyle(
          fontFamily: Roboto, fontSize: 12, color: AppColors.textDark),
      bodySmall: const TextStyle(
          fontFamily: Roboto, fontSize: 10, color: AppColors.lightGrey),
      titleLarge: const TextStyle(
          fontFamily: Roboto,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark),
      headlineSmall: const TextStyle(
          fontFamily: Roboto,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark),
      headlineMedium: const TextStyle(
          fontFamily: Roboto,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark),
      displaySmall: const TextStyle(
          fontFamily: Roboto,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark),
      displayMedium: const TextStyle(
          fontFamily: Roboto,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: AppColors.textDark));

  static const textTitle = TextStyle(
      fontFamily: Roboto,
      fontSize: 18,
      color: AppColors.textColorTitleDetailReflect);
  static const textTitleNotify = TextStyle(
      fontFamily: Roboto,
      fontSize: 20,
      color: AppColors.textColorTitleDetailReflect,
      fontWeight: FontWeight.w700);
  static const textunselectedLabel = TextStyle(
      fontFamily: Roboto, fontSize: 18, color: AppColors.unselectedLabel);
  static const textGreen =
      TextStyle(fontFamily: Roboto, fontSize: 16, color: AppColors.ButtonGreen);
  static const textGreen13 =
      TextStyle(fontFamily: Roboto, fontSize: 13, color: AppColors.ButtonGreen);
  static const textTitleBold = TextStyle(
      fontFamily: Roboto,
      fontSize: 18,
      color: AppColors.unselectedLabel,
      fontWeight: FontWeight.w700);
  static const textTitleMenuDetail =
      TextStyle(fontFamily: Roboto, fontSize: 14, color: AppColors.ButtonGreen);
  static const textBodyDetailReflect = TextStyle(
      fontFamily: Roboto,
      fontSize: 16,
      color: AppColors.textColorBodyDetailReflect);
  static const textBodyLarge = TextStyle(
      fontFamily: Roboto,
      fontSize: 14,
      color: AppColors.textColorBodyDetailReflect,
      fontWeight: FontWeight.w700);
  static const textBodyVeryLarge = TextStyle(
      fontFamily: Roboto,
      fontSize: 16,
      color: AppColors.textColorBodyDetailReflect,
      fontWeight: FontWeight.w700);
}

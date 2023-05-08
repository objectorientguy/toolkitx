import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData appTheme = ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: appCardTheme,
    scaffoldBackgroundColor: AppColor.lightestBlue,
    elevatedButtonTheme: elevatedButtonThemeData);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: AppColor.deepBlue));

const ColorScheme colorScheme = ColorScheme.light(
    primary: AppColor.lightGrey,
    secondary: AppColor.white,
    surface: AppColor.white,
    background: AppColor.white);

AppBarTheme appBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: AppColor.blueGrey,
    iconTheme: iconThemeData,
    titleTextStyle: const TextStyle(color: AppColor.black));

IconThemeData iconThemeData =
    const IconThemeData(color: Colors.black, size: 16);

CardTheme appCardTheme = const CardTheme();

extension AppTextTheme on TextTheme {
  TextStyle get largeTitle {
    return const TextStyle(
        fontSize: 17, fontWeight: FontWeight.bold, color: AppColor.black);
  }

  TextStyle get xLarge {
    return const TextStyle(fontSize: 22, color: AppColor.mediumBlack);
  }

  TextStyle get xxLarge {
    return const TextStyle(fontSize: 24, color: AppColor.mediumBlack);
  }
}

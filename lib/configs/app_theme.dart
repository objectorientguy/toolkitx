import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData appTheme = ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: appCardTheme,
    scaffoldBackgroundColor: AppColor.lightestBlue);
ButtonStyle buttonStyle =
    ElevatedButton.styleFrom(backgroundColor: AppColor.deepBlue);
const ColorScheme colorScheme = ColorScheme.light(
    primary: AppColor.blueGrey,
    secondary: AppColor.lightestBlue,
    surface: AppColor.white,
    background: AppColor.white);

AppBarTheme appBarTheme = const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColor.blueGrey,
    titleTextStyle: TextStyle(color: AppColor.black));

IconThemeData iconThemeData =
    IconThemeData(color: colorScheme.primary, size: 16);

CardTheme appCardTheme = const CardTheme();

extension AppTextTheme on TextTheme {
  TextStyle get xxLarge {
    return const TextStyle(
        fontSize: 24, fontFamily: 'Urbanist', color: AppColor.mediumBlack);
  }

  TextStyle get xLarge {
    return const TextStyle(
        fontSize: 22, fontFamily: 'Urbanist', color: AppColor.mediumBlack);
  }

  TextStyle get largeTitle {
    return const TextStyle(
        fontSize: 17,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
        color: AppColor.black);
  }
}

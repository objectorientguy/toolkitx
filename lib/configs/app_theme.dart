import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData appTheme = ThemeData(
  colorScheme: colorScheme,
  appBarTheme: appBarTheme,
  cardTheme: appCardTheme,
  scaffoldBackgroundColor: AppColor.white,
);

const ColorScheme colorScheme = ColorScheme.light(
    primary: AppColor.blueGrey,
    secondary: AppColor.lightestBlue,
    onError: AppColor.red,
    surface: AppColor.white,
    background: AppColor.white);

AppBarTheme appBarTheme = const AppBarTheme(
    elevation: 0, centerTitle: true, backgroundColor: AppColor.white);

IconThemeData iconThemeData =
    IconThemeData(color: colorScheme.primary, size: 16);

CardTheme appCardTheme = const CardTheme();

extension AppTextTheme on TextTheme {
  TextStyle get xlarge {
    return const TextStyle(
        fontSize: 24, fontFamily: 'Urbanist', color: AppColor.mediumBlack);
  }

  TextStyle get large {
    return const TextStyle(
        fontSize: 20,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.normal,
        color: AppColor.lightBlack);
  }

  TextStyle get medium {
    return const TextStyle(
        fontSize: 17,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.normal,
        color: AppColor.grey);
  }

  TextStyle get small {
    return const TextStyle(
        fontSize: 15, fontFamily: 'Urbanist', color: AppColor.lightBlack);
  }

  TextStyle get xSmall {
    return const TextStyle(
        fontSize: 13,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.normal,
        color: AppColor.lightBlack);
  }
}

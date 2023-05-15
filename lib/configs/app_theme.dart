import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_dimensions.dart';

ThemeData appTheme = ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    cardTheme: appCardTheme,
    scaffoldBackgroundColor: AppColor.ghostWhite,
    elevatedButtonTheme: elevatedButtonThemeData);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.deepBlue,
        minimumSize: const Size(double.maxFinite, 45.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        )));

const ColorScheme colorScheme = ColorScheme.light(primary: AppColor.deepBlue);

AppBarTheme appBarTheme = AppBarTheme(
    elevation: 0,
    backgroundColor: AppColor.blueGrey,
    iconTheme: iconThemeData,
    titleTextStyle: const TextStyle(color: AppColor.black));

IconThemeData iconThemeData =
    const IconThemeData(color: Colors.black, size: 16);

CardTheme appCardTheme = const CardTheme(elevation: 1, margin: EdgeInsets.zero);

extension AppTextTheme on TextTheme {
  TextStyle get medium {
    return const TextStyle(
        fontSize: 17, fontWeight: FontWeight.bold, color: AppColor.black);
  }

  TextStyle get xLarge {
    return const TextStyle(fontSize: 22, color: AppColor.mediumBlack);
  }

  TextStyle get xxLarge {
    return const TextStyle(fontSize: 24, color: AppColor.mediumBlack);
  }

  TextStyle get large {
    return const TextStyle(fontSize: 20, color: AppColor.mediumBlack);
  }

  TextStyle get small {
    return const TextStyle(fontSize: 16, color: AppColor.grey);
  }

  TextStyle get xSmall {
    return const TextStyle(
        fontSize: 14, color: AppColor.mediumBlack, fontWeight: FontWeight.w400);
  }

  TextStyle get xxSmall {
    return const TextStyle(fontSize: 12, color: AppColor.mediumBlack);
  }
}

import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_dimensions.dart';
import 'app_spacing.dart';

ThemeData appTheme = ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    listTileTheme: listTileTheme,
    cardTheme: appCardTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    textButtonTheme: textButtonTheme,
    scaffoldBackgroundColor: AppColor.ghostWhite,
    elevatedButtonTheme: elevatedButtonThemeData,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    expansionTileTheme: expansionTileThemeData);

FloatingActionButtonThemeData floatingActionButtonThemeData =
    const FloatingActionButtonThemeData(
        backgroundColor: AppColor.deepBlue,
        iconSize: kFloatingButtonIconSize,
        foregroundColor: AppColor.white);

ExpansionTileThemeData expansionTileThemeData = ExpansionTileThemeData(
    tilePadding: const EdgeInsets.only(
        left: kExpansionTileMargin, right: kExpansionTileMargin),
    collapsedBackgroundColor: AppColor.white,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius)),
    backgroundColor: AppColor.white,
    iconColor: AppColor.deepBlue,
    textColor: AppColor.black);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.deepBlue,
        minimumSize: const Size(double.maxFinite, 45.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius))));

TextButtonThemeData textButtonTheme =
    TextButtonThemeData(style: TextButton.styleFrom(padding: EdgeInsets.zero));
const ColorScheme colorScheme = ColorScheme.light(primary: AppColor.deepBlue);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    const BottomNavigationBarThemeData(
        backgroundColor: AppColor.white, elevation: 0);

BottomAppBarTheme? bottomAppBarTheme = const BottomAppBarTheme(
    color: AppColor.white,
    elevation: 0,
    padding: EdgeInsets.all(leftRightMargin));

ListTileThemeData listTileTheme = const ListTileThemeData(dense: true);

AppBarTheme appBarTheme = AppBarTheme(
    elevation: 0, backgroundColor: AppColor.blueGrey, iconTheme: iconThemeData);

IconThemeData iconThemeData = const IconThemeData(color: AppColor.black);

CardTheme appCardTheme =
    const CardTheme(elevation: kCardElevation, margin: EdgeInsets.zero);

extension AppTextTheme on TextTheme {
  TextStyle get medium {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.black);
  }

  TextStyle get mediumLarge {
    return const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.black);
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

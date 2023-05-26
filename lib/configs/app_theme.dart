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
    outlinedButtonTheme: outlinedButtonThemeData,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    expansionTileTheme: expansionTileTheme,
    textButtonTheme: textButtonTheme,
    popupMenuTheme: popupMenuThemeData,
    scaffoldBackgroundColor: colorScheme.background,
    elevatedButtonTheme: elevatedButtonThemeData);

FloatingActionButtonThemeData floatingActionButtonThemeData =
    const FloatingActionButtonThemeData(
        backgroundColor: AppColor.deepBlue,
        iconSize: kFloatingButtonIconSize,
        foregroundColor: AppColor.white);

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, kElevatedButtonHeight),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCardRadius))));

PopupMenuThemeData popupMenuThemeData = PopupMenuThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius)));

ExpansionTileThemeData expansionTileTheme = ExpansionTileThemeData(
    tilePadding: const EdgeInsets.only(
        left: expansionTileMargin, right: expansionTileMargin),
    collapsedBackgroundColor: AppColor.white,
    iconColor: colorScheme.primary,
    textColor: AppColor.black);

OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.primary),
        minimumSize: const Size(double.maxFinite, kOutlinedButtonHeight)));

TextButtonThemeData textButtonTheme =
    TextButtonThemeData(style: TextButton.styleFrom(padding: EdgeInsets.zero));
ColorScheme colorScheme = const ColorScheme.light(
    primary: AppColor.deepBlue,
    background: AppColor.lightestBlue,
    secondary: AppColor.deepBlue,
    error: AppColor.errorRed);

BottomNavigationBarThemeData bottomNavigationBarTheme =
    BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background, elevation: kZeroElevation);

BottomAppBarTheme? bottomAppBarTheme = const BottomAppBarTheme(
    color: AppColor.white,
    elevation: kZeroElevation,
    padding: EdgeInsets.all(leftRightMargin));

ListTileThemeData listTileTheme = const ListTileThemeData(dense: true);

AppBarTheme appBarTheme = AppBarTheme(
    elevation: kZeroElevation,
    backgroundColor: AppColor.blueGrey,
    iconTheme: iconThemeData);

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

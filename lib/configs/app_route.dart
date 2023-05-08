import 'package:flutter/material.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/onboarding/selectYourTimeZone/select_your_time_zone_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingScreen.routeName:
        return _materialRoute(const OnBoardingScreen());
      case SelectYourTimeZoneScreen.routeName:
        return _materialRoute(const SelectYourTimeZoneScreen());
      default:
        return _materialRoute(const OnBoardingScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

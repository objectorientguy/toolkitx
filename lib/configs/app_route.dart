import 'package:flutter/material.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_email_screen.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import '../screens/onboarding/selectYourDateFormat/select_your_date_format_screen.dart';
import '../screens/onboarding/selectYourLanguage/select_your_language_screen.dart';
import '../screens/onboarding/selectYourTimeZone/select_your_time_zone_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _materialRoute(const WelcomeScreen());
      case SelectYourLanguageScreen.routeName:
        return _materialRoute(const SelectYourLanguageScreen());
      case SelectYourTimeZoneScreen.routeName:
        return _materialRoute(const SelectYourTimeZoneScreen());
      case SelectYourDateFormatScreen.routeName:
        return _materialRoute(const SelectYourDateFormatScreen());
      case LoginEmailScreen.routeName:
        return _materialRoute(const LoginEmailScreen());
      case PasswordScreen.routeName:
        return _materialRoute(const PasswordScreen());
      default:
        return _materialRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

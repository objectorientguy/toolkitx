import 'package:flutter/material.dart';
import '../screens/checklist/change_role_screen.dart';
import '../screens/checklist/checklist_list_screen.dart';
import '../screens/checklist/details_screen.dart';
import '../screens/checklist/filters_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/onboarding/client_list_screen.dart';
import '../screens/onboarding/language/select_language_screen.dart';
import '../screens/onboarding/login/login_screen.dart';
import '../screens/onboarding/login/password_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/profile/changePassword/change_password_screen.dart';
import '../screens/profile/changePassword/select_change_password_screen.dart';
import '../screens/profile/change_date_format.dart';
import '../screens/profile/change_language_screen.dart';
import '../screens/profile/change_time_zone_screen.dart';
import '../screens/profile/edit/edit_screen.dart';
import '../screens/root/root_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _materialRoute(const WelcomeScreen());
      case SelectLanguageScreen.routeName:
        return _materialRoute(const SelectLanguageScreen());
      case SelectTimeZoneScreen.routeName:
        return _materialRoute(const SelectTimeZoneScreen());
      case SelectDateFormatScreen.routeName:
        return _materialRoute(const SelectDateFormatScreen());
      case LoginScreen.routeName:
        return _materialRoute(LoginScreen());
      case PasswordScreen.routeName:
        return _materialRoute(PasswordScreen());
      case RootScreen.routeName:
        return _materialRoute(const RootScreen());
      case EditScreen.routeName:
        return _materialRoute(const EditScreen());
      case DetailsScreen.routeName:
        return _materialRoute(const DetailsScreen());
      case ChecklistScreen.routeName:
        return _materialRoute(const ChecklistScreen());
      case ChangeRoleScreen.routeName:
        return _materialRoute(const ChangeRoleScreen());
      case FiltersScreen.routeName:
        return _materialRoute(const FiltersScreen());
      case IncidentListScreen.routeName:
        return _materialRoute(const IncidentListScreen());
      case FilterScreen.routeName:
        return _materialRoute(const FilterScreen());
      case CategoryScreen.routeName:
        return _materialRoute(const CategoryScreen());
      case ClientListScreen.routeName:
        return _materialRoute(const ClientListScreen());
      case ChangeDateFormatScreen.routeName:
        return _materialRoute(const ChangeDateFormatScreen());
      case ChangeTimeZoneScreen.routeName:
        return _materialRoute(const ChangeTimeZoneScreen());
      case ChangeLanguageScreen.routeName:
        return _materialRoute(const ChangeLanguageScreen());
      case SelectChangePasswordTypeScreen.routeName:
        return _materialRoute(const SelectChangePasswordTypeScreen());
      case ChangePasswordScreen.routeName:
        return _materialRoute(ChangePasswordScreen());
      default:
        return _materialRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

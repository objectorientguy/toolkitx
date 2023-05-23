import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/checklist_list_screen.dart';
import 'package:toolkit/screens/checklist/details_screen.dart';
import 'package:toolkit/screens/checklist/filters_screen.dart';
import 'package:toolkit/screens/incident/report_incident/injuries_screen.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import '../screens/checklist/change_role_screen.dart';
import '../screens/incident/report_incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/incident/report_incident/add_injured_person_screen.dart';
import '../screens/incident/report_incident/health_safety_screen.dart';
import '../screens/incident/report_incident/location_screen.dart';
import '../screens/incident/report_incident/report_incident_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectLanguage/select_language_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
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
        return _materialRoute(const LoginScreen());
      case PasswordScreen.routeName:
        return _materialRoute(const PasswordScreen());
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
      case ReportIncidentScreen.routeName:
        return _materialRoute(const ReportIncidentScreen());
      case ReportIncidentLocationScreen.routeName:
        return _materialRoute(const ReportIncidentLocationScreen());
      case ReportIncidentHealthSafety.routeName:
        return _materialRoute(const ReportIncidentHealthSafety());
      case AddInjuredPersonScreen.routeName:
        return _materialRoute(const AddInjuredPersonScreen());
      case InjuriesScreen.routeName:
        return _materialRoute(const InjuriesScreen());
      default:
        return _materialRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

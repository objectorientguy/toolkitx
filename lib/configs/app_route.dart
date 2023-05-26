import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/checklist_list_screen.dart';
import 'package:toolkit/screens/checklist/details_screen.dart';
import 'package:toolkit/screens/checklist/filters_screen.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import 'package:toolkit/screens/qualityManagement/filters_screen.dart';
import 'package:toolkit/screens/qualityManagement/mark_as_resolved_screen.dart';
import 'package:toolkit/screens/qualityManagement/add_quality_management_reporting_screen.dart';
import 'package:toolkit/screens/qualityManagement/quality_management_list_screen.dart';
import 'package:toolkit/screens/qualityManagement/report_screen.dart';
import 'package:toolkit/screens/qualityManagement/reporting_screen.dart';
import '../screens/checklist/change_role_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectLanguage/select_language_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import '../screens/qualityManagement/add_comments_screen.dart';
import '../screens/qualityManagement/details_screen.dart';
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
      case QualityManagementDetailsScreen.routeName:
        return _materialRoute(const QualityManagementDetailsScreen());
      case AddQualityManagementReportingScreen.routeName:
        return _materialRoute(const AddQualityManagementReportingScreen());
      case ReportingScreen.routeName:
        return _materialRoute(const ReportingScreen());
      case AddCommentsScreen.routeName:
        return _materialRoute(const AddCommentsScreen());
      case QualityManagementFiltersScreen.routeName:
        return _materialRoute(const QualityManagementFiltersScreen());
      case QualityManagementListScreen.routeName:
        return _materialRoute(const QualityManagementListScreen());
      case ReportScreen.routeName:
        return _materialRoute(const ReportScreen());
      case MarkAsResolvedScreen.routeName:
        return _materialRoute(const MarkAsResolvedScreen());
      default:
        return _materialRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

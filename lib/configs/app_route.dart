import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/systemUser/system_user_list_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/schedule_dates_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/filters_screen.dart';
import 'package:toolkit/screens/checklist/workforce/reject_reasons.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import '../screens/checklist/systemUser/change_role_screen.dart';
import '../screens/checklist/systemUser/edit_header_screen.dart';
import '../screens/checklist/systemUser/workforce_list_screen.dart';
import '../screens/checklist/workforce/add_image_and_comment_screen.dart';
import '../screens/checklist/workforce/list_screen.dart';
import '../screens/checklist/workforce/questions_list_screen.dart';
import '../screens/checklist/workforce/edit_questions_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
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
      case SystemUserScheduleDatesScreen.routeName:
        return _materialRoute(const SystemUserScheduleDatesScreen());
      case SystemUserCheckListScreen.routeName:
        return _materialRoute(const SystemUserCheckListScreen());
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
      case ChecklistWorkForceListScreen.routeName:
        return _materialRoute(const ChecklistWorkForceListScreen());
      case WorkForceListScreen.routeName:
        return _materialRoute(const WorkForceListScreen());
      case RejectReasonsScreen.routeName:
        return _materialRoute(const RejectReasonsScreen());
      case EditHeaderScreen.routeName:
        return _materialRoute(EditHeaderScreen());
      case WorkForceQuestionsList.routeName:
        return _materialRoute(const WorkForceQuestionsList());
      case AddImageAndCommentScreen.routeName:
        return _materialRoute(AddImageAndCommentScreen());
      case EditQuestionsScreen.routeName:
        return _materialRoute(const EditQuestionsScreen());
      default:
        return _materialRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

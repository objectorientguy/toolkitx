import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/systemUser/system_user_list_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/schedule_dates_screen.dart';
import 'package:toolkit/screens/checklist/workforce/reject_reasons.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import '../screens/checklist/systemUser/change_role_screen.dart';
import '../screens/checklist/systemUser/edit_header_screen.dart';
import '../screens/checklist/systemUser/filters_screen.dart';
import '../screens/checklist/systemUser/workforce_list_screen.dart';
import '../screens/checklist/workforce/add_image_and_comment_screen.dart';
import '../screens/checklist/workforce/list_screen.dart';
import '../screens/checklist/workforce/questions_list_screen.dart';
import '../screens/checklist/workforce/edit_questions_screen.dart';
import '../screens/checklist/checklist_list_screen.dart';
import '../screens/checklist/details_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/onboarding/client_list_screen.dart';
import '../screens/onboarding/language/select_language_screen.dart';
import '../screens/onboarding/login/login_screen.dart';
import '../screens/onboarding/login/password_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import '../screens/profile/changePassword/change_password_screen.dart';
import '../screens/profile/changePassword/select_change_password_screen.dart';
import '../screens/profile/edit/profile_edit_screen.dart';
import '../screens/permit/permit_details_screen.dart';
import '../screens/permit/permit_list_screen.dart';
import '../screens/permit/get_permit_roles_screen.dart';
import '../screens/root/root_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return _createRoute(const WelcomeScreen());
      case SelectLanguageScreen.routeName:
        return _createRoute(
            SelectLanguageScreen(isFromProfile: settings.arguments as bool));
      case SelectTimeZoneScreen.routeName:
        return _createRoute(
            SelectTimeZoneScreen(isFromProfile: settings.arguments as bool));
      case SelectDateFormatScreen.routeName:
        return _createRoute(
            SelectDateFormatScreen(isFromProfile: settings.arguments as bool));
      case LoginScreen.routeName:
        return _createRoute(LoginScreen());
      case PasswordScreen.routeName:
        return _createRoute(PasswordScreen());
      case RootScreen.routeName:
        return _createRoute(const RootScreen());
      case EditScreen.routeName:
        return _createRoute(const EditScreen());
      case SystemUserScheduleDatesScreen.routeName:
        return _createRoute(const SystemUserScheduleDatesScreen());
      case SystemUserCheckListScreen.routeName:
        return _createRoute(SystemUserCheckListScreen());
      case ProfileEditScreen.routeName:
        return _createRoute(const ProfileEditScreen());
      case DetailsScreen.routeName:
        return _createRoute(const DetailsScreen());
      case ChecklistScreen.routeName:
        return _createRoute(const ChecklistScreen());
      case ChangeRoleScreen.routeName:
        return _createRoute(const ChangeRoleScreen());
      case FiltersScreen.routeName:
        return _createRoute(FiltersScreen());
      case IncidentListScreen.routeName:
        return _createRoute(const IncidentListScreen());
      case IncidentFilterScreen.routeName:
        return _createRoute(const IncidentFilterScreen());
      case CategoryScreen.routeName:
        return _createRoute(const CategoryScreen());
      case ChecklistWorkForceListScreen.routeName:
        return _createRoute(const ChecklistWorkForceListScreen());
      case WorkForceListScreen.routeName:
        return _createRoute(const WorkForceListScreen());
      case RejectReasonsScreen.routeName:
        return _createRoute(const RejectReasonsScreen());
      case EditHeaderScreen.routeName:
        return _createRoute(EditHeaderScreen());
      case WorkForceQuestionsList.routeName:
        return _createRoute(WorkForceQuestionsList(
            checklistDataMap: settings.arguments as Map));
      case AddImageAndCommentScreen.routeName:
        return _createRoute(AddImageAndCommentScreen());
      case EditQuestionsScreen.routeName:
        return _createRoute(const EditQuestionsScreen());
      case PermitListScreen.routeName:
        return _createRoute(const PermitListScreen());
      case PermitDetailsScreen.routeName:
        return _createRoute(const PermitDetailsScreen());
      case GetPermitRolesScreen.routeName:
        return _createRoute(const GetPermitRolesScreen());
      case ClientListScreen.routeName:
        return _createRoute(const ClientListScreen());
      case SelectChangePasswordTypeScreen.routeName:
        return _createRoute(const SelectChangePasswordTypeScreen());
      case ChangePasswordScreen.routeName:
        return _createRoute(ChangePasswordScreen());
      default:
        return _createRoute(const WelcomeScreen());
    }
  }

  static Route<dynamic> _createRoute(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

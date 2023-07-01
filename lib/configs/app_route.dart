import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_list_screen.dart';
import '../data/models/permit/permit_details_model.dart';
import '../screens/checklist/systemUser/sys_user_workforce_list_screen.dart';
import '../screens/checklist/workforce/add_image_and_comments_screen.dart';
import '../screens/checklist/workforce/workforce_edit_answer_screen.dart';
import '../screens/checklist/workforce/workforce_questions_list_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_edit_header_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_checklist_list_screen.dart';
import '../screens/checklist/systemUser/sys_user_change_role_screen.dart';
import '../screens/checklist/systemUser/sys_user_schedule_dates_screen.dart';
import '../screens/checklist/systemUser/sys_user_filters_screen.dart';
import '../screens/checklist/workforce/workforce_reject_reason_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/change_role_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/onboarding/client_list_screen.dart';
import '../screens/onboarding/language/select_language_screen.dart';
import '../screens/onboarding/login/login_screen.dart';
import '../screens/onboarding/login/password_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import '../screens/onboarding/welcome_screen.dart';
import '../screens/permit/close_permit_screen.dart';
import '../screens/permit/open_permit_screen.dart';
import '../screens/permit/permit_filter_screen.dart';
import '../screens/profile/changePassword/change_password_screen.dart';
import '../screens/profile/changePassword/select_change_password_screen.dart';
import '../screens/profile/edit/profile_edit_screen.dart';
import '../screens/permit/permit_details_screen.dart';
import '../screens/permit/permit_list_screen.dart';
import '../screens/permit/get_permit_roles_screen.dart';
import '../screens/root/root_screen.dart';
import '../widgets/in_app_web_view.dart';

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
        return _createRoute(
            RootScreen(isFromClientList: settings.arguments as bool));
      case ProfileEditScreen.routeName:
        return _createRoute(const ProfileEditScreen());
      case SystemUserScheduleDatesScreen.routeName:
        return _createRoute(SystemUserScheduleDatesScreen(
            checkListId: settings.arguments.toString()));
      case SystemUserCheckListScreen.routeName:
        return _createRoute(const SystemUserCheckListScreen());
      case WorkForceListScreen.routeName:
        return _createRoute(const WorkForceListScreen());
      case ChangeRoleScreen.routeName:
        return _createRoute(const ChangeRoleScreen());
      case FiltersScreen.routeName:
        return _createRoute(const FiltersScreen());
      case EditHeaderScreen.routeName:
        return _createRoute(EditHeaderScreen());
      case IncidentListScreen.routeName:
        return _createRoute(const IncidentListScreen());
      case IncidentFilterScreen.routeName:
        return _createRoute(const IncidentFilterScreen());
      case IncidentChangeRoleScreen.routeName:
        return _createRoute(const IncidentChangeRoleScreen());
      case CategoryScreen.routeName:
        return _createRoute(const CategoryScreen());
      case PermitListScreen.routeName:
        return _createRoute(
            PermitListScreen(isFromHome: settings.arguments as bool));
      case PermitDetailsScreen.routeName:
        return _createRoute(
            PermitDetailsScreen(permitId: settings.arguments as String));
      case GetPermitRolesScreen.routeName:
        return _createRoute(const GetPermitRolesScreen());
      case PermitFilterScreen.routeName:
        return _createRoute(PermitFilterScreen());
      case ClientListScreen.routeName:
        return _createRoute(
            ClientListScreen(isFromProfile: settings.arguments as bool));
      case SelectChangePasswordTypeScreen.routeName:
        return _createRoute(const SelectChangePasswordTypeScreen());
      case ChangePasswordScreen.routeName:
        return _createRoute(ChangePasswordScreen());
      case AddImageAndCommentScreen.routeName:
        return _createRoute(AddImageAndCommentScreen(
            questionResponseId: settings.arguments.toString()));
      case SysUserWorkForceListScreen.routeName:
        return _createRoute(const SysUserWorkForceListScreen());
      case WorkForceQuestionsScreen.routeName:
        return _createRoute(WorkForceQuestionsScreen(
            checklistDataMap: settings.arguments as Map));
      case RejectReasonsScreen.routeName:
        return _createRoute(
            RejectReasonsScreen(checklistDataMap: settings.arguments as Map));
      case EditAnswerListScreen.routeName:
        return _createRoute(
            EditAnswerListScreen(checklistDataMap: settings.arguments as Map));
      case InAppWebViewScreen.routeName:
        return _createRoute(
            InAppWebViewScreen(url: settings.arguments as String));
      case ClosePermitScreen.routeName:
        return _createRoute(ClosePermitScreen(
            permitDetailsModel: settings.arguments as PermitDetailsModel));
      case OpenPermitScreen.routeName:
        return _createRoute(OpenPermitScreen(
            permitDetailsModel: settings.arguments as PermitDetailsModel));
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
              position: animation.drive(tween), child: child);
        });
  }
}

import 'package:flutter/material.dart';
import 'package:toolkit/screens/checklist/checklist_list_screen.dart';
import 'package:toolkit/screens/checklist/details_screen.dart';
import 'package:toolkit/screens/checklist/filters_screen.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_screen.dart';
import 'package:toolkit/screens/onboarding/login/password/password_screen.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'package:toolkit/screens/profile/edit/edit_screen.dart';
import '../screens/checklist/change_role_screen.dart';
import '../screens/incident/category_screen.dart';
import '../screens/incident/filter_screen.dart';
import '../screens/incident/incident_list_screen.dart';
import '../screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import '../screens/onboarding/selectLanguage/select_language_screen.dart';
import '../screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
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
        return _createRoute(const SelectLanguageScreen());
      case SelectTimeZoneScreen.routeName:
        return _createRoute(const SelectTimeZoneScreen());
      case SelectDateFormatScreen.routeName:
        return _createRoute(const SelectDateFormatScreen());
      case LoginScreen.routeName:
        return _createRoute(const LoginScreen());
      case PasswordScreen.routeName:
        return _createRoute(const PasswordScreen());
      case RootScreen.routeName:
        return _createRoute(const RootScreen());
      case EditScreen.routeName:
        return _createRoute(const EditScreen());
      case DetailsScreen.routeName:
        return _createRoute(const DetailsScreen());
      case ChecklistScreen.routeName:
        return _createRoute(const ChecklistScreen());
      case ChangeRoleScreen.routeName:
        return _createRoute(const ChangeRoleScreen());
      case FiltersScreen.routeName:
        return _createRoute(const FiltersScreen());
      case IncidentListScreen.routeName:
        return _createRoute(const IncidentListScreen());
      case IncidentFilterScreen.routeName:
        return _createRoute(const IncidentFilterScreen());
      case CategoryScreen.routeName:
        return _createRoute(const CategoryScreen());
      case PermitListScreen.routeName:
        return _createRoute(const PermitListScreen());
      case PermitDetailsScreen.routeName:
        return _createRoute(const PermitDetailsScreen());
      case GetPermitRolesScreen.routeName:
        return _createRoute(const GetPermitRolesScreen());
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/blocs/checklist/systemUser/approvePopUp/sys_user_approve_pop_up_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/pdf/sys_user_pdf_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/rejectPopUp/sys_user_reject_pop_up_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/submitHeader/header_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/thirdPartyApprove/sys_user_third_party_approve_bloc.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'blocs/client/client_bloc.dart';
import 'blocs/dateFormat/date_format_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/language/language_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/onboarding/onboarding_events.dart';
import 'blocs/onboarding/onboarding_states.dart';
import 'blocs/permit/permit_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/role/role_bloc.dart';
import 'blocs/timeZone/time_zone_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'configs/app_theme.dart';
import 'di/app_module.dart';
import 'configs/app_route.dart';
import 'screens/onboarding/login/login_screen.dart';
import 'screens/onboarding/selectDateFormat/select_date_format_screen.dart';
import 'screens/onboarding/selectTimeZone/select_time_zone_screen.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'screens/root/root_screen.dart';

void main() async {
  await _initApp();
  await _initDependencies();
  runApp(const MyApp());
}

_initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  DatabaseUtil.box = await Hive.openBox('languages_box');
}

_initDependencies() async {
  configurableDependencies();
  await getIt.isReady<SharedPreferences>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              lazy: false,
              create: (context) =>
                  WifiConnectivityBloc()..add(ObserveNetwork())),
          BlocProvider(lazy: false, create: (context) => LanguageBloc()),
          BlocProvider(lazy: false, create: (context) => DateFormatBloc()),
          BlocProvider(lazy: false, create: (context) => HomeBloc()),
          BlocProvider(lazy: false, create: (context) => PermitBloc()),
          BlocProvider(lazy: false, create: (context) => LoginBloc()),
          BlocProvider(lazy: false, create: (context) => TimeZoneBloc()),
          BlocProvider(lazy: false, create: (context) => LoginBloc()),
          BlocProvider(lazy: false, create: (context) => ClientBloc()),
          BlocProvider(lazy: false, create: (context) => ProfileBloc()),
          BlocProvider(lazy: false, create: (context) => PermitRoleBloc()),
          BlocProvider(
              lazy: false, create: (context) => SysUserCheckListBloc()),
          BlocProvider(lazy: false, create: (context) => ScheduleDatesBloc()),
          BlocProvider(
              lazy: false, create: (context) => ScheduleDatesResponseBloc()),
          BlocProvider(lazy: false, create: (context) => UserRoleBloc()),
          BlocProvider(lazy: false, create: (context) => ApproveBloc()),
          BlocProvider(lazy: false, create: (context) => RejectBloc()),
          BlocProvider(
              lazy: false, create: (context) => ThirdPartyApproveBloc()),
          BlocProvider(lazy: false, create: (context) => HeaderBloc()),
          BlocProvider(lazy: false, create: (context) => FetchPdfBloc()),
          BlocProvider(
              lazy: false,
              create: (context) => OnBoardingBloc()..add(CheckLoggedIn()))
        ],
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRoutes.onGenerateRoutes,
                theme: appTheme,
                home: BlocBuilder<WifiConnectivityBloc, WifiConnectivityState>(
                    builder: (context, state) {
                  return BlocBuilder<OnBoardingBloc, OnBoardingStates>(
                      builder: (context, state) {
                    if (state is LoggedIn) {
                      return const RootScreen(
                        isFromClientList: false,
                      );
                    } else if (state is LanguageSelected) {
                      return const SelectTimeZoneScreen();
                    } else if (state is TimeZoneSelected) {
                      return const SelectDateFormatScreen();
                    } else if (state is DateFormatSelected) {
                      return LoginScreen();
                    } else {
                      return const WelcomeScreen();
                    }
                  });
                }))));
  }
}

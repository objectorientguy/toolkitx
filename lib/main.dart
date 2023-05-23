import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/incident/incident_bloc.dart';
import 'blocs/report_new_incident/report_new_incident_bloc.dart';
import 'blocs/selectDateFormat/select_date_format_bloc.dart';
import 'blocs/selectLanguage/select_language_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_events.dart';
import 'blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'configs/app_theme.dart';
import 'di/app_module.dart';
import 'configs/app_route.dart';

void main() async {
  await _initApp();
  await _initDependencies();
  runApp(const MyApp());
}

_initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
          BlocProvider(lazy: true, create: (context) => DateFormatBloc()),
          BlocProvider(lazy: false, create: (context) => HomeBloc()),
          BlocProvider(lazy: false, create: (context) => ReportIncidentBloc()),
          BlocProvider(lazy: false, create: (context) => IncidentBloc())
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
                return const WelcomeScreen();
              })),
        ));
  }
}

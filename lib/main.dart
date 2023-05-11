import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolkit/blocs/selectDateFormat/select_date_format_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/welcome_screen.dart';
import 'blocs/selectLanguage/select_language_bloc.dart';
import 'di/app_module.dart';
import 'configs/app_route.dart';

void main() async {
  await _initApp();
  await _initDependencies();
  runApp(const MyApp());
}

_initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
}

_initDependencies() async {
  configurableDependencies();
  await getIt.isReady<SharedPreferences>();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => LanguageBloc()),
        BlocProvider(lazy: false, create: (context) => DateFormatBloc())
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            theme: appTheme,
            home: const WelcomeScreen()),
      ),
    );
  }
}

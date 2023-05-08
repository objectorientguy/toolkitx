import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/selectYourLanguage/select_your_language_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/onboarding_screen.dart';

import 'app_module.dart';

void main() async {
  await _initDependencies();
  runApp(const MyApp());
}

_initDependencies() async {
  configurableDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => LanguageBloc())
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            // onGenerateRoute: AppRoutes.(settings) => ,
            home: const OnBoardingScreen()),
      ),
    );
  }
}

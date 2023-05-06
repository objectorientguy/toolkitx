import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/login/emailAddress/login_email_screen.dart';

import 'configs/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: appBarTheme,
            scaffoldBackgroundColor: AppColor.lightestBlue),
        home: const LoginEmailScreen());
  }
}

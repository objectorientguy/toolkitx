import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/home/home_bloc.dart';
import 'package:toolkit/screens/root/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(lazy: false, create: (context) => HomeBloc())],
        child: const MaterialApp(home: RootScreen()));
  }
}

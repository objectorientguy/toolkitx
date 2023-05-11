import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolkit/blocs/home/home_bloc.dart';
import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/screens/home/widgets/date_time_section.dart';
import 'package:toolkit/screens/home/widgets/modules_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const SetDateAndTime());
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          const SizedBox(height: 25),
          SvgPicture.asset('assets/icons/toolkitx_logo.svg'),
          const SizedBox(height: 25),
          const DateAndTimeSection(),
          const SizedBox(height: 50),
          Expanded(
              child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: const SingleChildScrollView(child: ModulesGridView()),
          ))
        ],
      ),
    ));
  }
}

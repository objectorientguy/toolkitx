import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolkit/blocs/home/home_bloc.dart';
import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/screens/home/widgets/date_time_section.dart';
import 'package:toolkit/screens/home/widgets/modules_grid_layout.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const SetDateAndTime());
    context.read<HomeBloc>().add(const StartTimer());
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(kBodyMargin),
      child: Column(
        children: [
          const SizedBox(height: mediumSpacing),
          SvgPicture.asset('assets/icons/toolkitx_logo.svg'),
          const SizedBox(height: mediumSpacing),
          const DateAndTimeSection(),
          const SizedBox(height: largeSpacing),
          Expanded(
              child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: const SingleChildScrollView(child: ModulesGridLayout()),
          ))
        ],
      ),
    ));
  }
}

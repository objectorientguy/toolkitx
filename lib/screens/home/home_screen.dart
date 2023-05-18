import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolkit/blocs/home/home_bloc.dart';
import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_bloc.dart';
import 'package:toolkit/blocs/wifiConnectivity/wifi_connectivity_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/screens/home/widgets/date_time_section.dart';
import 'package:toolkit/screens/home/widgets/modules_grid_layout.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const SetDateAndTime());
    context.read<HomeBloc>().add(const StartTimer());
    return Scaffold(
        body: BlocListener<WifiConnectivityBloc, WifiConnectivityState>(
      listener: (context, state) {
        if (state is NoNetwork) {
          final snackBar = SnackBar(
            backgroundColor: AppColor.errorRed,
            duration: const Duration(days: 1),
            content: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: (_) => debugPrint(''),
              child: const Text(StringConstants.kNoInternetMessage),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is EstablishedNetwork) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: Padding(
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
      ),
    ));
  }
}
